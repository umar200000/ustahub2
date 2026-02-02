import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:chopper/chopper.dart';
// import 'package:http/http.dart' show MultipartFile, Client;
import 'package:http/http.dart' show Client;
import 'package:ustahub/domain/common/token.dart';
import 'package:ustahub/domain/models/auth/auth.dart';
import 'package:ustahub/domain/models/home/home_model.dart';
import 'package:ustahub/domain/models/main/main_model.dart';
import 'package:ustahub/domain/models/notification/notification_model.dart';
import 'package:ustahub/domain/models/product/product_model.dart';
import 'package:ustahub/domain/models/success_model/success_model.dart';
import 'package:ustahub/domain/serializers/built_value_converter.dart';
import 'package:ustahub/infrastructure/core/exceptions.dart';
import 'package:ustahub/infrastructure/core/interceptors.dart';
import 'package:ustahub/infrastructure/repositories/auth_repo.dart';
import 'package:ustahub/infrastructure/services/local_database/db_service.dart';
import 'package:ustahub/infrastructure/services/log_service.dart';
import 'package:ustahub/utils/constants.dart';

part 'apis.chopper.dart';

/// Service for handling authentication-related API calls
@ChopperApi(baseUrl: '/user/')
@pragma('vm:entry-point')
abstract class AuthService extends ChopperService {
  @Post(path: 'user/send-otp/')
  Future<Response<SuccessModel>> verificationSend({
    @Body() required VerificationSendReq request,
  });

  @Post(path: 'user/verify-otp/')
  Future<Response<LoginRes>> verificationVerify({
    @Body() required VerificationVerifyReq request,
  });

  @Put(path: 'user/registration/')
  Future<Response<SuccessModel>> registration({
    @Body() required RegisterReq request,
  });

  @Post(path: 'user/login')
  Future<Response<LoginRes>> signIn({@Body() required SignInReq request});

  @Put(path: 'user/password')
  Future<Response<SuccessModel>> updatePassword({
    @Body() required ResetPasswordReq request,
  });

  @Post(path: 'user/forgot-password')
  Future<Response<LoginRes>> forgotPassword({
    @Body() required ForgotPasswordReqModel request,
  });

  @Patch(path: 'user/profile/update/')
  Future<Response<ProfileModel>> updateProfile({
    @Body() required ProfileModel request,
    @Header('requires-token') String requiresToken = 'true',
  });

  @Post(path: 'address/create/')
  Future<Response<UserAddress>> addressAdd({
    @Body() required UserAddress request,
    @Header('requires-token') String requiresToken = 'true',
  });

  @Put(path: 'address/update/{id}/')
  Future<Response<UserAddress>> addressUpdate({
    @Path('id') required int id,
    @Body() required UserAddress request,
    @Header('requires-token') String requiresToken = 'true',
  });

  @Get(path: 'address/retrieve/{id}/')
  Future<Response<UserAddress>> addressRetrieve({
    @Path('id') required int id,
    @Header('requires-token') String requiresToken = 'true',
  });

  @Post(path: 'user/phone-update/')
  Future<Response<SuccessModel>> updatePhone({
    @Body() required VerificationVerifyReq request,
    @Header('requires-token') String requiresToken = 'true',
  });

  @Post(path: 'token/refresh/')
  Future<Response<LoginRes>> postRefreshToken({
    @Body() required LoginRes refresh,
  });

  @Delete(path: 'address/delete/{id}/')
  Future<Response<dynamic>> deleteAddress({
    @Header('requires-token') String requiresToken = 'true',
    @Path('id') required int id,
  });

  @Get(path: 'app/version/1/')
  Future<Response<AppVersionModel>> getVersion();

  @Post(path: 'client/device/create/')
  Future<Response<FCMTokenModel>> createFCMToken({
    @Body() required FCMTokenModel request,
    @Header('requires-token') String requiresToken = 'true',
  });

  @Put(path: 'user/delete/')
  Future<Response<dynamic>> deleteProfile({
    @Header('requires-token') String requiresToken = 'true',
  });

  @Put(path: 'user/complete-registration/')
  Future<Response<ProfileModel>> completeRegistration({
    @Body() required ProfileModel request,
    @Header('requires-token') String requiresToken = 'true',
  });

  @Get(path: 'user/profile/')
  Future<Response<ProfileModel>> getProfile({
    @Header('requires-token') String requiresToken = 'true',
  });

