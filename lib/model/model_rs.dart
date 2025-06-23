// To parse this JSON data, do
//
//     final modelRs = modelRsFromJson(jsonString);

import 'dart:convert';

List<ModelRs> modelRsFromJson(String str) => List<ModelRs>.from(json.decode(str).map((x) => ModelRs.fromJson(x)));

String modelRsToJson(List<ModelRs> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelRs {
    int id;
    String nama;
    String alamat;
    String noTelp;
    String type;
    double lat;
    double lng;
    DateTime createdAt;
    DateTime updatedAt;

    ModelRs({
        required this.id,
        required this.nama,
        required this.alamat,
        required this.noTelp,
        required this.type,
        required this.lat,
        required this.lng,
        required this.createdAt,
        required this.updatedAt,
    });

    factory ModelRs.fromJson(Map<String, dynamic> json) => ModelRs(
        id: json["id"],
        nama: json["nama"],
        alamat: json["alamat"],
        noTelp: json["no_telp"],
        type: json["type"],
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "alamat": alamat,
        "no_telp": noTelp,
        "type": type,
        "lat": lat,
        "lng": lng,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
