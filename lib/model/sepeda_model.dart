import 'dart:convert';

Sepeda sepedaFromJson(String str) => Sepeda.fromJson(json.decode(str));

String sepedaToJson(Sepeda data) => json.encode(data.toJson());

class Sepeda {
  String? id;
  final String name;
  final int nomor;
  String? imageUrl;

  Sepeda({this.id, required this.name, required this.nomor, this.imageUrl});

  factory Sepeda.fromJson(Map<String, dynamic> json) => Sepeda(
        id: json["id"],
        name: json["name"],
        nomor: json["nomor"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "nomor": nomor,
        "imageUrl": imageUrl,
      };
}
