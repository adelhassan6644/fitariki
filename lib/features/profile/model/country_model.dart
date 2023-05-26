class Country {
  int? id;
  String? iso;
  String? name;
  String? niceName;
  String? iso3;
  int? numcode;
  String? phonecode;

  Country({
    this.id,
    this.iso,
    this.name,
    this.niceName,
    this.iso3,
    this.numcode,
    this.phonecode,
  });

  Country copyWith({
    int? id,
    String? iso,
    String? name,
    String? nicename,
    String? iso3,
    int? numcode,
    String? phonecode,
  }) =>
      Country(
        id: id ?? this.id,
        iso: iso ?? this.iso,
        name: name ?? this.name,
        niceName: nicename ?? this.niceName,
        iso3: iso3 ?? this.iso3,
        numcode: numcode ?? this.numcode,
        phonecode: phonecode ?? this.phonecode,
      );

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["id"],
    iso: json["iso"],
    // name: json["name"],
    name: json["nicename"],
    niceName: json["nicename"],
    iso3: json["iso3"],
    numcode: json["numcode"],
    phonecode: json["phonecode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "iso": iso,
    "name": name,
    "nicename": niceName,
    "iso3": iso3,
    "numcode": numcode,
    "phonecode": phonecode,
  };
}
