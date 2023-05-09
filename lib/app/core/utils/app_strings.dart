import '../../../main_models/weak_model.dart';

class AppStrings {
  static const String appName = 'fitariki';
  static const String googleApiKey = 'AIzaSyB_l2x6zgnLTF4MKxX3S4Df9urLN6vLNP0';
  static const String defaultLat = '24.774265';
  static const String defaultLong = '46.738586';
  static const String fontFamily = 'Cairo';
  static const String noRouteFound = 'No Route Found';
  static const String cachedRandomQuote = 'CACHED_RANDOM_QUOTE';
  static const String contentType = 'Content-Type';
  static const String applicationJson = 'application/json';
  static const String serverFailure = 'Server Failure';
  static const String cacheFailure = 'Cache Failure';
  static const String unexpectedError = 'Unexpected Error';
  static const String englishCode = 'en';
  static const String arabicCode = 'ar';
  static const String locale = 'locale';
  static List<WeekModel> days = [
    WeekModel(
      id: 1,
      dayName: "السبت",
    ),
    WeekModel(
      id: 2,
      dayName: "الاحد",
    ),
    WeekModel(
      id: 3,
      dayName: "الاثنين",
    ),
    WeekModel(
      id: 4,
      dayName: "الثلاثاء",
    ),
    WeekModel(
      id: 5,
      dayName: "الاربعاء",
    ),
    WeekModel(
      id: 6,
      dayName: "الخميس",
    ),
    WeekModel(
      id: 7,
      dayName: "الجمعة",
    ),
  ];
}
