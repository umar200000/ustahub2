import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ustahub/domain/common/token.dart';
import 'package:ustahub/domain/models/main/main_model.dart';
import 'package:ustahub/utils/constants.dart';

class DBService {
  static const _dbName = 'localDB';
  static const _accessToken = 'access_token';
  static const _uid = 'uid';
  static const _refreshToken = 'refresh_token';
  static const _themeMode = 'theme_mode';
  static const _language = 'language';
  static const _isProductsGridView = 'is_products_grid_view';
  static const _isCatalogsGridView = 'is_catalogs_grid_view';
  static const currencySymbol = "currency_symbol";
  static const intro = 'intro';
  static const prediction = 'prediction';
  static const auction = 'auction';
  static const auctionMarket = 'auction_market';
  static const business = 'business';
  static const moderator = 'moderator';
  static const auctionTerms = 'auction_terms';
  static const auctionBusiness = 'auction_business';
  static const auctionConsumer = 'auction_consumer';
  static const diagnostics = 'diagnostics';
  static const _currencyAmount = "currency_amount";
  static const _guestMode = "guest_mode";

  static Box? _box;

  DBService._();

  static Future<DBService> get create async {
    _box ??= await Hive.openBox(_dbName);
    return DBService._();
  }

  /// Token
  Future<void> setToken(Token token) async {
    await _box?.put(_accessToken, token.accessToken ?? '');
    await _box?.put(_refreshToken, token.refreshToken ?? '');
  }

  Token get token {
    final accessToken = _box?.get(_accessToken);
    final refreshToken = _box?.get(_refreshToken);
    return Token(accessToken: accessToken, refreshToken: refreshToken);
  }

  /// UID
  Future<void> setUid(String? uid) async {
    await _box?.put(_uid, uid);
  }

  String? get getUid {
    final uid = _box?.get(_uid);
    return uid;
  }

  // // Likes
  // List<CarPostModel> get likesList {
  //   final data = _box?.get(_likesList);

  //   List<CarPostModel> result = [];

  //   if (data != null) {
  //     List<String>? list = data as List<String>;
  //     for (var element in list) {
  //       CarPostModel? resultModel = CarPostModel.fromJson(element);
  //       result.add(resultModel!);
  //     }
  //   }

  //   return result;
  // }

  // Likes
  // static List<CarPostModel> likesListGlobal(Box? box) {
  //   final data = box?.get(_likesList);

  //   List<CarPostModel> result = [];

  //   if (data != null) {
  //     List<String>? list = data as List<String>;
  //     for (var element in list) {
  //       CarPostModel? resultModel = CarPostModel.fromJson(element);
  //       result.add(resultModel!);
  //     }
  //   }

  //   return result;
  // }

  // // Likes
  // Future<void> addLike(CarPostModel model) async {
  //   if (!likesList.map((e) => e.id).contains(model.id)) {
  //     await _box?.put(_likesList, [model.toJson(), ...likesList.map((e) => e.toJson())]);
  //   }
  // }

  // // Likes
  // Future<void> removeLike(CarPostModel model) async {
  //   int lastIndex = likesList.lastIndexWhere((element) => element.id == model.id);
  //   if (lastIndex != -1) {
  //     List<CarPostModel> list = List.from(likesList);
  //     list.removeAt(lastIndex);
  //     await _box?.put(_likesList, list.map((e) => e.toJson()).toList());
  //   }
  // }

  // // Likes
  // Future<void> removeLikes() async {
  //   await _box?.delete(_likesList);
  // }

  // Stars
  // List<FilterSearchRes> get starsList {
  //   final data = _box?.get(_starsList);
  //   List<FilterSearchRes> result = [];
  //   List<String>? list = data as List<String>?;
  //   if (list != null) {
  //     for (var element in list) {
  //       FilterSearchRes? resultModel = FilterSearchRes.fromJson(element);
  //       if (resultModel != null) {
  //         result.add(resultModel);
  //       }
  //     }
  //   }

  //   return result;
  // }

  // Stars
  // static List<FilterSearchRes> starsListGlobal(Box? box) {
  //   final data = box?.get(_starsList);
  //   List<FilterSearchRes> result = [];
  //   List<String>? list = data as List<String>?;
  //   if (list != null) {
  //     for (var element in list) {
  //       FilterSearchRes? resultModel = FilterSearchRes.fromJson(element);
  //       if (resultModel != null) {
  //         result.add(resultModel);
  //       }
  //     }
  //   }

