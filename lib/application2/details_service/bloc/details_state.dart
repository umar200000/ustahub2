part of 'details_bloc.dart';

class DetailsState extends Equatable {
  final Status2 status;
  final DetailsServiceModel? detailsServiceModel;
  final String? errorMessage;

  const DetailsState({
    this.status = Status2.initial,
    this.detailsServiceModel,
    this.errorMessage,
  });

  DetailsState copyWith({
    Status2? status,
    DetailsServiceModel? detailsServiceModel,
    String? errorMessage,
  }) {
    return DetailsState(
      status: status ?? this.status,
      detailsServiceModel: detailsServiceModel ?? this.detailsServiceModel,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, detailsServiceModel, errorMessage];
}
