part of 'express_bloc.dart';

abstract class ExpressClientEvent extends Equatable {
  const ExpressClientEvent();
  @override
  List<Object?> get props => [];
}

class LoadExpressProvincesEvent extends ExpressClientEvent {
  final String? regionId;
  const LoadExpressProvincesEvent({this.regionId});
  @override
  List<Object?> get props => [regionId];
}

class LoadExpressDistrictsEvent extends ExpressClientEvent {
  final String provinceId;
  const LoadExpressDistrictsEvent({required this.provinceId});
  @override
  List<Object?> get props => [provinceId];
}

class GetExpressCategoriesEvent extends ExpressClientEvent {
  final String provinceId;
  const GetExpressCategoriesEvent({required this.provinceId});
  @override
  List<Object?> get props => [provinceId];
}

class StartExpressSearchEvent extends ExpressClientEvent {
  final String categoryId;
  final String provinceId;
  final String? districtId;
  final double latitude;
  final double longitude;
  final String paymentMethod;

  const StartExpressSearchEvent({
    required this.categoryId,
    required this.provinceId,
    this.districtId,
    required this.latitude,
    required this.longitude,
    required this.paymentMethod,
  });

  @override
  List<Object?> get props => [
        categoryId,
        provinceId,
        districtId,
        latitude,
        longitude,
        paymentMethod,
      ];
}

class CancelExpressSearchEvent extends ExpressClientEvent {
  final String sessionId;
  const CancelExpressSearchEvent({required this.sessionId});
  @override
  List<Object?> get props => [sessionId];
}

class PollExpressStatusEvent extends ExpressClientEvent {
  final String sessionId;
  const PollExpressStatusEvent({required this.sessionId});
  @override
  List<Object?> get props => [sessionId];
}

class ExpressMatchedEvent extends ExpressClientEvent {
  final ExpressMatchedModel matched;
  const ExpressMatchedEvent({required this.matched});
  @override
  List<Object?> get props => [matched];
}

class ExpressNoMastersEvent extends ExpressClientEvent {}

class ResetExpressClientEvent extends ExpressClientEvent {}

/// Faqat qidiruv natijasini tozalaydi (session/matched/error/status),
/// lekin yuklangan viloyat/tuman/kategoriya ro'yxatlarini saqlaydi.
/// "Qayta qidirish" tugmasi uchun ishlatiladi.
class ClearSearchResultEvent extends ExpressClientEvent {}
