part of 'banner_bloc.dart';

class BannerState extends Equatable {
  final Status2 status;
  final Status2 detailsStatus;
  final BannerModel? bannerModel;
  final BannerDetailsModel? bannerDetailsModel;
  final String? errorMessage;

  const BannerState({
    this.status = Status2.initial,
    this.detailsStatus = Status2.initial,
    this.bannerModel,
    this.bannerDetailsModel,
    this.errorMessage,
  });

  BannerState copyWith({
    Status2? status,
    Status2? detailsStatus,
    BannerModel? bannerModel,
    BannerDetailsModel? bannerDetailsModel,
    String? errorMessage,
  }) {
    return BannerState(
      status: status ?? this.status,
      detailsStatus: detailsStatus ?? this.detailsStatus,
      bannerModel: bannerModel ?? this.bannerModel,
      bannerDetailsModel: bannerDetailsModel ?? this.bannerDetailsModel,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        detailsStatus,
        bannerModel,
        bannerDetailsModel,
        errorMessage,
      ];
}
