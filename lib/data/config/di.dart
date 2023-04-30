import 'package:fitariki/features/auth/provider/auth_provider.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app/localization/provider/language_provider.dart';
import '../../app/localization/provider/localization_provider.dart';
import '../../app/theme/theme_provider/theme_provider.dart';
import '../../features/edit_profile/provider/edit_profile_provider.dart';
import '../../features/edit_profile/repo/profile_repo.dart';
import '../api/end_points.dart';
import '../network/netwok_info.dart';
import '../../features/auth/provider/firebase_auth_provider.dart';
import '../../features/auth/repo/firebase_auth_repo.dart';
import '../dio/dio_client.dart';
import '../dio/logging_interceptor.dart';
import '../../features/auth/repo/auth_repo.dart';
import '../../features/splash/provider/splash_provider.dart';
import '../../features/splash/repo/splash_repo.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton(() => NetworkInfo(sl()));
  sl.registerLazySingleton(() => DioClient(
        EndPoints.baseUrl,
        dio: sl(),
        loggingInterceptor: sl(),
        sharedPreferences: sl(),
      ));

  // Repository
  sl.registerLazySingleton(() => SplashRepo(sharedPreferences: sl(),));
  sl.registerLazySingleton(() => AuthRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(() => FirebaseAuthRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(() => EditProfileRepo(sharedPreferences: sl(), dioClient: sl()));

  //provider
  sl.registerLazySingleton(() => LocalizationProvider(sharedPreferences: sl()));
  sl.registerLazySingleton(() => LanguageProvider());
  sl.registerLazySingleton(() => ThemeProvider(sharedPreferences: sl()));
  sl.registerLazySingleton(() => SplashProvider(splashRepo: sl()));
  sl.registerLazySingleton(() => AuthProvider(authRepo: sl()));
  sl.registerLazySingleton(() => FirebaseAuthProvider(firebaseAuthRepo: sl()));
  sl.registerLazySingleton(() => EditProfileProvider(editProfileRepo: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
}
