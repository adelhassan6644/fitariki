import '../../localization/provider/language_provider.dart';
class AppStorageKey {
  static const String token = "token";
  static const String isFirstTime = "is_first_time";
  static const String isLogin = "is_login";
  static const String phone = "phone";
  static const String cityName = "city_name";
  static const String cityId = "city_id";
  static String cartItems = "cart_items";
  static String firstTimeOnApp = "first_time";
  static const String languageCode = "languageCode";
  static const String countryCode = "countryCode";
  static List<LanguageModel> languages = [
    LanguageModel(imageUrl: 'Images.united_kingdom', languageName: 'english', countryCode: 'US', languageCode: 'en'),
    LanguageModel(imageUrl: 'Images.arabic', languageName: 'arabic', countryCode: 'SA', languageCode: 'ar'),
  ];

}