  //   return result;
  // }

  // Stars
  // Future<void> addStar(FilterSearchRes model) async {
  //   if (!starsList.map((e) => e.id).contains(model.id)) {
  //     await _box?.put(_starsList, [model.toJson(), ...starsList.map((e) => e.toJson())]);
  //   }
  // }

  // // Stars
  // Future<void> removeStar(FilterSearchRes model) async {
  //   if (starsList.map((e) => e.id).contains(model.id)) {
  //     // dprint
  //     final list = starsList;
  //     list.remove(model);
  //     await _box?.put(_starsList, list.map((e) => e.toJson()).toList());
  //   }
  // }

  // Stars
  // Future<void> removeStars() async {
  //   await _box?.delete(_starsList);
  // }

  // // Seen
  // List<CarPostModel> get seenList {
  //   final data = _box?.get(_seenList);

  //   List<CarPostModel> result = [];

  //   if (data != null) {
  //     List<String>? list = data as List<String>;
  //     for (var element in list) {
  //       CarPostModel? resultModel = CarPostModel.fromJson(element);
  //       result.add(resultModel!);
  //     }
  //   }

  //   return result;
  // }

  // // Seen
  // static List<CarPostModel> seenListGlobal(Box? box) {
  //   final data = box?.get(_seenList);

  //   List<CarPostModel> result = [];

  //   if (data != null) {
  //     List<String>? list = data as List<String>;
  //     for (var element in list) {
  //       CarPostModel? resultModel = CarPostModel.fromJson(element);
  //       result.add(resultModel!);
  //     }
  //   }

  //   return result;
  // }

  // // Seen
  // Future<void> addSeen(CarPostModel model) async {
  //   if (!seenList.map((e) => e.id).contains(model.id)) {
  //     await _box?.put(_seenList, [model.toJson(), ...seenList.map((e) => e.toJson())]);
  //   }
  // }

  // // Seen
  // Future<void> removeSeen(CarPostModel model) async {
  //   if (seenList.map((e) => e.id).contains(model.id)) {
  //     // dprint
  //     final list = seenList;
  //     list.remove(model);
  //     await _box?.put(_seenList, list.map((e) => e.toJson()).toList());
  //   }
  // }

  // // Seen
  // Future<void> removeSeens() async {
  //   await _box?.delete(_seenList);
  // }

  // // Changed Part
  // List<NamedModel> get changedPartsQualityList {
  //   final data = _box?.get(_changedPartList);

  //   List<NamedModel> result = [];
  //   List<String>? list = data as List<String>?;
  //   if (list != null) {
  //     for (var element in list) {
  //       NamedModel? resultModel = NamedModel.fromJson(element);
  //       if (resultModel != null) {
  //         result.add(resultModel);
  //       }
  //     }
  //   }
  //   return result;
  // }

  // // Changed Part
  // Future<void> setChangedPart(List<NamedModel> model) async {
  //   await _box?.put(_changedPartList, model.map((e) => e.toJson()).toList());
  // }

  // // Options
  // OptionsRes? get optionsList {
  //   final data = _box?.get(_optionList);
  //   OptionsRes? result = OptionsRes.fromJson(data);
  //   return result;
  // }

  // // Options
  // Future<void> setOptionList(OptionsRes model) async {
  //   await _box?.put(_optionList, model.toJson());
  // }

  // Currency
  CurrencyModel? get getCurrencyAmount {
    final data = _box?.get(_currencyAmount);
    if (data == null) {
      return null;
    }
    CurrencyModel? result = CurrencyModel.fromJson(data);
    return result;
  }

  // Currency
  Future<void> setCurrencyAmount(CurrencyModel model) async {
    await _box?.put(_currencyAmount, model.toJson());
  }

  // Currency
  String get getCurrencySymbol {
    final data = _box?.get(currencySymbol);
    return data ?? listCurrency.first;
  }

  // Currency
  Future<void> setCurrencySymbol(String model) async {
    await _box?.put(currencySymbol, model);
  }

