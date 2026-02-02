part of 'main_bloc.dart';

@immutable
@freezed
class MainState with _$MainState {
  const MainState._();

  const factory MainState({
    @Default([]) List<BannerModel> bannerList,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus statusBanner,
    @Default([]) List<SetModel> setList,
    @Default([]) List<FamilyModel> tenantSetList,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus statusSet,
    @Default([]) List<StoryModel> storyList,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus statusStory,
    @Default([]) List<FilterRes> countryList,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus statusCountry,
    @Default([]) List<FilterRes> brandList,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus statusBrand,
    @Default([]) List<NotificationModel> notificationList,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus statusNotification,
    @Default([]) List<InformRes> listInform,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus statusInform,
    @Default([]) List<ProductCategory> tenantCategoryList,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus statusTenantCategory,
    

  }) = _MainState;
}
