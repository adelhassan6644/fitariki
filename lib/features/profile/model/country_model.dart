class Country {
  int? id;
  dynamic createdAt;
  dynamic updatedAt;
  String? iso;
  String? name;
  String? nicename;
  String? iso3;
  int? numcode;
  String? phonecode;

  Country({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.iso,
    this.name,
    this.nicename,
    this.iso3,
    this.numcode,
    this.phonecode,
  });

  Country copyWith({
    int? id,
    dynamic createdAt,
    dynamic updatedAt,
    String? iso,
    String? name,
    String? nicename,
    String? iso3,
    int? numcode,
    String? phonecode,
  }) =>
      Country(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        iso: iso ?? this.iso,
        name: name ?? this.name,
        nicename: nicename ?? this.nicename,
        iso3: iso3 ?? this.iso3,
        numcode: numcode ?? this.numcode,
        phonecode: phonecode ?? this.phonecode,
      );

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    iso: json["iso"],
    name: json["name"],
    nicename: json["nicename"],
    iso3: json["iso3"],
    numcode: json["numcode"],
    phonecode: json["phonecode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "iso": iso,
    "name": name,
    "nicename": nicename,
    "iso3": iso3,
    "numcode": numcode,
    "phonecode": phonecode,
  };
}