  @Patch(path: 'payment/choise/top/update/')
  Future<Response<ProductModel>> updateTopUp({
    @Header('requires-token') String requiresToken = 'true',
    @Body() required ProductModel request,
  });

  @Patch(path: 'address/choise/top/update/')
  Future<Response<ProductModel>> updateAddressTopUp({
    @Header('requires-token') String requiresToken = 'true',
    @Body() required ProductModel request,
  });

  @Get(path: 'group/')
  Future<Response<Catalog>> getSearchedProduct({
    @Header('requires-token') String requiresToken = 'true',
    @Query('sub_category_id') int? subCategoryId,
    @Query('brand_id') int? brandId,
    @Query('country_id') int? countryId,
    @Query('page') required int page,
    @Query('category_id') int? categoryId,
    @Query('search') String? search,
  });

  @Get(path: 'product/mobile/')
  Future<Response<ProductCatalogResponse>> getSearchedProductMobile({
    @Header('requires-token') String requiresToken = 'true',
    @Query('sub_category_id') int? subCategoryId,
    @Query('brand_id') int? brandId,
    @Query('country_id') int? countryId,
    @Query('page') required int page,
    @Query('category_id') int? categoryId,
    @Query('search') String? search,
  });

  @Get(path: 'product/search/')
  Future<Response<SearchModel>> productSearch({
    @Header('requires-token') String requiresToken = 'true',
    @Query('search') required String? search,
  });

  @Get(path: 'recommendation/')
  Future<Response<BuiltList<ProductModel>>> getRecommendation({
    @Header('requires-token') String requiresToken = 'true',
  });

  @Post(path: 'search/history/create/')
  Future<Response<ProductModel>> createSearchHistory({
    @Header('requires-token') String requiresToken = 'true',
    @Body() required ProductModel search,
  });

  @Get(path: 'search/history/list/')
  Future<Response<BuiltList<ProductModel>>> getSearchHistory({
    @Header('requires-token') String requiresToken = 'true',
  });

  @Delete(path: 'search/history/delete-all/')
  Future<Response<dynamic>> deleteAllSearchHistory({
    @Header('requires-token') String requiresToken = 'true',
  });

  @Delete(path: 'search/history/{id}/delete/')
  Future<Response<dynamic>> deleteSearchHistory({
    @Header('requires-token') String requiresToken = 'true',
    @Path('id') required int id,
  });

  static AuthService create(DBService dbService) =>
      _$AuthService(_Client(Constants.baseUrlP, true, dbService));
}

// main
@ChopperApi(baseUrl: '/main/')
@pragma('vm:entry-point')
abstract class MainService extends ChopperService {
  @Get(path: 'currency')
  Future<Response<CurrencyModel>> getCurrency({
    @Header('requires-token') String requiresToken = 'optional',
  });

  static MainService create(DBService dbService) =>
      _$MainService(_Client(Constants.baseUrlP, true, dbService));
}

// asset
@ChopperApi(baseUrl: '/asset/')
@pragma('vm:entry-point')
abstract class AssetService extends ChopperService {
  @Get(path: 'banner/list/')
  Future<Response<BuiltList<BannerModel>>> getBannerList();

  @Get(path: 'story/list/')
  Future<Response<BuiltList<StoryModel>>> getStoryList();

  @Post(path: 'inform/create/')
  Future<Response<InformCreateRes>> informCreate({
    @Header('requires-token') String requiresToken = 'true',
    @Body() required InformModel request,
  });

  @Get(path: 'notification/messages/list/')
  Future<Response<Notification>> getNotificationList({
    @Header('requires-token') String requiresToken = 'true',
  });

  @Patch(path: 'notification/messages/{id}/update/')
  Future<Response<dynamic>> updateNotification({
    @Header('requires-token') String requiresToken = 'true',
    @Path('id') required int id,
    @Body() required NotificationModel body,
  });

  @Get(path: 'inform/list/')
  Future<Response<Inform>> getInformList({
    @Header('requires-token') String requiresToken = 'true',
  });

  @Delete(path: 'inform/{id}/delete/')
  Future<Response<dynamic>> deleteInform({
    @Header('requires-token') String requiresToken = 'true',
    @Path('id') required int id,
  });

  @Delete(path: 'inform/all/delete/')
  Future<Response<dynamic>> deleteAllInform({
    @Header('requires-token') String requiresToken = 'true',
  });

