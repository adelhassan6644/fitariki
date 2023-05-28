import 'package:fitariki/main_models/weak_model.dart';
import '../features/maps/models/location_model.dart';
import '../features/my_offers/model/my_offer.dart';

class OfferModel {
  int? id;
  String? image;
  String? name;
  double? rate;
  int? duration;
  double? minPrice;
  double? maxPrice;
  double? compatibleRatio;
  DateTime? createdAt;
  List<WeekModel>? offerDays;
  LocationModel? dropOffLocation;
  LocationModel? pickupLocation;
  List<OfferRequest>? offerRequests;
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
      this.dropOffLocation,
      this.pickupLocation,

      this.offerRequests});

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        rate: json["rate"]?.toDouble(),
        duration: json["duration"],
        minPrice: json["min_price"]?.toDouble(),
        maxPrice: json["max_price"]?.toDouble(),
        compatibleRatio: json["compatible_ratio"]?.toDouble(),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        offerDays: json["offer_days"] == null
            ? null
            : List<WeekModel>.from(
                json["offer_days"]!.map((x) => WeekModel.fromJson(x))),
        pickupLocation: json["pickup_location"] == null
            ? null
            : LocationModel.fromJson(json["pickup_location"]),
        dropOffLocation: json["drop_off_location"] == null
            ? null
            : LocationModel.fromJson(json["drop_off_location"]),
        offerRequests:  json["offer_requests"] == null ? [] : List<OfferRequest>.from(json["offer_requests"]!.map((x) => OfferRequest.fromJson(x)))

  );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "rate": rate,
        "duration": duration,
        "min_price": minPrice,
        "max_price": maxPrice,
        "compatible_ratio": compatibleRatio,
        "created_at": createdAt?.toIso8601String(),
        "offer_days": offerDays == null
            ? []
            : List<dynamic>.from(offerDays!.map((x) => x.toJson())),
        "drop_off_location": dropOffLocation?.toJson(),
        "pickup_location": pickupLocation?.toJson(),
        "offer_requests": offerRequests == null
            ? []
            : List<dynamic>.from(offerRequests!.map((x) => x)),
      };
}
