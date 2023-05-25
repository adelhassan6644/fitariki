import 'package:fitariki/main_models/weak_model.dart';
import '../data/config/di.dart';
import '../features/followers/follower_details/model/follower_model.dart';
import '../features/followers/followers/provider/followers_provider.dart';
import '../features/maps/models/location_model.dart';
import 'car_model.dart';

class OfferDetailsModel {
  int? id;
  String? image;
  String? name;
  String? nationality;
  double? rate;
  int? duration;
  double? minPrice;
  double? maxPrice;
  double? compatibleRatio;
  double? startLength;
  DateTime? createdAt;
  List<WeekModel>? offerDays;
  LocationModel? pickLocation;
  LocationModel? endLocation;
  CarModel? carData;
  DateTime? startDate;
  DateTime? endDate;
  List<FollowerModel>? followers;

  OfferDetailsModel(
      {this.id,
      this.image,
      this.nationality,
      this.name,
      this.rate,
      this.duration,
      this.minPrice,
      this.maxPrice,
      this.compatibleRatio,
      this.createdAt,
      this.offerDays,
      this.pickLocation,
      this.endLocation,
      this.startLength,
      this.endDate,
      this.startDate,
        this.followers,
      this.carData});

  OfferDetailsModel copyWith(
          {int? id,
          String? image,
          String? name,
          String? nationality,
          double? rate,
          double? startLength,
          DateTime? startDate,
          DateTime? endDate,
          int? duration,
          double? minPrice,
          double? maxPrice,
          double? compatibleRatio,
          DateTime? createdAt,
          List<WeekModel>? offerDays,
          CarModel? carData}) =>
      OfferDetailsModel(
        id: id ?? this.id,
        image: image ?? this.image,
        name: name ?? this.name,
        nationality: nationality ?? this.nationality,
        rate: rate ?? this.rate,
        duration: duration ?? this.duration,
        minPrice: minPrice ?? this.minPrice,
        maxPrice: maxPrice ?? this.maxPrice,
        compatibleRatio: compatibleRatio ?? this.compatibleRatio,
        createdAt: createdAt ?? this.createdAt,
        offerDays: offerDays ?? this.offerDays,
        carData: carData ?? this.carData,
        startLength: startLength ?? this.startLength,
      );

  factory OfferDetailsModel.fromJson(Map<String, dynamic> json) =>
      OfferDetailsModel(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        nationality: json["nationality"],
        rate: json["rate"]?.toDouble(),
        duration: json["duration"],
        minPrice: json["min_price"]?.toDouble(),
        maxPrice: json["max_price"]?.toDouble(),
        startLength: json["start_length"]?.toDouble(),
        compatibleRatio: json["compatible_ratio"]?.toDouble(),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        offerDays: json["offer_days"] == null
            ? null
            : List<WeekModel>.from(
                json["offer_days"]!.map((x) => WeekModel.fromJson(x))),
        pickLocation: json["pick_location"] == null
            ? null
            : LocationModel.fromJson(json["pick_location"]),
        endLocation: json["end_location"] == null
            ? null
            : LocationModel.fromJson(json["end_location"]),
        carData: json["car_data"] == null
            ? null
            : CarModel.fromJson(json["car_data"]),
      );

  Map<String, dynamic> toPostDriverJson() => {
        "offer": {
          "driver_id": id,
          "start_date": startDate.toString(),
          "end_date": endDate.toString(),
          "duration": duration,
          "min_price": minPrice,
          "max_price": maxPrice,
          "offer_type": 1,
          "offer_days": offerDays == null
              ? []
              : List<dynamic>.from(offerDays!.map((x) => x.toJson())),
          "pickup_location": pickLocation?.toJson(),
          "drop_off_location": endLocation?.toJson()
        }
      };

  Map<String, dynamic> toPostClientJson() => {
        "offer": {
          "client_id": id,
          "start_date": startDate.toString(),
          "end_date": endDate.toString(),
          "duration": duration,
          "min_price": minPrice,
          "max_price": maxPrice,
          "offer_type": 1,
          "offer_days": offerDays == null
              ? []
              : List<dynamic>.from(offerDays!.map((x) => x.toJson())),
          "pickup_location": pickLocation?.toJson(),
          "drop_off_location": endLocation?.toJson(),
          if (sl.get<FollowersProvider>().addFollowers)
            "offer_followers": List<dynamic>.from(sl
                .get<FollowersProvider>()
                .selectedFollowers
                .map((x) => x.toPostJson()))

        }
      };
}
