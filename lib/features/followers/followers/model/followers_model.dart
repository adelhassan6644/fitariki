import '../../follower_details/model/follower_model.dart';

class FollowersModel {
  List<FollowerModel>? data;

  FollowersModel({
    this.data,
  });

  FollowersModel copyWith({
    List<FollowerModel>? data,
  }) =>
      FollowersModel(
        data: data ?? this.data,
      );

  factory FollowersModel.fromJson(Map<String, dynamic> json) => FollowersModel(
        data: json["data"]["client"] == null
            ? []
            : List<FollowerModel>.from(
                json["data"]!.map((x) => FollowerModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
