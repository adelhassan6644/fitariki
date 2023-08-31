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
  static const String getProfile = 'profile/profile';
  static const String getCountries = '/app/countries';
  static const String getBanks = '/app/banks';
  static const String updateProfile = 'profile/update';
  static const String postOffer = 'offer/postOffer';
  static const String listOffers = 'offer/listOffers';
  static homeUsers(role, userType) => '$role/$userType/${userType}_list';
  static homeOffers(role) => '$role/offer/list_available';
  static homeRides(role, id) => '$role/reservation/hasCurrent/$id';
  static const String availableOffers = '';
  static myOffers(role, id) => '$role/offer/listOffers/$id';

  // static const String myOffers = 'offer/listOffers';
  static const String deleteOffer = 'offer/deleteOffer';
  static const String viewMyOffers = 'offer/view_my_offer';
  static const String requestDetails = 'offer/view_request_offer';
  static const String offerDetails = 'offer/view_offer';
  static followers(id) => 'client/profile/followers_list/$id';
  static const String addFollower = 'profile/add_follower';
  static const String updateFollowerDetails = 'profile/update_follower';
  static const String deleteFollower = 'profile/delete_follower';
  static const String getContact = 'app/contact';
  static const String getWishList = 'favorites/index';
  static const String postWishList = 'favorites/addOrDelete';
  static addRequest(role, tripId) => '$role/offer/request_offer/$tripId';
  static specialOffer(role, type, id) => '$role/$type/special_offer/$id';
  static const String updateRequest = 'offer/request_update';
  static userProfile(role, type, id) => '$role/$type/profile/$id';
  static myProfile(role, type, id) => '$type/$role/profile/$id';
  static const String getFeedback = 'feedback/list';
  static const String getOfferFeedback = 'offer/feedbacks';
  static const String sendFeedback = 'feedback/feedback';
  static const String report = 'report';
  static const String couponURl = 'client/coupon/check';
  static const String reserve = 'client/reservation/reserve';
  static const String myTrips = 'reservation';
  static const String myRequests = 'reservation/pending';
  static const String notifications = 'notification/notification';
  static transactions(role,type, id) => '$role/payment/$type/$id';
  static const String readNotification = 'notification/read';
  static const String deleteNotification = 'notification/delete';
  static const String paymentData = 'app/data';
  static dayRides(role, type, id) => "$role/reservation/day${type}Trips/$id";
  static rideDetails(role, id) => "$role/reservation/show/trip/$id";
  static changeRideStatus(String role, id) =>
      "$role/reservation/changeStatusBy${role.capitalize()}/$id";
  static cancelTrip(String role, id) => "$role/reservation/cancelTripBy${role.capitalize()}/$id";
  static sendRideRate(String role, id) => '$role/reservation/tripRatingBy${role.capitalize()}/$id';


  /// maps
  static const String GEOCODE_URI = '/maps/api/geocode/';
  static const String Autocomplete = '/maps/api/place/autocomplete/';

}
