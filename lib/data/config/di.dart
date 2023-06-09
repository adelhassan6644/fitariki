import 'package:dio/dio.dart';
import 'package:fitariki/features/home/repo/home_repo.dart';
import 'package:fitariki/features/maps/provider/location_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app/localization/provider/language_provider.dart';
import '../../app/localization/provider/localization_provider.dart';
import '../../app/theme/theme_provider/theme_provider.dart';
import '../../features/followers/add_follower/provider/add_follower_provider.dart';
import '../../features/followers/add_follower/repo/add_follower_repo.dart';
import '../../features/followers/follower_details/provider/follower_details_provider.dart';
import '../../features/followers/follower_details/repo/follower_details_repo.dart';
import '../../features/followers/followers/provider/followers_provider.dart';
import '../../features/followers/followers/repo/followers_repo.dart';
import '../../features/home/provider/home_provider.dart';
import '../../features/maps/repo/maps_repo.dart';
import '../../features/my_trips/provider/my_trips_provider.dart';
import '../../features/my_trips/repo/my_trips_repo.dart';
import '../../features/notifictions/provider/notifications_provider.dart';
import '../../features/notifictions/repo/notifications_repo.dart';
import '../../features/post_offer/provider/post_offer_provider.dart';
import '../../features/post_offer/repo/post_offer_repo.dart';
import '../../features/profile/provider/profile_provider.dart';
import '../../features/profile/repo/profile_repo.dart';
import '../../features/add_offer/provider/add_offer_provider.dart';
import '../../features/add_offer/repo/add_offer_repo.dart';
import '../../features/wishlist/provider/wishlist_provider.dart';
import '../../features/wishlist/repo/wishlist_repo.dart';
import '../../main_providers/followers_provider.dart';
import '../../main_providers/map_provider.dart';
import '../../main_providers/schedule_provider.dart';
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
  sl.registerLazySingleton(() => SplashRepo(
        sharedPreferences: sl(),
      ));
  sl.registerLazySingleton(
      () => AuthRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(
      () => FirebaseAuthRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(
      () => ProfileRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(
      () => PostOfferRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(
      () => HomeRepo(sharedPreferences: sl(), dioClient: sl()));

  sl.registerLazySingleton(
      () => AddOfferRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(
      () => MyTripsRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(
      () => MapsRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(
      () => AddFollowersRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(
      () => WishlistRepo(sharedPreferences: sl(), dioClient: sl()));

  sl.registerLazySingleton(
      () => NotificationsRepo(sharedPreferences: sl(), dioClient: sl()));

  sl.registerLazySingleton(
      () => FollowersRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(
      () => FollowerDetailsRepo(sharedPreferences: sl(), dioClient: sl()));

  //provider
  sl.registerLazySingleton(() => LocalizationProvider(sharedPreferences: sl()));
  sl.registerLazySingleton(() => LanguageProvider());
  sl.registerLazySingleton(() => ThemeProvider(sharedPreferences: sl()));
  sl.registerLazySingleton(() => SplashProvider(splashRepo: sl()));
  // sl.registerLazySingleton(() => AuthProvider(authRepo: sl()));
  sl.registerLazySingleton(() => FirebaseAuthProvider(firebaseAuthRepo: sl()));
  sl.registerLazySingleton(() => ProfileProvider(
      editProfileRepo: sl(), postOfferProvider: sl(), scheduleProvider: sl()));
  sl.registerLazySingleton(() => ScheduleProvider());
  sl.registerLazySingleton(() => FollowersProvider());
  sl.registerLazySingleton(() => PostOfferProvider(
        postOfferRepo: sl(),
        scheduleProvider: sl(),
      ));
  sl.registerLazySingleton(() => MapProvider());
  sl.registerLazySingleton(() => AddOfferProvider(addOfferRepo: sl()));
  sl.registerLazySingleton(() => MyTripsProvider(myTripsRepo: sl()));
  sl.registerLazySingleton(() => LocationProvider(locationRepo: sl()));
  sl.registerLazySingleton(() => FollowerDetailsProvider(
        followerDetailsRepo: sl(),
      ));
  sl.registerLazySingleton(() =>
      AddFollowerProvider(addFollowersRepo: sl(), followerProvider: sl()));
  sl.registerLazySingleton(() => WishlistProvider(
        wishlistRepo: sl(),
      ));
  sl.registerLazySingleton(() => HomeProvider(
        homeRepo: sl(),
      ));
  sl.registerLazySingleton(() => NotificationsProvider(
        notificationsRepo: sl(),
      ));
  sl.registerLazySingleton(() => FollowerProvider(
        followersRepo: sl(),
      ));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
}
