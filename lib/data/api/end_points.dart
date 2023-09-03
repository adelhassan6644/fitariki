import 'package:fitariki/app/core/utils/extensions.dart';

class EndPoints {
  static const String baseUrl = 'https://test.fitariki.com/api/v1/';
  static const String googleMapsBaseUrl = 'https://maps.googleapis.com';
  static const String imageUrl = 'https://test.fitariki.com/';
  static const String apiKey = 'eGvviZ/npgc2Blb4/PSymh1tyb/UIt3aq82W6f+Wn4=';
  static const String topic = 'fitariki';
  static logIn(role) => '$role/auth/login';
  static confirmEmail(role) => '$role/auth/confirmEmail';
  static register(role) => '$role/auth/register';
  static resetPassword(role) => '$role/auth/passwordReset';
  static confirmResetPassword(role) => '$role/auth/passwordResetConfirm';
  static updatePassword(role) => '$role/auth/updatePassword';
  static resend(role) => '$role/auth/sendEmailConfirmation';
  static changePassword(role) => '$role/profile/changePassword';

  static getProfile(role, id) => '$role/profile/profile/$id';
  static updateProfile(role, id) => '$role/profile/update/$id';
  static postOffer(role) => '$role/offer/postOffer';
  static homeUsers(role, userType) => '$role/$userType/${userType}_list';
  static homeOffers(role) => '$role/offer/list_available';
  static homeRides(role, id) => '$role/reservation/hasCurrent/$id';
  static checkExpiredContracts(role, id) => '$role/reservation/hasPending/$id';
  static sendExpiredContractRate(role, id) =>
      '$role/reservation/${role}Approval/$id';
  static myOffers(role, id) => '$role/offer/listOffers/$id';
  static deleteOffer(role, id) => '$role/offer/deleteOffer/$id';
  static viewMyOffers(role, id) => '$role/offer/view_my_offer/$id';
  static requestDetails(role, id) => '$role/offer/view_request_offer/$id';
  static offerDetails(role, id) => '$role/offer/view_offer/$id';

  ///Followers For client only
  static followers(id) => 'client/profile/followers_list/$id';
  static addFollower(id) => 'client/profile/add_follower/$id';
  static updateFollower(id) => 'client/profile/update_follower/$id';
  static deleteFollower(id) => 'client/profile/delete_follower/$id';

  static getWishList(role, id) => '$role/favorites/index/$id';
  static postWishList(role, id) => '$role/favorites/addOrDelete/$id';
  static addRequest(role, tripId) => '$role/offer/request_offer/$tripId';
  static specialOffer(role, type, id) => '$role/$type/special_offer/$id';
  static updateRequest(role, id) => '$role/offer/request_update/$id';

  static userProfile(role, type, id) => '$role/$type/profile/$id';
  static myProfile(role, type, id) => '$type/$role/profile/$id';
  static   getOfferFeedback(role,id) => '$role/offer/feedbacks/$id';
  static   getFeedback(role,id) => '$role/feedback/list/$id';
  static   sendFeedback(role,id) => '$role/feedback/feedback/$id';
  static report(role, reportType, id) => '$role/$reportType/report/$id';
  static const String couponURl = 'client/coupon/check';
  static const String reserve = 'client/reservation/reserve';
  static myTrips(role, type, id) => '$role/reservation/$type/$id';
  static myRequests(role, id) => '$role/reservation/pending/$id';

  ///Notifications
  static notifications(role, id) => '$role/notification/notification/$id';
  static readNotification(role, userId, notificationId) =>
      '$role/notification/read/$userId/$notificationId';
  static deleteNotification(role, userId, notificationId) =>
      '$role/notification/delete/$userId/$notificationId';

  ///Payment
  static const String paymentData = 'app/data';
  static transactions(role, type, id) => '$role/payment/$type/$id';

  ///Running Trips
  static dayRides(role, type, id) => "$role/reservation/day${type}Trips/$id";
  static rideDetails(role, id) => "$role/reservation/show/trip/$id";
  static changeRideStatus(String role, id) =>
      "$role/reservation/changeStatusBy${role.capitalize()}/$id";
  static cancelTrip(String role, id) =>
      "$role/reservation/cancelTripBy${role.capitalize()}/$id";
  static sendRideRate(String role, id) =>
      '$role/reservation/tripRatingBy${role.capitalize()}/$id';

  ///App Content
  static const String getContact = 'app/contact';
  static const String getCountries = 'app/countries';
  static const String getBanks = 'app/banks';

  /// maps
  static const String GEOCODE_URI = '/maps/api/geocode/';
  static const String Autocomplete = '/maps/api/place/autocomplete/';
}
