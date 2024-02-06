class ContactModel {
  int? id;
  String? email;
  String? twitter;
  String? instagram;
  String? website;
  String? phone;
  String? terms;
  String? emergency;

  ContactModel({
    this.id,
    this.email,
    this.twitter,
    this.instagram,
    this.website,
    this.phone,
    this.terms,
    this.emergency,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
        id: json["id"],
        email: json["email"],
        twitter: json["twitter"],
        instagram: json["instagram"],
        website: json["website"],
        phone: json["phone"],
        terms: json["terms"],
        emergency: json["emergency"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "twitter": twitter,
        "instagram": instagram,
        "website": website,
        "phone": phone,
        "terms": terms,
        "emergency": emergency,
      };
}
