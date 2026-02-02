// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apis.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$AuthService extends AuthService {
  _$AuthService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = AuthService;

  @override
  Future<Response<SuccessModel>> verificationSend({
    required VerificationSendReq request,
  }) {
    final Uri $url = Uri.parse('/user/user/send-otp/');
    final $body = request;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<SuccessModel, SuccessModel>($request);
  }

  @override
  Future<Response<LoginRes>> verificationVerify({
    required VerificationVerifyReq request,
  }) {
    final Uri $url = Uri.parse('/user/user/verify-otp/');
    final $body = request;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<LoginRes, LoginRes>($request);
  }

  @override
  Future<Response<SuccessModel>> registration({required RegisterReq request}) {
    final Uri $url = Uri.parse('/user/user/registration/');
    final $body = request;
    final Request $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<SuccessModel, SuccessModel>($request);
  }

  @override
  Future<Response<LoginRes>> signIn({required SignInReq request}) {
    final Uri $url = Uri.parse('/user/user/login');
    final $body = request;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<LoginRes, LoginRes>($request);
  }

  @override
  Future<Response<SuccessModel>> updatePassword({
    required ResetPasswordReq request,
  }) {
    final Uri $url = Uri.parse('/user/user/password');
    final $body = request;
    final Request $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<SuccessModel, SuccessModel>($request);
  }

  @override
  Future<Response<LoginRes>> forgotPassword({
    required ForgotPasswordReqModel request,
  }) {
    final Uri $url = Uri.parse('/user/user/forgot-password');
    final $body = request;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<LoginRes, LoginRes>($request);
  }

  @override
  Future<Response<ProfileModel>> updateProfile({
    required ProfileModel request,
    String requiresToken = 'true',
  }) {
    final Uri $url = Uri.parse('/user/user/profile/update/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final $body = request;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<ProfileModel, ProfileModel>($request);
  }

  @override
  Future<Response<UserAddress>> addressAdd({
    required UserAddress request,
    String requiresToken = 'true',
  }) {
    final Uri $url = Uri.parse('/user/address/create/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final $body = request;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<UserAddress, UserAddress>($request);
  }

  @override
  Future<Response<UserAddress>> addressUpdate({
    required int id,
    required UserAddress request,
    String requiresToken = 'true',
  }) {
    final Uri $url = Uri.parse('/user/address/update/${id}/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final $body = request;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<UserAddress, UserAddress>($request);
  }

  @override
  Future<Response<UserAddress>> addressRetrieve({
    required int id,
    String requiresToken = 'true',
  }) {
    final Uri $url = Uri.parse('/user/address/retrieve/${id}/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<UserAddress, UserAddress>($request);
  }

  @override
  Future<Response<SuccessModel>> updatePhone({
    required VerificationVerifyReq request,
    String requiresToken = 'true',
  }) {
    final Uri $url = Uri.parse('/user/user/phone-update/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final $body = request;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<SuccessModel, SuccessModel>($request);
  }

  @override
  Future<Response<LoginRes>> postRefreshToken({required LoginRes refresh}) {
    final Uri $url = Uri.parse('/user/token/refresh/');
    final $body = refresh;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<LoginRes, LoginRes>($request);
  }

  @override
  Future<Response<dynamic>> deleteAddress({
    String requiresToken = 'true',
    required int id,
  }) {
    final Uri $url = Uri.parse('/user/address/delete/${id}/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<AppVersionModel>> getVersion() {
    final Uri $url = Uri.parse('/user/app/version/1/');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<AppVersionModel, AppVersionModel>($request);
  }

  @override
  Future<Response<FCMTokenModel>> createFCMToken({
    required FCMTokenModel request,
    String requiresToken = 'true',
  }) {
    final Uri $url = Uri.parse('/user/client/device/create/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final $body = request;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<FCMTokenModel, FCMTokenModel>($request);
  }

  @override
  Future<Response<dynamic>> deleteProfile({String requiresToken = 'true'}) {
    final Uri $url = Uri.parse('/user/user/delete/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<ProfileModel>> completeRegistration({
    required ProfileModel request,
    String requiresToken = 'true',
  }) {
    final Uri $url = Uri.parse('/user/user/complete-registration/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final $body = request;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<ProfileModel, ProfileModel>($request);
  }

  @override
  Future<Response<ProfileModel>> getProfile({String requiresToken = 'true'}) {
    final Uri $url = Uri.parse('/user/user/profile/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<ProfileModel, ProfileModel>($request);
  }

  @override
  Future<Response<ProductModel>> updateTopUp({
    String requiresToken = 'true',
    required ProductModel request,
  }) {
    final Uri $url = Uri.parse('/user/payment/choise/top/update/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final $body = request;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<ProductModel, ProductModel>($request);
  }

  @override
  Future<Response<ProductModel>> updateAddressTopUp({
    String requiresToken = 'true',
    required ProductModel request,
  }) {
    final Uri $url = Uri.parse('/user/address/choise/top/update/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final $body = request;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<ProductModel, ProductModel>($request);
  }

  @override
  Future<Response<Catalog>> getSearchedProduct({
    String requiresToken = 'true',
    int? subCategoryId,
    int? brandId,
    int? countryId,
    required int page,
    int? categoryId,
    String? search,
  }) {
    final Uri $url = Uri.parse('/user/group/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'sub_category_id': subCategoryId,
      'brand_id': brandId,
      'country_id': countryId,
      'page': page,
      'category_id': categoryId,
      'search': search,
    };
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<Catalog, Catalog>($request);
  }

  @override
  Future<Response<ProductCatalogResponse>> getSearchedProductMobile({
    String requiresToken = 'true',
    int? subCategoryId,
    int? brandId,
    int? countryId,
    required int page,
    int? categoryId,
    String? search,
  }) {
    final Uri $url = Uri.parse('/user/product/mobile/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'sub_category_id': subCategoryId,
      'brand_id': brandId,
      'country_id': countryId,
      'page': page,
      'category_id': categoryId,
      'search': search,
    };
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<ProductCatalogResponse, ProductCatalogResponse>(
      $request,
    );
  }

  @override
  Future<Response<SearchModel>> productSearch({
    String requiresToken = 'true',
    required String? search,
  }) {
    final Uri $url = Uri.parse('/user/product/search/');
    final Map<String, dynamic> $params = <String, dynamic>{'search': search};
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<SearchModel, SearchModel>($request);
  }

  @override
  Future<Response<BuiltList<ProductModel>>> getRecommendation({
    String requiresToken = 'true',
  }) {
    final Uri $url = Uri.parse('/user/recommendation/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<BuiltList<ProductModel>, ProductModel>($request);
  }

  @override
  Future<Response<ProductModel>> createSearchHistory({
    String requiresToken = 'true',
    required ProductModel search,
  }) {
    final Uri $url = Uri.parse('/user/search/history/create/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final $body = search;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<ProductModel, ProductModel>($request);
  }

  @override
  Future<Response<BuiltList<ProductModel>>> getSearchHistory({
    String requiresToken = 'true',
  }) {
    final Uri $url = Uri.parse('/user/search/history/list/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<BuiltList<ProductModel>, ProductModel>($request);
  }

  @override
  Future<Response<dynamic>> deleteAllSearchHistory({
    String requiresToken = 'true',
  }) {
    final Uri $url = Uri.parse('/user/search/history/delete-all/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteSearchHistory({
    String requiresToken = 'true',
    required int id,
  }) {
    final Uri $url = Uri.parse('/user/search/history/${id}/delete/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }
}

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$MainService extends MainService {
  _$MainService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = MainService;

  @override
  Future<Response<CurrencyModel>> getCurrency({
    String requiresToken = 'optional',
  }) {
    final Uri $url = Uri.parse('/main/currency');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<CurrencyModel, CurrencyModel>($request);
  }
}

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$AssetService extends AssetService {
  _$AssetService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = AssetService;

  @override
  Future<Response<BuiltList<BannerModel>>> getBannerList() {
    final Uri $url = Uri.parse('/asset/banner/list/');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<BuiltList<BannerModel>, BannerModel>($request);
  }

  @override
  Future<Response<BuiltList<StoryModel>>> getStoryList() {
    final Uri $url = Uri.parse('/asset/story/list/');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<BuiltList<StoryModel>, StoryModel>($request);
  }

  @override
  Future<Response<InformCreateRes>> informCreate({
    String requiresToken = 'true',
    required InformModel request,
  }) {
    final Uri $url = Uri.parse('/asset/inform/create/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final $body = request;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<InformCreateRes, InformCreateRes>($request);
  }

  @override
  Future<Response<Notification>> getNotificationList({
    String requiresToken = 'true',
  }) {
    final Uri $url = Uri.parse('/asset/notification/messages/list/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<Notification, Notification>($request);
  }

  @override
  Future<Response<dynamic>> updateNotification({
    String requiresToken = 'true',
    required int id,
    required NotificationModel body,
  }) {
    final Uri $url = Uri.parse('/asset/notification/messages/${id}/update/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<Inform>> getInformList({String requiresToken = 'true'}) {
    final Uri $url = Uri.parse('/asset/inform/list/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<Inform, Inform>($request);
  }

  @override
  Future<Response<dynamic>> deleteInform({
    String requiresToken = 'true',
    required int id,
  }) {
    final Uri $url = Uri.parse('/asset/inform/${id}/delete/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteAllInform({String requiresToken = 'true'}) {
    final Uri $url = Uri.parse('/asset/inform/all/delete/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }
}

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$StoreService extends StoreService {
  _$StoreService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = StoreService;

  @override
  Future<Response<BuiltList<SetModel>>> getSetPackage() {
    final Uri $url = Uri.parse('/store/set-package/');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<BuiltList<SetModel>, SetModel>($request);
  }

  @override
  Future<Response<BuiltList<FamilyModel>>> getTenantSetPackage() {
    final Uri $url = Uri.parse('/store/tenant/set-package/');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<BuiltList<FamilyModel>, FamilyModel>($request);
  }

  @override
  Future<Response<BuiltList<ProductCategory>>> getTenantCategory() {
    final Uri $url = Uri.parse('/store/tenant/category/mobile/');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<BuiltList<ProductCategory>, ProductCategory>($request);
  }

  @override
  Future<Response<BuiltList<FilterRes>>> getCountry({
    String requiresToken = 'optional',
    int? categoryId,
  }) {
    final Uri $url = Uri.parse('/store/country/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'category_id': categoryId,
    };
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<BuiltList<FilterRes>, FilterRes>($request);
  }

  @override
  Future<Response<BuiltList<FilterRes>>> getBrandShort({
    String requiresToken = 'optional',
    required String? countryId,
    int? categoryId,
  }) {
    final Uri $url = Uri.parse('/store/brand/short/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'country_id': countryId,
      'category_id': categoryId,
    };
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<BuiltList<FilterRes>, FilterRes>($request);
  }

  @override
  Future<Response<ProductDetailModel>> getProductDetail({
    String requiresToken = 'optional',
    required int id,
  }) {
    final Uri $url = Uri.parse('/store/product-small/detail/${id}/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<ProductDetailModel, ProductDetailModel>($request);
  }

  @override
  Future<Response<Catalog>> getGroupCatalog({
    String requiresToken = 'optional',
    required int page,
    required int? categoryId,
    required String? brandId,
    required String? countryId,
    required int? setId,
  }) {
    final Uri $url = Uri.parse('/store/group/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'category_id': categoryId,
      'brand_id': brandId,
      'country_id': countryId,
      'set_id': setId,
    };
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<Catalog, Catalog>($request);
  }

  @override
  Future<Response<ProductCatalogResponse>> getProductMobile({
    String requiresToken = 'optional',
    required int page,
    required int? categoryId,
    required String? brandId,
    required String? countryId,
    required int? setId,
  }) {
    final Uri $url = Uri.parse('/store/product/mobile/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'category_id': categoryId,
      'brand_id': brandId,
      'country_id': countryId,
      'set_id': setId,
    };
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<ProductCatalogResponse, ProductCatalogResponse>(
      $request,
    );
  }

  @override
  Future<Response<BuiltList<ProductModel>>> getCategory({
    String requiresToken = 'optional',
  }) {
    final Uri $url = Uri.parse('/store/category/mobile/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<BuiltList<ProductModel>, ProductModel>($request);
  }

  @override
  Future<Response<BuiltList<CategoryListModel>>> getCategoryCluster({
    String requiresToken = 'optional',
  }) {
    final Uri $url = Uri.parse('/store/category/cluster/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<BuiltList<CategoryListModel>, CategoryListModel>(
      $request,
    );
  }

  @override
  Future<Response<CurrencyModel>> promocodeValidate({
    String requiresToken = 'true',
    required OrderReq request,
  }) {
    final Uri $url = Uri.parse('/store/promocode/validate/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final $body = request;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<CurrencyModel, CurrencyModel>($request);
  }

  @override
  Future<Response<Catalog>> getSearchedProduct({
    String requiresToken = 'optional',
    int? subCategoryId,
    int? brandId,
    int? countryId,
    required int page,
    int? categoryId,
    String? search,
  }) {
    final Uri $url = Uri.parse('/store/group/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'sub_category_id': subCategoryId,
      'brand_id': brandId,
      'country_id': countryId,
      'page': page,
      'category_id': categoryId,
      'search': search,
    };
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<Catalog, Catalog>($request);
  }

  @override
  Future<Response<ProductCatalogResponse>> getSearchedProductMobile({
    String requiresToken = 'optional',
    int? subCategoryId,
    int? brandId,
    int? countryId,
    required int page,
    int? categoryId,
    String? search,
  }) {
    final Uri $url = Uri.parse('/store/product/mobile/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'sub_category_id': subCategoryId,
      'brand_id': brandId,
      'country_id': countryId,
      'page': page,
      'category_id': categoryId,
      'search': search,
    };
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<ProductCatalogResponse, ProductCatalogResponse>(
      $request,
    );
  }

  @override
  Future<Response<SearchModel>> productSearch({
    String requiresToken = 'optional',
    required String? search,
  }) {
    final Uri $url = Uri.parse('/store/product/search/');
    final Map<String, dynamic> $params = <String, dynamic>{'search': search};
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<SearchModel, SearchModel>($request);
  }

  @override
  Future<Response<BuiltList<ProductModel>>> getRecommendation({
    String requiresToken = 'optional',
  }) {
    final Uri $url = Uri.parse('/store/recommendation/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<BuiltList<ProductModel>, ProductModel>($request);
  }

  @override
  Future<Response<ProductModel>> createSearchHistory({
    String requiresToken = 'optional',
    required ProductModel search,
  }) {
    final Uri $url = Uri.parse('/store/search/history/create/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final $body = search;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<ProductModel, ProductModel>($request);
  }

  @override
  Future<Response<BuiltList<ProductModel>>> getSearchHistory({
    String requiresToken = 'optional',
  }) {
    final Uri $url = Uri.parse('/store/search/history/list/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<BuiltList<ProductModel>, ProductModel>($request);
  }

  @override
  Future<Response<dynamic>> deleteAllSearchHistory({
    String requiresToken = 'true',
  }) {
    final Uri $url = Uri.parse('/store/search/history/delete-all/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteSearchHistory({
    String requiresToken = 'true',
    required int id,
  }) {
    final Uri $url = Uri.parse('/store/search/history/${id}/delete/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<OrderReq>> createWish({
    String requiresToken = 'true',
    required OrderReq request,
  }) {
    final Uri $url = Uri.parse('/store/product/wish/create/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final $body = request;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<OrderReq, OrderReq>($request);
  }

  @override
  Future<Response<BuiltList<SectionModel>>> getSectionList({
    String requiresToken = 'optional',
  }) {
    final Uri $url = Uri.parse('/store/section/list/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<BuiltList<SectionModel>, SectionModel>($request);
  }

  @override
  Future<Response<SectionModel>> getSectionById({
    String requiresToken = 'optional',
    required int id,
  }) {
    final Uri $url = Uri.parse('/store/section/${id}/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<SectionModel, SectionModel>($request);
  }
}

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$OrderService extends OrderService {
  _$OrderService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = OrderService;

  @override
  Future<Response<OrderModel>> getDraft({String requiresToken = 'true'}) {
    final Uri $url = Uri.parse('/order/draft/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<OrderModel, OrderModel>($request);
  }

  @override
  Future<Response<MonitoringModel>> getMonitoring({
    String requiresToken = 'true',
    required String dateFrom,
    required String dateTo,
  }) {
    final Uri $url = Uri.parse('/order/monitoring/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'date_from': dateFrom,
      'date_to': dateTo,
    };
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<MonitoringModel, MonitoringModel>($request);
  }

  @override
  Future<Response<SuccessModel>> getPlannedSoon({
    String requiresToken = 'true',
  }) {
    final Uri $url = Uri.parse('/order/planned-soon/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<SuccessModel, SuccessModel>($request);
  }

  @override
  Future<Response<ProductModelResponse>> getTopItems({
    String requiresToken = 'optional',
    int? page,
    int limit = 60,
  }) {
    final Uri $url = Uri.parse('/order/top-items/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<ProductModelResponse, ProductModelResponse>($request);
  }

  @override
  Future<Response<BuiltList<ProductModel>>> getDeliveryPrice({
    String requiresToken = 'true',
    int? addressId,
  }) {
    final Uri $url = Uri.parse('/order/delivery/price/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'address_id': addressId,
    };
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<BuiltList<ProductModel>, ProductModel>($request);
  }

  @override
  Future<Response<OrderModel>> postOrderCreate({
    String requiresToken = 'true',
    required OrderReq request,
  }) {
    final Uri $url = Uri.parse('/order/draft/create/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final $body = request;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<OrderModel, OrderModel>($request);
  }

  @override
  Future<Response<SuccessModel>> putOrder({
    String requiresToken = 'true',
    required OrderReq request,
    required int id,
  }) {
    final Uri $url = Uri.parse('/order/${id}/update/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final $body = request;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<SuccessModel, SuccessModel>($request);
  }

  @override
  Future<Response<OrderStatusRes>> status({
    String requiresToken = 'true',
    required int id,
  }) {
    final Uri $url = Uri.parse('/order/status/${id}/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<OrderStatusRes, OrderStatusRes>($request);
  }

  @override
  Future<Response<BuiltList<OrderModel>>> getHistory({
    String requiresToken = 'true',
  }) {
    final Uri $url = Uri.parse('/order/history/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<BuiltList<OrderModel>, OrderModel>($request);
  }

  @override
  Future<Response<BuiltList<OrderModel>>> getActiveList({
    String requiresToken = 'true',
  }) {
    final Uri $url = Uri.parse('/order/active/list/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<BuiltList<OrderModel>, OrderModel>($request);
  }

  @override
  Future<Response<BuiltList<ModifiedModel>>> getDraftCheckAvailability({
    String requiresToken = 'true',
  }) {
    final Uri $url = Uri.parse('/order/draft/check-availability/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<BuiltList<ModifiedModel>, ModifiedModel>($request);
  }

  @override
  Future<Response<OrderModel>> postRepeat({
    String requiresToken = 'true',
    required OrderModel request,
  }) {
    final Uri $url = Uri.parse('/order/repeat/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final $body = request;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<OrderModel, OrderModel>($request);
  }

  @override
  Future<Response<OrderModel>> getOrderItem({
    String requiresToken = 'true',
    required int id,
  }) {
    final Uri $url = Uri.parse('/order/${id}/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<OrderModel, OrderModel>($request);
  }

  @override
  Future<Response<PlannedOrderModel>> createPlannedOrder({
    String requiresToken = 'true',
    required PlannedOrderModel request,
  }) {
    final Uri $url = Uri.parse('/order/cyclic-order/create/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final $body = request;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<PlannedOrderModel, PlannedOrderModel>($request);
  }

  @override
  Future<Response<PlannedOrderModel>> updatePlannedOrder({
    String requiresToken = 'true',
    required int id,
    required PlannedOrderModel request,
  }) {
    final Uri $url = Uri.parse('/order/cyclic-order/${id}/update/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final $body = request;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<PlannedOrderModel, PlannedOrderModel>($request);
  }

  @override
  Future<Response<PlannedOrderModel>> addToPlannedOrder({
    String requiresToken = 'true',
    required int id,
    required PlannedOrderModel request,
  }) {
    final Uri $url = Uri.parse('/order/cyclic-order/${id}/add/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final $body = request;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<PlannedOrderModel, PlannedOrderModel>($request);
  }

  @override
  Future<Response<PlannedOrderListModel>> getPlannedOrderList({
    String requiresToken = 'true',
  }) {
    final Uri $url = Uri.parse('/order/cyclic-order/list/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<PlannedOrderListModel, PlannedOrderListModel>($request);
  }

  @override
  Future<Response<PlannedOrderModel>> getPlannedOrderDetail({
    String requiresToken = 'true',
    required int id,
  }) {
    final Uri $url = Uri.parse('/order/cyclic-order/${id}/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<PlannedOrderModel, PlannedOrderModel>($request);
  }

  @override
  Future<Response<PlannedOrderModel>> updatePlannedOrderStatus({
    String requiresToken = 'true',
    required int id,
    required PlannedOrderModel request,
  }) {
    final Uri $url = Uri.parse('/order/cyclic-order/status/${id}/update/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final $body = request;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<PlannedOrderModel, PlannedOrderModel>($request);
  }

  @override
  Future<Response<dynamic>> deletePlannedOrder({
    String requiresToken = 'true',
    required int id,
  }) {
    final Uri $url = Uri.parse('/order/cyclic-order/${id}/delete/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }
}

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$PaymentService extends PaymentService {
  _$PaymentService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = PaymentService;

  @override
  Future<Response<CardModel>> createCard({
    String requiresToken = 'true',
    required CardModel request,
  }) {
    final Uri $url = Uri.parse('/payment/card/create/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final $body = request;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<CardModel, CardModel>($request);
  }

  @override
  Future<Response<CardModel>> verifyCard({
    String requiresToken = 'true',
    required CardModel request,
  }) {
    final Uri $url = Uri.parse('/payment/card/verify/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final $body = request;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<CardModel, CardModel>($request);
  }

  @override
  Future<Response<dynamic>> deleteCard({
    String requiresToken = 'true',
    required int id,
  }) {
    final Uri $url = Uri.parse('/payment/card/delete/${id}/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }
}

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$PremiumService extends PremiumService {
  _$PremiumService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = PremiumService;

  @override
  Future<Response<SubscriptionReq>> postSubscriptionCreate({
    String requiresToken = 'true',
    required SubscriptionReq request,
  }) {
    final Uri $url = Uri.parse('/premium/buy/subscription/');
    final Map<String, String> $headers = {'requires-token': requiresToken};
    final $body = request;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<SubscriptionReq, SubscriptionReq>($request);
  }
}