  static AssetService create(DBService dbService) =>
      _$AssetService(_Client(Constants.baseUrlP, true, dbService));
}

// store
@ChopperApi(baseUrl: '/store/')
@pragma('vm:entry-point')
abstract class StoreService extends ChopperService {
  @Get(path: 'set-package/')
  Future<Response<BuiltList<SetModel>>> getSetPackage();

  @Get(path: 'tenant/set-package/')
  Future<Response<BuiltList<FamilyModel>>> getTenantSetPackage();

  @Get(path: 'tenant/category/mobile/')
  Future<Response<BuiltList<ProductCategory>>> getTenantCategory();

  @Get(path: 'country/')
  Future<Response<BuiltList<FilterRes>>> getCountry({
    @Header('requires-token') String requiresToken = 'optional',
    @Query('category_id') int? categoryId,
  });

  @Get(path: 'brand/short/')
  Future<Response<BuiltList<FilterRes>>> getBrandShort({
    @Header('requires-token') String requiresToken = 'optional',
    @Query('country_id') required String? countryId,
    @Query('category_id') int? categoryId,
  });

  @Get(path: 'product-small/detail/{id}/')
  Future<Response<ProductDetailModel>> getProductDetail({
    @Header('requires-token') String requiresToken = 'optional',
    @Path('id') required int id,
  });

  @Get(path: 'group/')
  Future<Response<Catalog>> getGroupCatalog({
    @Header('requires-token') String requiresToken = 'optional',
    @Query('page') required int page,
    @Query('category_id') required int? categoryId,
    @Query('brand_id') required String? brandId,
    @Query('country_id') required String? countryId,
    @Query('set_id') required int? setId,
  });

  @Get(path: 'product/mobile/')
  Future<Response<ProductCatalogResponse>> getProductMobile({
    @Header('requires-token') String requiresToken = 'optional',
    @Query('page') required int page,
    @Query('category_id') required int? categoryId,
    @Query('brand_id') required String? brandId,
    @Query('country_id') required String? countryId,
    @Query('set_id') required int? setId,
  });

  @Get(path: 'category/mobile/')
  Future<Response<BuiltList<ProductModel>>> getCategory({
    @Header('requires-token') String requiresToken = 'optional',
  });

  @Get(path: 'category/cluster/')
  Future<Response<BuiltList<CategoryListModel>>> getCategoryCluster({
    @Header('requires-token') String requiresToken = 'optional',
  });

  @Post(path: 'promocode/validate/')
  Future<Response<CurrencyModel>> promocodeValidate({
    @Header('requires-token') String requiresToken = 'true',
    @Body() required OrderReq request,
  });

  @Get(path: 'group/')
  Future<Response<Catalog>> getSearchedProduct({
    @Header('requires-token') String requiresToken = 'optional',
    @Query('sub_category_id') int? subCategoryId,
    @Query('brand_id') int? brandId,
    @Query('country_id') int? countryId,
    @Query('page') required int page,
    @Query('category_id') int? categoryId,
    @Query('search') String? search,
  });

  @Get(path: 'product/mobile/')
  Future<Response<ProductCatalogResponse>> getSearchedProductMobile({
    @Header('requires-token') String requiresToken = 'optional',
    @Query('sub_category_id') int? subCategoryId,
    @Query('brand_id') int? brandId,
    @Query('country_id') int? countryId,
    @Query('page') required int page,
    @Query('category_id') int? categoryId,
    @Query('search') String? search,
  });

  @Get(path: 'product/search/')
  Future<Response<SearchModel>> productSearch({
    @Header('requires-token') String requiresToken = 'optional',
    @Query('search') required String? search,
  });

  @Get(path: 'recommendation/')
  Future<Response<BuiltList<ProductModel>>> getRecommendation({
    @Header('requires-token') String requiresToken = 'optional',
  });

  @Post(path: 'search/history/create/')
  Future<Response<ProductModel>> createSearchHistory({
    @Header('requires-token') String requiresToken = 'optional',
    @Body() required ProductModel search,
  });

  @Get(path: 'search/history/list/')
  Future<Response<BuiltList<ProductModel>>> getSearchHistory({
    @Header('requires-token') String requiresToken = 'optional',
  });

  @Delete(path: 'search/history/delete-all/')
  Future<Response<dynamic>> deleteAllSearchHistory({
    @Header('requires-token') String requiresToken = 'true',
  });

