import 'package:fitariki/features/offer_details/page/offer_details.dart';
import 'package:flutter/material.dart';
import 'package:fitariki/features/on_boarding/pages/on_boarding.dart';
import '../features/auth/pages/verification.dart';
import '../features/edit_profile/page/edit_profile.dart';
import '../features/maps/pages/pick_map_screen.dart';
import '../features/splash/page/splash.dart';
import '../main.dart';
import '../main_page/dashboard.dart';
import 'routes.dart';

abstract class CustomNavigator {
  static final GlobalKey<NavigatorState> navigatorState =
      GlobalKey<NavigatorState>();
  static final RouteObserver<PageRoute> routeObserver =
      RouteObserver<PageRoute>();
  static final GlobalKey<ScaffoldMessengerState> scaffoldState =
      GlobalKey<ScaffoldMessengerState>();

  static Route<dynamic> onCreateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.APP:
        return _pageRoute(const MyApp());
      case Routes.SPLASH:
        return _pageRoute(const Splash());
      case Routes.ON_BOARDING:
        return _pageRoute(const OnBoarding());
      case Routes.VERIFICATION:
        return _pageRoute(const Verification());
      case Routes.EDIT_PROFILE:
        return _pageRoute(EditProfile(
          fromLogin: settings.arguments as bool,
        ));
      case Routes.DASHBOARD:
        return _pageRoute(const DashBoard());
      case Routes.OFFER_DETAILS:
        return _pageRoute(const OfferDetails());
      case Routes.Pick_Location:
        return _pageRoute(PickMapScreen(
          valueChanged: settings.arguments as ValueChanged,
        ));

      default:
        return MaterialPageRoute(builder: (_) => const MyApp());
    }
  }

  static PageRouteBuilder<dynamic> _pageRoute(Widget child) => PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 400),
      reverseTransitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (c, anim, a2, child) {
        var begin = const Offset(1.0, 0.0);
        var end = Offset.zero;
        var tween = Tween(begin: begin, end: end);
        var curveAnimation =
            CurvedAnimation(parent: anim, curve: Curves.linearToEaseOut);
        return SlideTransition(
          position: tween.animate(curveAnimation),
          child: child,
        );
      },
      opaque: false,
      pageBuilder: (_, __, ___) => child);

  static pop({dynamic result}) {
    if (navigatorState.currentState!.canPop()) {
      navigatorState.currentState!.pop(result);
    }
  }

  static push(String routeName,
      {arguments, bool replace = false, bool clean = false}) {
    if (clean) {
      return navigatorState.currentState!.pushNamedAndRemoveUntil(
          routeName, (_) => false,
          arguments: arguments);
    } else if (replace) {
      return navigatorState.currentState!.pushReplacementNamed(
        routeName,
        arguments: arguments,
      );
    } else {
      return navigatorState.currentState!
          .pushNamed(routeName, arguments: arguments);
    }
  }
}
