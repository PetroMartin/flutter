import 'dart:convert';

List<CamionesJson> camionesListJsonFromJson(String str) =>
    List<CamionesJson>.from(
        json.decode(str).map((x) => CamionesJson.fromJson(x)));

String camionesListJsonToJson(List<CamionesJson> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

CamionesJson camionesJsonFromJson(String str) =>
    CamionesJson.fromJson(json.decode(str));

String camionesJsonToJson(CamionesJson data) => json.encode(data.toJson());

class CamionesJson {
  String idcamion;
  String patente;
  String descripcion;

  CamionesJson({
    required this.idcamion,
    required this.patente,
    required this.descripcion,
  });

  factory CamionesJson.fromJson(Map<String, dynamic> json) => CamionesJson(
        idcamion: json["idcamion"],
        patente: json["patente"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "idcamion": idcamion,
        "patente": patente,
        "descripcion": descripcion,
      };
}