  /// Name
  Future<void> setThemeMode(String? mode) async {
    await _box?.put(_themeMode, mode);
  }

  String? get getThemeMode {
    String? getName = _box?.get(_themeMode);
    return getName;
  }

  Future<void> signOut() async {
    // bool? verified = getVerified;
    await _box?.clear();
    // setVerified(isSaved: verified ?? false);
  }

  /// Lang
  Future<void> setVerified({bool isSaved = false}) async {
    await _box?.put(_language, isSaved);

    // If user is now verified, they can't be a guest anymore
    if (isSaved) {
      await setGuestMode(false);
    }
  }

  bool? get getVerified {
    bool? language = _box?.get(_language, defaultValue: false);

    return language;
  }

  Future<void> setBool({required String key, bool isSaved = false}) async {
    await _box?.put(key, isSaved);
  }

  bool? getBool({required String key}) {
    final bool? result = _box?.get(key, defaultValue: false);

    return result;
  }

  // Grid View Preferences
  Future<void> setIsProductsGridView(bool isGrid) async {
    await _box?.put(_isProductsGridView, isGrid);
  }

  bool getIsProductsGridView() {
    // return _box?.get(_isProductsGridView, defaultValue: true) ?? true;
    // Always return true to enforce grid view only
    return true;
  }

  Future<void> setIsCatalogsGridView(bool isGrid) async {
    await _box?.put(_isCatalogsGridView, isGrid);
  }

  bool getIsCatalogsGridView() {
    return _box?.get(_isCatalogsGridView, defaultValue: true) ?? true;
  }

  // Guest Mode Management
  Future<void> setGuestMode(bool isGuest) async {
    await _box?.put(_guestMode, isGuest);
  }

  bool get isGuestMode {
    return _box?.get(_guestMode, defaultValue: false) ?? false;
  }

  /// Clear guest mode when user authenticates
  Future<void> clearGuestModeOnAuth() async {
    final hasTokens =
        token.accessToken != null && token.accessToken!.isNotEmpty;
    final isVerified = getVerified ?? false;

    if (hasTokens && isVerified) {
      await setGuestMode(false);
    }
  }

  /// Reactive authentication status check
  /// Returns true if user is authenticated and verified
  bool get isUserLoggedInReactive {
    try {
      final accessToken = _box?.get(_accessToken);
      final isVerified = getVerified ?? false;
      final isGuest = isGuestMode;

      final isAuthenticated =
          !isGuest &&
          accessToken != null &&
          accessToken.toString().isNotEmpty &&
          isVerified;

      // Debug info in development mode
      if (kDebugMode) {
        print('🔐 Authentication Status:');
        print(
          '   📱 Access Token: ${accessToken != null ? '✅ Present' : '❌ Missing'}',
        );
        print('   ✅ Is Verified: $isVerified');
        print('   👤 Guest Mode: $isGuest');
        print('   🏠 Final Result: $isAuthenticated');
        print('');
      }

      return isAuthenticated;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Authentication check error: $e');
      }
      return false;
    }
  }

  /// Static method for ValueListenable access
  static bool isUserAuthenticatedFromBox(Box box) {
    try {
      final accessToken = box.get(_accessToken);
      final isVerified = box.get(_language, defaultValue: false) as bool;
      final isGuest = box.get(_guestMode, defaultValue: false) as bool;

      debugPrint('🔐 Authentication Check (Static):');
      debugPrint('   📱 accessToken: $accessToken');
      debugPrint('   ✅ isVerified: $isVerified');
      debugPrint('   👤 isGuest: $isGuest');

      final result =
          !isGuest &&
          accessToken != null &&
          accessToken.toString().isNotEmpty &&
          isVerified;

      debugPrint('   🏠 Final Result: $result');
      debugPrint('');

      return result;
    } catch (e) {
      debugPrint('❌ Authentication check error: $e');
      return false;
    }
  }

  /// Legacy method for compatibility
  bool get isUserLoggedIn {
    final accessToken = _box?.get(_accessToken);
    final isVerified = getVerified ?? false;
    return !isGuestMode &&
        accessToken != null &&
        accessToken.isNotEmpty &&
        isVerified;
  }

  // Deprecated - will be removed

  static ValueListenable<Box> listenable() {
    return Hive.box(_dbName).listenable();
  }
}
