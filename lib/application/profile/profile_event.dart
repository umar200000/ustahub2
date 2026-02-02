part of 'profile_bloc.dart';

@freezed
abstract class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.recreateState({required ProfileState? state}) = _RecreateState;

  const factory ProfileEvent.addProduct({
    required ProductModel product,
    required bool isIncrease,
    required void Function(List<ProductModel> draftList, double totalAmount) onLogicComplete,
  }) = _AddProduct;

  const factory ProfileEvent.updateImmediateState({
    required List<ProductModel> draftList,
    required double totalAmount,
    required bool isInProgress,
  }) = _UpdateImmediateState;

  const factory ProfileEvent.createProduct({required OrderReq request}) = _CreateProduct;

  const factory ProfileEvent.getProducts() = _GetProducts;

  const factory ProfileEvent.clearProducts() = _ClearProducts;

  const factory ProfileEvent.getProfile({VoidCallback? onDone}) = _GetProfile;

  const factory ProfileEvent.getTopItems() = _GetTopItems;

  const factory ProfileEvent.getRecommendation() = _GetRecommendation;

  const factory ProfileEvent.profileUpdate({required ProfileModel request, required VoidCallback onDone}) = _ProfileUpdate;

  const factory ProfileEvent.promocodeValidate({required OrderReq request, required VoidCallback onDone}) = _PromocodeValidate;

  const factory ProfileEvent.clearPromocode() = _ClearPromocode;

  const factory ProfileEvent.putOrder({required OrderReq request, required VoidCallback onDone, required int draftId}) =
      _PutOrder;

  const factory ProfileEvent.addressAdd({required UserAddress request, required VoidCallback onDone}) = _AddressAdd;

  const factory ProfileEvent.addressUpdate({required int id, required UserAddress request, required VoidCallback onDone}) =
      _AddressUpdate;

  const factory ProfileEvent.addressRetrieve({required int id, required void Function(UserAddress address) onSuccess}) =
      _AddressRetrieve;

  const factory ProfileEvent.status({required int id}) = _Status;

  const factory ProfileEvent.getHistory() = _GetHistory;

  const factory ProfileEvent.getActiveList() = _GetActiveList;

  const factory ProfileEvent.getDraftCheckAvailability({required void Function(List<ModifiedModel> data) onDone}) =
      _GetDraftCheckAvailability;

  const factory ProfileEvent.postRepeat({required void Function() onDone, required OrderModel request}) = _PostRepeat;

  const factory ProfileEvent.getOrderItem({required int id}) = _GetOrderItem;

  const factory ProfileEvent.createCard({required CardModel request, required VoidCallback onDone}) = _CreateCard;

  const factory ProfileEvent.verifyCard({required CardModel request, required VoidCallback onDone}) = _VerifyCard;

  const factory ProfileEvent.updateTopUp({required ProductModel request, required VoidCallback onDone}) = _UpdateTopUp;

  const factory ProfileEvent.updateAddressTopUp({required ProductModel request, required VoidCallback onDone}) =
      _UpdateAddressTopUp;

  const factory ProfileEvent.getSubscriptionList() = _GetSubscriptionList;

  const factory ProfileEvent.postSubscriptionCreate({required SubscriptionReq request, required VoidCallback onDone}) =
      _PostSubscriptionCreate;

  const factory ProfileEvent.deleteProfile({required VoidCallback onDone}) = _DeleteProfile;

  const factory ProfileEvent.getPlannedSoon() = _GetPlannedSoon;

  const factory ProfileEvent.deleteAddress({required int id, required VoidCallback onDone}) = _DeleteAddress;

  const factory ProfileEvent.deleteCard({required int id, required VoidCallback onDone}) = _DeleteCard;

  const factory ProfileEvent.changeLang() = _ChangeLang;

  const factory ProfileEvent.getVersion() = _GetVersion;

  const factory ProfileEvent.getDeliveryPrice({int? addressId, VoidCallback? onDone}) = _GetDeliveryPrice;

  const factory ProfileEvent.createFCMToken({required FCMTokenModel request, required VoidCallback onDone}) = _CreateFCMToken;

  // Planned order events
  const factory ProfileEvent.getPlannedOrderList() = _GetPlannedOrderList;

  const factory ProfileEvent.getPlannedOrderDetail({required int id}) = _GetPlannedOrderDetail;

  const factory ProfileEvent.clearPlannedOrderDetail() = _ClearPlannedOrderDetail;

  const factory ProfileEvent.createPlannedOrder({required PlannedOrderModel request, required VoidCallback onDone}) =
      _CreatePlannedOrder;

  const factory ProfileEvent.updatePlannedOrder({
    required PlannedOrderModel request,
    required int id,
    required VoidCallback onDone,
  }) = _UpdatePlannedOrder;

  const factory ProfileEvent.addToPlannedOrder({
    required PlannedOrderModel request,
    required int id,
    required VoidCallback onDone,
  }) = _AddToPlannedOrder;

  const factory ProfileEvent.updatePlannedOrderStatus({required int id, required VoidCallback onDone, required bool isActive}) =
      _UpdatePlannedOrderStatus;

  const factory ProfileEvent.deletePlannedOrder({required int id, required VoidCallback onDone}) = _DeletePlannedOrder;

  const factory ProfileEvent.getMonitoring({required String dateFrom, required String dateTo}) = _GetMonitoring;

  const factory ProfileEvent.changePageStatus({required String status}) = _ChangePageStatus;

  // Section events
  const factory ProfileEvent.getSectionList() = _GetSectionList;

  const factory ProfileEvent.getSectionById({required int id}) = _GetSectionById;
}
