import '../../../app/core/utils/methods.dart';
import '../../../main_models/weak_model.dart';
import '../../maps/models/location_model.dart';
import '../../profile/model/client_model.dart';
import '../../profile/model/driver_model.dart';

class PreviousTripDetailsModel {
  ClientModel? client;
  DriverModel? driver;
  DateTime? startDate;
  int? type;
  LocationModel? dropOffLocation;
  LocationModel? pickupLocation;
  int? numOfCancelTrips;
  int? cancelValue;
  String? paymentMethod;
  String? invoice;
  int? percentage;
  int? amount;
  int? total;
  List<WeekModel>? days;

  PreviousTripDetailsModel(
      {this.client,
      this.driver,
      this.startDate,
      this.type,
      this.dropOffLocation,
      this.pickupLocation,
      this.percentage,
      this.numOfCancelTrips,
      this.cancelValue,
      this.paymentMethod,
      this.invoice,
      this.amount,
      this.total,
      this.days});

  PreviousTripDetailsModel.fromJson(Map<String, dynamic> json) {
    client =
        json['client'] != null ? ClientModel.fromJson(json['client']) : null;
    driver =
        json['driver'] != null ? DriverModel.fromJson(json['driver']) : null;
    startDate = json["start_at"] == null
        ? DateTime.now()
        : Methods.convertStringToDataTime(json["start_at"]);
    type = json['type'];
    dropOffLocation = json['drop_off_location'] != null
        ? LocationModel.fromJson(json['drop_off_location'])
        : null;
    pickupLocation = json['pickup_location'] != null
        ? LocationModel.fromJson(json['pickup_location'])
        : null;
    percentage = json['percentage'];
    numOfCancelTrips = json['numOfCancelTrips'];
    cancelValue = json['cancelValue'];
    paymentMethod = json['paymentMethod'];
    invoice = json['invoice'];
    amount = json['amount'];
    total = json['total'];
    if (json['days'] != null) {
      days = [];
      json['days'].forEach((v) {
        days!.add(WeekModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['client'] = client?.toJson();
    data['driver'] = driver?.toJson();
    data['start_date'] = startDate;
    data['type'] = type;
    if (dropOffLocation != null) {
      data['drop_off_location'] = dropOffLocation!.toJson();
    }
    if (pickupLocation != null) {
      data['pickup_location'] = pickupLocation!.toJson();
    }
    data['numOfCancelTrips'] = numOfCancelTrips;
    data['cancelValue'] = cancelValue;
    data['paymentMethod'] = paymentMethod;
    data['invoice'] = invoice;
    data['amount'] = amount;
    data['total'] = total;
    if (days != null) {
      data['days'] = days!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
