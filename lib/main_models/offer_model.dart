import 'package:fitariki/main_models/weak_model.dart';
import '../features/maps/models/address_model.dart';

class OfferModel {
  int? id;
  String? name;
  LocationModel? dropOff;
  LocationModel? dropOn;
  DateTime? startDate;
  DateTime? endDate;
  int? duration;
  double? minPrice;
  double? maxPrice;
  int? offerType;
  int? driverId;
  dynamic clientId;
  List<WeekModel>? offerDays;

  OfferModel({
    this.id,
    this.name,
    this.dropOff,
    this.dropOn,
    this.startDate,
    this.endDate,
    this.duration,
    this.minPrice,
    this.maxPrice,
    this.offerType,
    this.driverId,
    this.clientId,
    this.offerDays,
  });

  OfferModel copyWith({
    int? id,
    String? name,
    LocationModel? dropOff,
    LocationModel? dropOn,
    DateTime? startDate,
    DateTime? endDate,
    int? duration,
    double? minPrice,
    double? maxPrice,
    int? offerType,
    int? driverId,
    dynamic clientId,
    List<WeekModel>? offerDays,
  }) =>
      OfferModel(
        id: id ?? this.id,
        name: name ?? this.name,
        dropOff: dropOff ?? this.dropOff,
        dropOn: dropOn ?? this.dropOn,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        duration: duration ?? this.duration,
        minPrice: minPrice ?? this.minPrice,
        maxPrice: maxPrice ?? this.maxPrice,
        offerType: offerType ?? this.offerType,
        driverId: driverId ?? this.driverId,
        clientId: clientId ?? this.clientId,
        offerDays: offerDays ?? this.offerDays,
      );

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
        id: json["id"],
        name: json["name"],
        dropOff: json["drop_off_location"] == null
            ? null
            : LocationModel.fromJson(json["drop_off_location"]),
        dropOn: json["pickup_location"] == null
            ? null
            : LocationModel.fromJson(json["pickup_location"]),
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        duration: json["duration"],
        minPrice: json["min_price"]?.toDouble(),
        maxPrice: json["max_price"]?.toDouble(),
        offerType: json["offer_type"],
        driverId: json["driver_id"],
        clientId: json["client_id"],
        offerDays: json["offer_days"] == null
            ? []
            : List<WeekModel>.from(
                json["offer_days"]!.map((x) => WeekModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        // "id": id,
        "name": name ?? "",
        "drop_off_location": dropOff?.toJson(),
        "pickup_location": dropOn?.toJson(),
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "duration": duration,
        "min_price": minPrice,
        "max_price": maxPrice,
        "offer_type": offerType,
        "driver_id": driverId,
        "offer_days": offerDays == null
            ? []
            : List<dynamic>.from(offerDays!.map((x) => x.toJson())),
      };
}
