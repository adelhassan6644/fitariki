class NotificationsModel {
  List<NotificationItem>? notifications;

  NotificationsModel({
    this.notifications,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) =>
      NotificationsModel(
        notifications:
            json["data"] == null || json["data"]["notifications"] == null
                ? []
                : List<NotificationItem>.from(json["data"]["notifications"]!
                    .map((x) => x["data"] != null
                        ? NotificationItem.fromJson(x["data"])
                        : null)),
      );
}

class NotificationItem {
  String? message;
  int? status;
  int? id;
  String? url;

  NotificationItem({
    this.message,
    this.status,
    this.id,
    this.url,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) =>
      NotificationItem(
        message: json["message"],
        status: json["status"],
        id: json["id"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "id": id,
        "url": url,
      };
}