  @Delete(path: 'search/history/{id}/delete/')
  Future<Response<dynamic>> deleteSearchHistory({
    @Header('requires-token') String requiresToken = 'true',
    @Path('id') required int id,
  });

  @Post(path: 'product/wish/create/')
  Future<Response<OrderReq>> createWish({
    @Header('requires-token') String requiresToken = 'true',
    @Body() required OrderReq request,
  });

  @Get(path: 'section/list/')
  Future<Response<BuiltList<SectionModel>>> getSectionList({
    @Header('requires-token') String requiresToken = 'optional',
  });

  @Get(path: 'section/{id}/')
  Future<Response<SectionModel>> getSectionById({
    @Header('requires-token') String requiresToken = 'optional',
    @Path('id') required int id,
  });

  static StoreService create(DBService dbService) =>
      _$StoreService(_Client(Constants.baseUrlP, true, dbService));
}

// order
@ChopperApi(baseUrl: '/order/')
@pragma('vm:entry-point')
abstract class OrderService extends ChopperService {
  @Get(path: 'draft/')
  Future<Response<OrderModel>> getDraft({
    @Header('requires-token') String requiresToken = 'true',
  });

  @Get(path: 'monitoring/')
  Future<Response<MonitoringModel>> getMonitoring({
    @Header('requires-token') String requiresToken = 'true',
    @Query('date_from') required String dateFrom,
    @Query('date_to') required String dateTo,
  });

  @Get(path: 'planned-soon/')
  Future<Response<SuccessModel>> getPlannedSoon({
    @Header('requires-token') String requiresToken = 'true',
  });

  @Get(path: 'top-items/')
  Future<Response<ProductModelResponse>> getTopItems({
    @Header('requires-token') String requiresToken = 'optional',
    @Query('page') int? page,
    @Query('limit') int limit = 60,
  });

  @Get(path: 'delivery/price/')
  Future<Response<BuiltList<ProductModel>>> getDeliveryPrice({
    @Header('requires-token') String requiresToken = 'true',
    @Query('address_id') int? addressId,
  });

  @Post(path: 'draft/create/')
  Future<Response<OrderModel>> postOrderCreate({
    @Header('requires-token') String requiresToken = 'true',
    @Body() required OrderReq request,
  });

  @Put(path: '{id}/update/')
  Future<Response<SuccessModel>> putOrder({
    @Header('requires-token') String requiresToken = 'true',
    @Body() required OrderReq request,
    @Path() required int id,
  });

  @Get(path: 'status/{id}/')
  Future<Response<OrderStatusRes>> status({
    @Header('requires-token') String requiresToken = 'true',
    @Path() required int id,
  });

  @Get(path: 'history/')
  Future<Response<BuiltList<OrderModel>>> getHistory({
    @Header('requires-token') String requiresToken = 'true',
  });

  @Get(path: 'active/list/')
  Future<Response<BuiltList<OrderModel>>> getActiveList({
    @Header('requires-token') String requiresToken = 'true',
  });

  @Get(path: 'draft/check-availability/')
  Future<Response<BuiltList<ModifiedModel>>> getDraftCheckAvailability({
    @Header('requires-token') String requiresToken = 'true',
  });

  @Post(path: 'repeat/')
  Future<Response<OrderModel>> postRepeat({
    @Header('requires-token') String requiresToken = 'true',
    @Body() required OrderModel request,
  });

  @Get(path: '{id}/')
  Future<Response<OrderModel>> getOrderItem({
    @Header('requires-token') String requiresToken = 'true',
    @Path() required int id,
  });

  @Post(path: 'cyclic-order/create/')
  Future<Response<PlannedOrderModel>> createPlannedOrder({
    @Header('requires-token') String requiresToken = 'true',
    @Body() required PlannedOrderModel request,
  });

  @Patch(path: 'cyclic-order/{id}/update/')
  Future<Response<PlannedOrderModel>> updatePlannedOrder({
    @Header('requires-token') String requiresToken = 'true',
    @Path() required int id,
    @Body() required PlannedOrderModel request,
  });

  @Patch(path: 'cyclic-order/{id}/add/')
  Future<Response<PlannedOrderModel>> addToPlannedOrder({
    @Header('requires-token') String requiresToken = 'true',
    @Path() required int id,
    @Body() required PlannedOrderModel request,
  });

  @Get(path: 'cyclic-order/list/')
  Future<Response<PlannedOrderListModel>> getPlannedOrderList({
    @Header('requires-token') String requiresToken = 'true',
  });

