part of 'profile_bloc.dart';

@immutable
@freezed
class ProfileState with _$ProfileState {
  const ProfileState._();

  const factory ProfileState({
    @Default(0) double totalAmount,
    @Default(0) double previousTotalAmount,
    @Default(null) int? draftId,
    @Default([]) List<ProductModel> draftList,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus statusDraft,
    @Default(null) ProfileModel? profile,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus statusProfile,
    @Default(null) CurrencyModel? promocode,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus statusPromocde,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus statusProfileUpdate,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus statusHistory,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus statusActiveList,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus statusItem,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus statusCard,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus statusVerify,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus statusPlanned,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus statusDraftCheck,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus statusVersion,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus statusPrice,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus statusPlannedOrders,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus statusPlannedOrderDetail,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus statusTopItems,
    @Default(null) OrderStatusRes? statusModel,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus statusOrder,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus statusOrderStatus,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus statusOrderItem,
    @Default([]) List<OrderModel> historyList,
    @Default([]) List<OrderModel> activeList,
    @Default([]) List<ProductModel> topItems,
    @Default(null) OrderModel? orderModel,
    @Default(null) CardModel? card,
    @Default(null) SuccessModel? plannedSoonModel,
    @Default(false) bool langChanged,
    @Default([]) List<ProductModel> deliveryPrices,
    @Default(null) AppVersionModel? version,
    @Default(null) double? price,
    @Default(null) OrderStatusRes? orderStatus,
    @Default(null) OrderModel? orderItem,
    @Default([]) List<ModifiedModel> checkDraft,
    @Default([]) List<OrderModel> history,
    @Default(null) SuccessModel? plan,
    @Default([]) List<PlannedOrderModel> plannedOrderList,
    @Default(null) PlannedOrderModel? plannedOrderModel,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus statusPlannedOrder,
    @Default(null) PlannedOrderModel? plannedOrderDetail,
    @Default([]) List<PlannedOrderModel> plannedOrders,
    @Default(false) bool isFirstOrder,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus statusMonitoring,
    MonitoringModel? monitoring,

    // Section state
    @Default([]) List<SectionModel> sections,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus statusSections,
    @Default(null) SectionModel? currentSection,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus statusCurrentSection,

    // Basket navigation state
    @Default('') String currentPage,
  }) = _ProfileState;
}
