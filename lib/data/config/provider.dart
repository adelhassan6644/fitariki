import 'package:fitariki/features/maps/provider/location_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:fitariki/data/config/di.dart' as di;

import '../../app/localization/provider/localization_provider.dart';
import '../../app/theme/theme_provider/theme_provider.dart';
import '../../features/add_offer/provider/add_offer_provider.dart';
import '../../features/auth/provider/firebase_auth_provider.dart';
import '../../features/my_trips/provider/my_trips_provider.dart';
import '../../features/profile/provider/profile_provider.dart';
import '../../features/replay_offer/provider/replay_offer_provider.dart';
import '../../features/splash/provider/splash_provider.dart';

abstract class ProviderList {

  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => di.sl<ThemeProvider>(),),
    ChangeNotifierProvider(create: (_) => di.sl<LocalizationProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<SplashProvider>()),
    // ChangeNotifierProvider(create: (_) => di.sl<AuthProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<FirebaseAuthProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<ProfileProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<ReplayOfferProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<AddOfferProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<MyTripsProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<LocationProvider>()),
  ];
}
