import 'package:dio/dio.dart';
import 'package:fitariki/features/home/repo/home_repo.dart';
import 'package:fitariki/features/maps/provider/location_provider.dart';
import 'package:fitariki/features/offer_details/repo/offer_details_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app/localization/provider/language_provider.dart';
import '../../app/localization/provider/localization_provider.dart';
import '../../app/theme/theme_provider/theme_provider.dart';
import '../../features/add_request/provider/add_request_provider.dart';
import '../../features/add_request/repo/add_request_repo.dart';
import '../../features/auth/provider/auth_provider.dart';
import '../../features/auth/repo/auth_repo.dart';
import '../../features/contatct_with_us/provider/contact_provider.dart';
import '../../features/contatct_with_us/repo/contact_repo.dart';
import '../../features/followers/add_follower/provider/add_follower_provider.dart';
import '../../features/followers/add_follower/repo/add_follower_repo.dart';
import '../../features/followers/follower_details/provider/follower_details_provider.dart';
import '../../features/followers/follower_details/repo/follower_details_repo.dart';
import '../../features/followers/followers/provider/followers_provider.dart';
import '../../features/followers/followers/repo/followers_repo.dart';
import '../../features/home/provider/home_provider.dart';
import '../../features/maps/repo/maps_repo.dart';
import '../../features/my_offers/provider/my_offers_provider.dart';
import '../../features/my_offers/repo/my_offers_repo.dart';
import '../../features/my_rides/provider/my_rides_provider.dart';
import '../../features/my_rides/repo/my_rides_repo.dart';
import '../../features/my_trips/provider/my_trips_provider.dart';
import '../../features/my_trips/repo/my_trips_repo.dart';
import '../../features/notifications/provider/notifications_provider.dart';
import '../../features/notifications/repo/notifications_repo.dart';
import '../../features/payment/provider/payment_provider.dart';
import '../../features/payment/repo/payment_repo.dart';
import '../../features/post_offer/provider/post_offer_provider.dart';
import '../../features/post_offer/repo/post_offer_repo.dart';
import '../../features/profile/provider/profile_provider.dart';
import '../../features/profile/repo/profile_repo.dart';
import '../../features/feedback/provider/main_feedback_provider.dart';
import '../../features/feedback/repo/feedback_repo.dart';
import '../../features/request_details/provider/report_provider.dart';
import '../../features/request_details/provider/request_details_provider.dart';
import '../../features/request_details/repo/report_repo.dart';
import '../../features/request_details/repo/request_details_repo.dart';
import '../../features/terms_and_conditions/provider/terms_provider.dart';
import '../../features/terms_and_conditions/repo/terms_repo.dart';
import '../../features/tracking/provider/tracking_provider.dart';
import '../../features/tracking/repo/tracking_repo.dart';
import '../../features/transactions/provider/transactions_provider.dart';
import '../../features/transactions/repo/transactions_repo.dart';
import '../../features/user_profile/provider/user_profile_provider.dart';
import '../../features/user_profile/repo/user_profile_repo.dart';
import '../../features/wishlist/provider/wishlist_provider.dart';
import '../../features/wishlist/repo/wishlist_repo.dart';
import '../../main_providers/calender_provider.dart';
import '../../main_providers/schedule_provider.dart';
import '../api/end_points.dart';
import '../network/netwok_info.dart';
import '../../features/auth/provider/firebase_auth_provider.dart';
import '../../features/auth/repo/firebase_auth_repo.dart';
import '../dio/dio_client.dart';
import '../dio/logging_interceptor.dart';
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
      () => OfferDetailsRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(
      () => FirebaseAuthRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(
      () => ProfileRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(
      () => PostOfferRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(
      () => HomeRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(
      () => AddRequestRepo(sharedPreferences: sl(), dioClient: sl()));
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
  sl.registerLazySingleton(
      () => MyOffersRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(
      () => RequestDetailsRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(
      () => PaymentRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => ContactRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(
      () => UserProfileRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(
      () => FeedbackRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(
      () => TransactionsRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(
      () => ReportRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(
      () => TermsRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(
      () => MyRidesRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(
      () => TrackingRepo(sharedPreferences: sl(), dioClient: sl()));

  //provider
  sl.registerLazySingleton(() => LocalizationProvider(sharedPreferences: sl()));
  sl.registerLazySingleton(() => LanguageProvider());
  sl.registerLazySingleton(() => ThemeProvider(sharedPreferences: sl()));
  sl.registerLazySingleton(() => SplashProvider(splashRepo: sl()));
  sl.registerLazySingleton(() => AuthProvider(authRepo: sl()));
  sl.registerLazySingleton(() => FirebaseAuthProvider(firebaseAuthRepo: sl()));
  sl.registerLazySingleton(() => ProfileProvider(
      profileRepo: sl(), postOfferProvider: sl(), scheduleProvider: sl()));
  sl.registerLazySingleton(() => ScheduleProvider());
  sl.registerLazySingleton(() => PostOfferProvider(
        postOfferRepo: sl(),
        scheduleProvider: sl(),
      ));
  sl.registerLazySingleton(() => CalenderProvider());
  sl.registerLazySingleton(() => AddRequestProvider(addRequestRepo: sl()));
  sl.registerLazySingleton(() => MyTripsProvider(myTripsRepo: sl()));
  sl.registerLazySingleton(() => LocationProvider(locationRepo: sl()));
  sl.registerLazySingleton(() => MyRidesProvider(repo: sl()));
  sl.registerLazySingleton(() => TrackingProvider(repo: sl()));
  sl.registerLazySingleton(() => FollowerDetailsProvider(
        followerDetailsRepo: sl(),
      ));
  sl.registerLazySingleton(() => MyOffersProvider(
        myOffersRepo: sl(),
      ));
  sl.registerLazySingleton(() =>
      AddFollowerProvider(addFollowersRepo: sl(), followerProvider: sl()));
  sl.registerLazySingleton(() => WishlistProvider(
        wishlistRepo: sl(),
      ));
  sl.registerLazySingleton(() => ContactProvider(
        contactRepo: sl(),
      ));
  sl.registerLazySingleton(() => HomeProvider(
        homeRepo: sl(),
      ));
  sl.registerLazySingleton(() => NotificationsProvider(
        notificationsRepo: sl(),
      ));
  sl.registerLazySingleton(() => TransactionsProvider(
        transactionsRepo: sl(),
      ));
  sl.registerLazySingleton(() => UserProfileProvider(
        userProfileRepo: sl(),
      ));
  sl.registerLazySingleton(() => FollowersProvider(
        followersRepo: sl(),
      ));
  sl.registerLazySingleton(() => RequestDetailsProvider(
        requestDetailsRepo: sl(),
      ));
  sl.registerLazySingleton(() => SendFeedbackProvider(
        feedbackRepo: sl(),
      ));
  sl.registerLazySingleton(() => PaymentProvider(paymentRepo: sl()));
  sl.registerLazySingleton(() => ReportProvider(reportRepo: sl()));
  sl.registerLazySingleton(() => TermsProvider(termsRepo: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
}
