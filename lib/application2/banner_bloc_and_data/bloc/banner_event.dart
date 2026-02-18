part of 'banner_bloc.dart';

abstract class BannerEvent extends Equatable {
  const BannerEvent();

  @override
  List<Object?> get props => [];
}

class GetBannersEvent extends BannerEvent {}

class GetBannerDetailsEvent extends BannerEvent {
  final String id;
  const GetBannerDetailsEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
