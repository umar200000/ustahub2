part of 'main_bloc.dart';

@freezed
abstract class MainEvent with _$MainEvent {
  const factory MainEvent.getCurrency() = _GetCurrency;
  const factory MainEvent.getBannerList() = _GetBannerList;
  const factory MainEvent.getSetPackage() = _GetSetPackage;
  const factory MainEvent.getTenantSetPackage() = _GetTenantSetPackage;
  const factory MainEvent.getStoryList() = _GetStoryList;
  const factory MainEvent.getBrandShort({List<String>? countries, int? categoryId}) = _GetBrandShort;
  const factory MainEvent.getCountry({int? categoryId}) = _GetCountry;
  const factory MainEvent.getNotificationList() = _GetNotificationList;
  const factory MainEvent.updateNotification({required int id}) = _UpdateNotification;
  const factory MainEvent.getInformList() = _GetInformList;
  const factory MainEvent.getTenantCategory() = _GetTenantCategory;
}
