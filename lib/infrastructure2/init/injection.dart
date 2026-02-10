import 'package:get_it/get_it.dart';
import 'package:ustahub/application2/auth_bloc_and_data/bloc/auth_pin_put_bloc.dart';
import 'package:ustahub/application2/category_bloc_and_data/bloc/category_bloc.dart';
import 'package:ustahub/application2/register_bloc_and_data/bloc/register_bloc.dart';
import 'package:ustahub/application2/service_bloc_and_data/bloc/service_bloc.dart';

import '../../application2/auth_bloc_and_data/bloc/auth_bloc.dart';
import '../../infrastructure/services/shared_perf/shared_pref_service.dart';
import '../common/network_provider.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  final SharedPrefService prf = await SharedPrefService.initialize();
  sl.registerLazySingleton<SharedPrefService>(() => prf);

  /// dio
  sl.registerFactory(() => createDio());

  /// bloc
  sl
    ..registerLazySingleton<AuthBloc>(() => AuthBloc())
    ..registerLazySingleton<RegisterBloc>(
      () => RegisterBloc(sl<SharedPrefService>()),
    )
    ..registerLazySingleton<AuthPinPutBloc>(() => AuthPinPutBloc())
    ..registerLazySingleton<CategoryBloc>(() => CategoryBloc())
    ..registerLazySingleton<ServiceBloc>(() => ServiceBloc());
}
