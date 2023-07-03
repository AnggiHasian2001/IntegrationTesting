import 'dart:convert';

Sepeda sepedaFromJson(String str) => Sepeda.fromJson(json.decode(str));

String sepedaToJson(Sepeda data) => json.encode(data.toJson());

class Sepeda {
  final String id;
  final String name;
  final int nomor;
  Sepeda({
    required this.id,
    required this.name,
    required this.nomor,
  });

  factory Sepeda.fromJson(Map<String, dynamic> json) => Sepeda(
        id: json["id"],
        name: json["name"],
        nomor: json["nomor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "nomor": nomor,
      };
}
