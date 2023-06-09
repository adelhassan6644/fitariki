import 'package:fitariki/features/followers/follower_details/model/follower_model.dart';
import 'package:fitariki/features/offer_details/page/offer_details.dart';
import 'package:fitariki/features/payment/page/payment_webView_screen.dart';
import 'package:fitariki/features/feedback/page/rate_user.dart';
import 'package:fitariki/features/user_profile/page/all_user_offers.dart';
import 'package:fitariki/features/wishlist/page/wishlist.dart';
import 'package:fitariki/main_models/base_model.dart';
import 'package:flutter/material.dart';
import 'package:fitariki/features/on_boarding/pages/on_boarding.dart';
import '../features/auth/pages/verification.dart';
import '../features/contatct_with_us/page/contact_with_us.dart';
import '../features/followers/follower_details/page/follower_details.dart';
import '../features/followers/followers/page/followers.dart';
import '../features/maps/pages/pick_map_screen.dart';
import '../features/my_offers/page/all_requests.dart';
import '../features/my_offers/page/my_offer_details.dart';
import '../features/notifictions/page/notifications.dart';
import '../features/payment/page/payment.dart';
import '../features/feedback/page/feedback.dart';
import '../features/request_details/page/request_details.dart';
import '../features/success/model/success_model.dart';
import '../features/success/success_page.dart';
import '../features/profile/page/profile_page.dart';
import '../features/splash/page/splash.dart';
import '../features/user_profile/page/user_profile.dart';
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
        return _pageRoute(ProfilePage(
          fromLogin: settings.arguments as bool,
        ));
      case Routes.DASHBOARD:
        return _pageRoute(DashBoard(
          index: settings.arguments as int,
        ));

      case Routes.OFFER_DETAILS:
        return _pageRoute(OfferDetails(
          offerId: settings.arguments as int,
        ));

      case Routes.SUCCESS:
        return _pageRoute(SuccessPage(
          successModel: settings.arguments as SuccessModel,
        ));

      case Routes.PICK_LOCATION:
        return _pageRoute(PickMapScreen(
          baseModel: settings.arguments as BaseModel,
        ));
      case Routes.FOLLOWERS:
        return _pageRoute(const Followers());

      case Routes.FOLLOWER_DETAILS:
        return _pageRoute(FollowerDetails(
          followerModel: settings.arguments as FollowerModel,
        ));
      case Routes.FEEDBACK:
        return _pageRoute(const FeedbackView());

      case Routes.RATE_USER:
        return _pageRoute(RateUser(
          userId: settings.arguments as int,
        ));

      case Routes.WISHLIST:
        return _pageRoute(const Wishlist());

      case Routes.USER_PROFILE:
        return _pageRoute(UserProfile(
          userId: settings.arguments as int,
        ));

      case Routes.ALL_USER_OFFERS:
        return _pageRoute(const AllUserOffers());

      case Routes.CONTACT_WITH_US:
        return _pageRoute(const ContactWithUs());

      case Routes.NOTIFICATIONS:
        return _pageRoute(const Notifications());

      case Routes.MY_OFFERS_DETAILS:
        return _pageRoute(MyOfferDetails(
          offerId: settings.arguments as int,
        ));

      case Routes.ALL_REQUESTS:
        return _pageRoute(const AllRequests());

      case Routes.REQUEST_DETAILS:
        return _pageRoute(RequestDetails(
          requestId: settings.arguments as int,
        ));

      case Routes.PAYMENT:
        return _pageRoute(const Payment());
        case Routes.PAYMENTWEBVIEW:
        return _pageRoute( PaymentWebViewScreen(rservationId: settings.arguments! as int,));

      default:
        return MaterialPageRoute(builder: (_) => const MyApp());
    }
  }

  static PageRouteBuilder<dynamic> _pageRoute(Widget child) => PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 100),
      reverseTransitionDuration: const Duration(milliseconds: 100),
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
