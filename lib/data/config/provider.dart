import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:fitariki/data/config/di.dart' as di;

import '../../app/localization/provider/localization_provider.dart';
import '../../app/theme/theme_provider/theme_provider.dart';
import '../../features/add_offer/provider/add_offer_provider.dart';
import '../../features/auth/provider/auth_provider.dart';
import '../../features/auth/provider/firebase_auth_provider.dart';
import '../../features/edit_profile/provider/edit_profile_provider.dart';
import '../../features/splash/provider/splash_provider.dart';

abstract class ProviderList {

  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => di.sl<ThemeProvider>(),),
    ChangeNotifierProvider(create: (_) => di.sl<LocalizationProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<SplashProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<AuthProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<FirebaseAuthProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<EditProfileProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<AddOfferProvider>()),
  ];
}
