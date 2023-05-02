class UserModel {
  Client? client;

  UserModel({this.client,});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    client: json["client"] == null ? null : Client.fromJson(json["client"]),
  );

  Map<String, dynamic> toJson() => {
    "client": client?.toJson(),
  };
}

class Client {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? image;
  String? nickname;
  String? gender;
  String? age;
  String? national;
  String? city;
  String? countryId;
  String? phone;
  String? status;
  String? rate;
  int? newUser;

  Client({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.image,
    this.nickname,
    this.gender,
    this.age,
    this.national,
    this.city,
    this.countryId,
    this.phone,
    this.status,
    this.rate,
    this.newUser,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
    id: json["id"].toString(),
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    image: json["image"],
    nickname: json["nickname"],
    gender: json["gender"],
    age: json["age"],
    national: json["national"],
    city: json["city"],
    countryId: json["country_id"],
    phone: json["phone"],
    status: json["status"],
    rate: json["rate"].toString(),
    newUser: json["new_user"],
  );

  Map<String, dynamic> toJson() => {
    "id": id.toString(),
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "image": image,
    "nickname": nickname,
    "gender": gender,
    "age": age,
    "national": national,
    "city": city,
    "country_id": countryId,
    "phone": phone,
    "status": status,
    "rate": rate.toString(),
    "new_user": newUser,
  };
}
