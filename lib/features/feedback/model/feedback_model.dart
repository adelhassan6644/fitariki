import '../../profile/model/client_model.dart';
import '../../profile/model/driver_model.dart';

class FeedbackModel {
  List<FeedbackItem>? feedbacks;

  FeedbackModel({this.feedbacks});

  factory FeedbackModel.fromJson(Map<String, dynamic> json) => FeedbackModel(
        feedbacks: json["data"]["feedbacks"] == null
            ? []
            : List<FeedbackItem>.from(
                json["data"]["feedbacks"].map((x) => FeedbackModel.fromJson(x))),
      );
}

class FeedbackItem {
  int? id;
  bool? isSeen;
  double? rate;
  String? feedback;
  DriverModel? driverModel;
  ClientModel? clientModel;
  DateTime? createdAt;

  FeedbackItem(
      {this.id,
      this.isSeen,
      this.rate,
      this.feedback,
      this.createdAt,
      this.driverModel,
      this.clientModel});

  factory FeedbackItem.fromJson(Map<String, dynamic> json) => FeedbackItem(
      id: json["id"],
      rate: double.parse(json["rate"] ?? "0".toString()),
      feedback: json["feedback"],
      createdAt: DateTime.parse(json["created_at"]),
      isSeen: json["is_seen"],
      // isSeen: sl<FeedbackRepo>().feedbacks!.contains(json["id"]) ,
      clientModel:
          json["client"] != null ? ClientModel.fromJson(json["client"]) : null,
      driverModel:
          json["driver"] != null ? DriverModel.fromJson(json["driver"]) : null);
}