  @Get(path: 'cyclic-order/{id}/')
  Future<Response<PlannedOrderModel>> getPlannedOrderDetail({
    @Header('requires-token') String requiresToken = 'true',
    @Path() required int id,
  });

  @Patch(path: 'cyclic-order/status/{id}/update/')
  Future<Response<PlannedOrderModel>> updatePlannedOrderStatus({
    @Header('requires-token') String requiresToken = 'true',
    @Path() required int id,
    @Body() required PlannedOrderModel request,
  });

  @Delete(path: 'cyclic-order/{id}/delete/')
  Future<Response<dynamic>> deletePlannedOrder({
    @Header('requires-token') String requiresToken = 'true',
    @Path() required int id,
  });

  static OrderService create(DBService dbService) =>
      _$OrderService(_Client(Constants.baseUrlP, true, dbService));
}

// payment
@ChopperApi(baseUrl: '/payment/')
@pragma('vm:entry-point')
abstract class PaymentService extends ChopperService {
  @Post(path: 'card/create/')
  Future<Response<CardModel>> createCard({
    @Header('requires-token') String requiresToken = 'true',
    @Body() required CardModel request,
  });

  @Post(path: 'card/verify/')
  Future<Response<CardModel>> verifyCard({
    @Header('requires-token') String requiresToken = 'true',
    @Body() required CardModel request,
  });

  @Delete(path: 'card/delete/{id}/')
  Future<Response<dynamic>> deleteCard({
    @Header('requires-token') String requiresToken = 'true',
    @Path('id') required int id,
  });

  static PaymentService create(DBService dbService) =>
      _$PaymentService(_Client(Constants.baseUrlP, true, dbService));
}

//premium
@ChopperApi(baseUrl: '/premium/')
@pragma('vm:entry-point')
abstract class PremiumService extends ChopperService {
  @Post(path: 'buy/subscription/')
  Future<Response<SubscriptionReq>> postSubscriptionCreate({
    @Header('requires-token') String requiresToken = 'true',
    @Body() required SubscriptionReq request,
  });

  static PremiumService create(DBService dbService) =>
      _$PremiumService(_Client(Constants.baseUrlP, true, dbService));
}

base class _Client extends ChopperClient {
  _Client(
    String baseUrl,
    bool useInterceptors,
    DBService dbService, {
    int timeout = 20,
  }) : super(
         client: TimeoutHttpClient(
           Client(),
           timeout: Duration(seconds: timeout),
         ),
         baseUrl: Uri.parse(baseUrl),
         interceptors: useInterceptors
             ? [
                 CoreInterceptor(dbService),
                 // if (kDebugMode) aliceChopperAdapter,
                 HttpLoggingInterceptor(),
                 CurlInterceptor(),
                 NetworkInterceptor(),
                 BackendInterceptor(),
               ]
             : const [],
         converter: BuiltValueConverter(),
         errorConverter: ErrorMyConverter(),
         authenticator: MyAuthenticator(dbService),
       );
}

class MyAuthenticator extends Authenticator {
  final DBService dbService;

  MyAuthenticator(this.dbService);

  @override
  FutureOr<Request?> authenticate(
    Request request,
    Response response, [
    Request? originalRequest,
  ]) async {
    if (response.statusCode == 401) {
      try {
        LogService.i("Attempting token refresh");
        final refreshToken = dbService.token.refreshToken;

        if (refreshToken == null) {
          LogService.e("No refresh token available");
          dbService.signOut();
          return null;
        }

        final result = await AuthRepository.refreshToken(refreshToken);

        return result.fold(
          (error) {
            LogService.e("Token refresh failed: ${error.message}");
            dbService.signOut();
            return null;
          },
          (loginRes) {
            // Save new tokens
            dbService.setToken(
              Token(
                accessToken: loginRes.access,
                refreshToken: refreshToken, // Keep existing refresh token
              ),
            );

            // Create new request with updated token
            final updatedHeaders = Map<String, String>.from(request.headers);
            updatedHeaders['Authorization'] = 'Bearer ${loginRes.access}';

            // Return new request with updated auth header
            return request.copyWith(headers: updatedHeaders);
          },
        );
      } catch (e) {
        LogService.e("Token refresh error: $e");
        dbService.signOut();
        return null;
      }
    }

    // Handle other error cases
    if (response.statusCode >= 400) {
      throw BackendExceptionForSentry(response);
    }

    return null;
  }
}
