import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/application2/details_service/bloc/details_bloc.dart';
import 'package:ustahub/infrastructure/apis/apis.dart';
import 'package:ustahub/infrastructure/repositories/auth_repo.dart';
import 'package:ustahub/infrastructure/repositories/category_repo.dart';
import 'package:ustahub/infrastructure/repositories/main_repo.dart';
import 'package:ustahub/infrastructure/services/local_database/db_service.dart';
import 'package:ustahub/presentation/pages/auth/register_page.dart';
import 'package:ustahub/presentation/pages/core/no_connection.dart';
import 'package:ustahub/presentation/pages/core/register_page.dart';
import 'package:ustahub/presentation/pages/main/main_page.dart';
import 'package:ustahub/presentation/pages/notification/notification_page.dart';
import 'package:ustahub/presentation/pages/order/orders_page.dart';
import 'package:ustahub/presentation/pages/splash/splash_screen.dart';

import '../../../infrastructure2/init/injection.dart';
import '../../application2/details_service/data/model/details_model.dart';
import '../pages/auth/auth_options.dart';
import '../pages/auth/register2_page.dart';
import '../pages/booking_page/pages/booking_page.dart';
import '../pages/category_list_page/category_list_page.dart';
import '../pages/company_details_page/pages/company_details_page.dart';
import '../pages/home/details_page.dart';

// Cache repositories to avoid recreating them
class _RepositoryCache {
  static CategoryRepository? _categoryRepository;
  static AuthRepository? _authRepository;
  static MainRepository? _mainRepository;

  static CategoryRepository getCategoryRepository(DBService dbService) {
    return _categoryRepository ??= CategoryRepository(
      StoreService.create(dbService),
      AssetService.create(dbService),
    );
  }

  static AuthRepository getAuthRepository(DBService dbService) {
    return _authRepository ??= AuthRepository(
      dbService,
      AuthService.create(dbService),
    );
  }

  static MainRepository getMainRepository(DBService dbService) {
    return _mainRepository ??= MainRepository(
      MainService.create(dbService),
      AssetService.create(dbService),
      StoreService.create(dbService),
    );
  }
}

class AppRoutes {
  // Cache route instances that don't depend on parameters
  static MaterialPageRoute? _noConnectionRoute;
  static MaterialPageRoute? _registerRoute;

  static PageRoute onGenerateRoute({
    required BuildContext context,
    required bool notConnection,
    required bool isVerified,
    required bool isLoggedIn,
    Uri? initLink,
  }) {
    ScreenUtil.init(context, designSize: const Size(402, 852));

    if (notConnection) {
      return getNetworkNotFound();
    } else {
      if (isLoggedIn) {
        return main();
      }
      // Boshlanishida OnboardingPage ga yo'naltiramiz
      return getOnboarding();
    }
  }

  static MaterialPageRoute getNetworkNotFound() {
    return _noConnectionRoute ??= MaterialPageRoute(
      builder: (_) => const NoConnection(),
    );
  }

  // Splash screen - first screen
  static MaterialPageRoute getSplash() {
    return MaterialPageRoute(
      builder: (_) => SplashScreen(route: getOnboarding()),
    );
  }

  // Onboarding screen - second screen
  static MaterialPageRoute getOnboarding() {
    return MaterialPageRoute(builder: (_) => const OnboardingPage());
  }

  // AuthOptions screen
  static MaterialPageRoute getAuthOptions() {
    return MaterialPageRoute(builder: (_) => const AuthOptions());
  }

  // Booking page
  static MaterialPageRoute bookingPage({required ServiceData service}) {
    return MaterialPageRoute(builder: (_) => BookingPage(service: service));
  }

  // Booking page
  static MaterialPageRoute companyDetailsPage({required String id}) {
    return MaterialPageRoute(
      builder: (_) => CompanyDetailsPage(providerId: id),
    );
  }

  // Main screen - third screen (after onboarding)
  static MaterialPageRoute main() {
    return MaterialPageRoute(builder: (_) => const MainPage());
  }

  // categoryListPage
  static MaterialPageRoute categoryListPage(String id, String name) {
    return MaterialPageRoute(
      builder: (_) => CategoryListPage(categoryId: id, categoryName: name),
    );
  }

  // DetailsPage - service
  static MaterialPageRoute detailsPage(String id) {
    return MaterialPageRoute(
      builder: (_) => BlocProvider.value(
        value: sl<DetailsBloc>(),
        child: DetailsPage(serviceId: id),
      ),
    );
  }

  // Main screen - third screen (after onboarding)
  static MaterialPageRoute register2Page() {
    return MaterialPageRoute(builder: (_) => const Register2Page());
  }

  static MaterialPageRoute orders() {
    return MaterialPageRoute(builder: (_) => const OrdersPage());
  }

  static MaterialPageRoute notification() {
    return MaterialPageRoute(builder: (_) => const NotificationPage());
  }

  static MaterialPageRoute getRegister() {
    return _registerRoute ??= MaterialPageRoute(
      builder: (context) => const RegisterPage(),
    );
  }
}

Widget wrapWithOptionalBloc<T extends BlocBase<Object>>({
  required BuildContext? context,
  required Widget child,
  void Function(T bloc)? onInit,
  void Function()? elseFunction,
}) {
  if (context != null) {
    final bloc = context.read<T>();
    if (onInit != null) onInit(bloc);
    return BlocProvider.value(value: bloc, child: child);
  }

  elseFunction?.call();

  return child;
}
