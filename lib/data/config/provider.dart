import 'package:fitariki/features/maps/provider/location_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:fitariki/data/config/di.dart' as di;

import '../../app/localization/provider/localization_provider.dart';
import '../../app/theme/theme_provider/theme_provider.dart';
import '../../features/add_request/provider/add_request_provider.dart';
import '../../features/auth/provider/firebase_auth_provider.dart';
import '../../features/contatct_with_us/provider/contact_provider.dart';
import '../../features/followers/add_follower/provider/add_follower_provider.dart';
import '../../features/followers/follower_details/provider/follower_details_provider.dart';
import '../../features/followers/followers/provider/followers_provider.dart';
import '../../features/home/provider/home_provider.dart';
import '../../features/my_offers/provider/my_offers_provider.dart';
import '../../features/my_trips/provider/my_trips_provider.dart';
import '../../features/notifictions/provider/notifications_provider.dart';
import '../../features/offer_details/provider/offer_details_provider.dart';
import '../../features/payment/provider/payment_provider.dart';
import '../../features/post_offer/provider/post_offer_provider.dart';
import '../../features/profile/provider/profile_provider.dart';
import '../../features/ratting/provider/ratting_provider.dart';
import '../../features/request_details/provider/request_details_provider.dart';
import '../../features/splash/provider/splash_provider.dart';
import '../../features/user_profile/provider/user_profile_provider.dart';
import '../../features/wishlist/provider/wishlist_provider.dart';
import '../../main_providers/calender_provider.dart';
import '../../main_providers/map_provider.dart';
import '../../main_providers/schedule_provider.dart';

abstract class ProviderList {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(
      create: (_) => di.sl<ThemeProvider>(),
    ),
    ChangeNotifierProvider(create: (_) => di.sl<LocalizationProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<SplashProvider>()),
    // ChangeNotifierProvider(create: (_) => di.sl<AuthProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<FirebaseAuthProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<ProfileProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<AddRequestProvider>()),
    ChangeNotifierProvider(
      create: (_) => di.sl<PostOfferProvider>(),
    ),
    ChangeNotifierProvider(
      create: (_) => di.sl<MapProvider>(),
    ), ChangeNotifierProvider(
      create: (_) => di.sl<CalenderProvider>(),
    ),
    ChangeNotifierProvider(create: (_) => di.sl<MyTripsProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<LocationProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<ScheduleProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<FollowerDetailsProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<AddFollowerProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<WishlistProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<HomeProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<NotificationsProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<FollowersProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<MyOffersProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<RequestDetailsProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<PaymentProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<OfferDetailsProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<ContactProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<UserProfileProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<RattingProvider>()),
  ];
}
