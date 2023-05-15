import 'package:fitariki/main_models/weak_model.dart';

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

  OfferModel({
    this.id,
    this.image,
    this.name,
    this.rate,
    this.duration,
    this.minPrice,
    this.maxPrice,
    this.compatibleRatio,
    this.createdAt,
    this.offerDays,
  });

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
      };
}
