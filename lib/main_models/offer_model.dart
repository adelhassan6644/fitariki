import 'package:fitariki/main_models/weak_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app/core/utils/app_storage_keys.dart';
import '../data/config/di.dart';
import '../features/followers/followers/provider/followers_provider.dart';
import '../features/maps/models/location_model.dart';
import '../features/profile/model/client_model.dart';
import '../features/profile/model/driver_model.dart';
import '../features/request_details/model/offer_request_details_model.dart';

class OfferModel {
  int? id;
  String? image;
  String? name;
  double? rate;
  int? duration;
  double? minPrice;
  int? clientId;
  int? driverId;
  double? maxPrice;
  double? compatibleRatio;
  DateTime? createdAt;
  List<WeekModel>? offerDays;
  LocationModel? dropOffLocation;
  LocationModel? pickupLocation;
  DriverModel? driverModel;
  ClientModel? clientModel;
  List<OfferRequestDetailsModel>? offerRequests;

  DateTime? startDate;
  DateTime? endDate;

  OfferModel(
      {this.id,
      this.image,
      this.name,
      this.rate,
      this.duration,
      this.minPrice,
      this.maxPrice,
      this.compatibleRatio,
      this.createdAt,
      this.offerDays,
      this.clientId,
      this.driverId,
      this.dropOffLocation,
      this.pickupLocation,
      this.offerRequests,
      this.driverModel,
      this.clientModel,
      this.startDate,
      this.endDate});

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
      id: json["id"],
      image: json["image"],
      name: json["name"],
      rate: json["rate"]?.toDouble(),
      duration: json["duration"],
      clientId: json["client_id"],
      driverId: json["driver_id"],
      minPrice: json["min_price"]?.toDouble(),
      maxPrice: json["max_price"]?.toDouble(),
      compatibleRatio: json["compatible_ratio"]?.toDouble(),
      startDate: DateTime.parse(json["start_date"]??DateTime.now().toString()),
      endDate: DateTime.parse(json["end_date"]??DateTime.now().toString()),
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      offerDays: json["offer_days"] == null
          ? null
          : List<WeekModel>.from(
              json["offer_days"]!.map((x) => WeekModel.fromJson(x))),
      driverModel:
          json["driver"] != null ? DriverModel.fromJson(json["driver"]) : null,
      clientModel:
          json["client"] != null ? ClientModel.fromJson(json["client"]) : null,
      pickupLocation: json["pickup_location"] == null
          ? null
          : LocationModel.fromJson(json["pickup_location"]),
      dropOffLocation: json["drop_off_location"] == null
          ? null
          : LocationModel.fromJson(json["drop_off_location"]),
      offerRequests: json["offer_requests"] == null
          ? null
          : List<OfferRequestDetailsModel>.from(json["offer_requests"]!
              .map((x) => OfferRequestDetailsModel.fromJson(x))));

  Map<String, dynamic> toPostDriverJson() => {
        "offer": {
          "id": id,
          "start_date": startDate.toString(),
          "end_date": endDate.toString(),
          "duration": duration,
          "min_price": minPrice,
          "max_price": maxPrice,
          "client_id": clientId,
          "driver_id":
              sl.get<SharedPreferences>().getString(AppStorageKey.userId),
          "offer_type": 1,
          "offer_days": offerDays == null
              ? []
              : List<dynamic>.from(offerDays!.map((x) => x.toJson())),
          "pickup_location": pickupLocation?.toJson(),
          "drop_off_location": dropOffLocation?.toJson()
        }
      };

  Map<String, dynamic> toPostClientJson() => {
        "offer": {
          "client_id":
              sl.get<SharedPreferences>().getString(AppStorageKey.userId),
          "start_date": startDate.toString(),
          "end_date": endDate.toString(),
          "duration": duration,
          "min_price": minPrice,
          "max_price": maxPrice,
          "offer_type": 1,
          "offer_days": offerDays == null
              ? []
              : List<dynamic>.from(offerDays!.map((x) => x.toJson())),
          "pickup_location": pickupLocation?.toJson(),
          "drop_off_location": dropOffLocation?.toJson(),
          if (sl.get<FollowersProvider>().addFollowers)
            "offer_followers": List<dynamic>.from(sl
                .get<FollowersProvider>()
                .selectedFollowers
                .map((x) => x.toPostJson()))
        }
      };
}
