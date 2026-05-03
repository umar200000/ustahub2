import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../infrastructure/services/enum_status/status_enum.dart';
import '../../../infrastructure/services/test_mode/test_mode_service.dart';
import '../../../infrastructure2/common/error_helper.dart';
import '../data/model/card_model.dart';
import '../data/repo/card_repo.dart';

part 'card_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  final CardRepo _cardRepo = CardRepo();

  // Test rejimida birinchi GetCards chaqirig'ida default mock karta
  // qo'shilgani-yo'qligini eslab qoladi (qayta-qayta qo'shilmasin uchun).
  bool _testCardPreloaded = false;

  CardBloc() : super(const CardState()) {
    on<GetCardsEvent>(_onGetCards);
    on<BindCardEvent>(_onBindCard);
    on<ConfirmCardEvent>(_onConfirmCard);
    on<DeleteCardEvent>(_onDeleteCard);
  }

  Future<void> _onGetCards(
    GetCardsEvent event,
    Emitter<CardState> emit,
  ) async {
    emit(state.copyWith(listStatus: Status2.loading));

    // ── TEST REJIMI ── lokal kartalarni qaytaramiz, backend ga so'rov yo'q.
    // Birinchi marta default mock karta avtomatik qo'shiladi.
    if (TestMode.isOn) {
      await Future.delayed(const Duration(milliseconds: 200));
      if (!_testCardPreloaded) {
        _testCardPreloaded = true;
        final defaultCard = CardItem(
          id: 'test-card-default',
          cardNumber: "8600 1234 5678 1234",
          cardType: "uzcard",
          cardHolder: "TEST USER",
          isDefault: true,
          isActive: true,
          createdAt: DateTime.now().toIso8601String(),
        );
        emit(
          state.copyWith(
            listStatus: Status2.success,
            cards: [defaultCard, ...state.cards],
          ),
        );
        return;
      }
      emit(state.copyWith(listStatus: Status2.success));
      return;
    }

    try {
      final response = await _cardRepo.getCards();

      if (response.statusCode == 200) {
        final cardList = CardListResponse.fromJson(response.data);

        if (cardList.success == true) {
          emit(
            state.copyWith(
              listStatus: Status2.success,
              cards: cardList.data ?? [],
            ),
          );
        } else {
          emit(
            state.copyWith(
              listStatus: Status2.error,
              errorMessage: extractFromResponseData(response.data),
            ),
          );
        }
      }
    } on DioException catch (e) {
      emit(
        state.copyWith(
          listStatus: Status2.error,
          errorMessage: extractErrorMessage(e),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          listStatus: Status2.error,
          errorMessage: extractErrorMessage(e),
        ),
      );
    }
  }

  Future<void> _onBindCard(
    BindCardEvent event,
    Emitter<CardState> emit,
  ) async {
    emit(state.copyWith(bindStatus: Status2.loading));

    // ── TEST REJIMI ── soxta transactionId, telefon, OTP qadamiga o'tamiz
    if (TestMode.isOn) {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(
        state.copyWith(
          bindStatus: Status2.success,
          transactionId:
              DateTime.now().millisecondsSinceEpoch.remainder(2147483647),
          phone: "+998 ** *** ** **",
          successMessage: "OTP yuborildi",
        ),
      );
      return;
    }

    try {
      final response = await _cardRepo.bindCard(
        cardNumber: event.cardNumber,
        expiry: event.expiry,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final bindResponse = BindCardResponse.fromJson(response.data);

        if (bindResponse.success == true) {
          emit(
            state.copyWith(
              bindStatus: Status2.success,
              transactionId: bindResponse.data?.transactionId,
              phone: bindResponse.data?.phone,
              successMessage: bindResponse.message,
            ),
          );
        } else {
          emit(
            state.copyWith(
              bindStatus: Status2.error,
              errorMessage: extractFromResponseData(response.data),
            ),
          );
        }
      }
    } on DioException catch (e) {
      emit(
        state.copyWith(
          bindStatus: Status2.error,
          errorMessage: extractErrorMessage(e),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          bindStatus: Status2.error,
          errorMessage: extractErrorMessage(e),
        ),
      );
    }
  }

  Future<void> _onConfirmCard(
    ConfirmCardEvent event,
    Emitter<CardState> emit,
  ) async {
    emit(state.copyWith(confirmStatus: Status2.loading));

    // ── TEST REJIMI ── faqat "000000" qabul qilinadi
    if (TestMode.isOn) {
      await Future.delayed(const Duration(milliseconds: 400));
      if (event.otp != "000000") {
        emit(
          state.copyWith(
            confirmStatus: Status2.error,
            errorMessage: "Kod xato kiritildi",
          ),
        );
        return;
      }
      final id = 'test-card-${DateTime.now().millisecondsSinceEpoch}';
      final newCard = CardItem(
        id: id,
        cardNumber:
            "**** **** **** ${1000 + (DateTime.now().millisecond % 9000)}",
        cardType: state.cards.isEmpty ? "uzcard" : "humo",
        cardHolder: "TEST USER",
        isDefault: state.cards.isEmpty,
        isActive: true,
        createdAt: DateTime.now().toIso8601String(),
      );
      emit(
        state.copyWith(
          confirmStatus: Status2.success,
          cards: [...state.cards, newCard],
          successMessage: "Karta muvaffaqiyatli qo'shildi",
        ),
      );
      return;
    }

    try {
      final response = await _cardRepo.confirmCard(
        transactionId: event.transactionId,
        otp: event.otp,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final confirmResponse = ConfirmCardResponse.fromJson(response.data);

        if (confirmResponse.success == true) {
          emit(
            state.copyWith(
              confirmStatus: Status2.success,
              successMessage: confirmResponse.message,
            ),
          );
        } else {
          emit(
            state.copyWith(
              confirmStatus: Status2.error,
              errorMessage: extractFromResponseData(response.data),
            ),
          );
        }
      }
    } on DioException catch (e) {
      emit(
        state.copyWith(
          confirmStatus: Status2.error,
          errorMessage: extractErrorMessage(e),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          confirmStatus: Status2.error,
          errorMessage: extractErrorMessage(e),
        ),
      );
    }
  }

  Future<void> _onDeleteCard(
    DeleteCardEvent event,
    Emitter<CardState> emit,
  ) async {
    emit(state.copyWith(deleteStatus: Status2.loading));

    // ── TEST REJIMI ── lokal listdan olib tashlash
    if (TestMode.isOn) {
      await Future.delayed(const Duration(milliseconds: 300));
      final updated = state.cards.where((c) => c.id != event.cardId).toList();
      emit(
        state.copyWith(
          deleteStatus: Status2.success,
          cards: updated,
          successMessage: "Karta o'chirildi",
        ),
      );
      return;
    }

    try {
      final response = await _cardRepo.deleteCard(cardId: event.cardId);

      if (response.statusCode == 200) {
        final deleteResponse = DeleteCardResponse.fromJson(response.data);

        if (deleteResponse.success == true) {
          // Kartani listdan olib tashlaymiz
          final updatedCards =
              state.cards.where((c) => c.id != event.cardId).toList();

          emit(
            state.copyWith(
              deleteStatus: Status2.success,
              cards: updatedCards,
              successMessage: deleteResponse.message,
            ),
          );
        } else {
          emit(
            state.copyWith(
              deleteStatus: Status2.error,
              errorMessage: extractFromResponseData(response.data),
            ),
          );
        }
      }
    } on DioException catch (e) {
      emit(
        state.copyWith(
          deleteStatus: Status2.error,
          errorMessage: extractErrorMessage(e),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          deleteStatus: Status2.error,
          errorMessage: extractErrorMessage(e),
        ),
      );
    }
  }
}
