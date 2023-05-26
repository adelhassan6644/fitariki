class Bank {
  int? id;
  String? name;


  Bank({
    this.id,
    this.name,
  });

  Bank copyWith({
    int? id,
    String? name,
  }) =>
      Bank(
        id: id ?? this.id,
        name: name ?? this.name,

      );

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
    id: json["id"],
    name: json["name"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,

  };
}
