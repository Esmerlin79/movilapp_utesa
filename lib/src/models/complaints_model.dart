

import 'dart:convert';

ComplaintsModel complaintsModelFromJson(String str)=> ComplaintsModel.fromJson(json.decode(str));

String complaintsModelToJson( ComplaintsModel data ) => json.encode(data.toJson());

class ComplaintsModel {

  String? queja;
  String? estado;
  String? fecha;
  bool success;

  ComplaintsModel({ this.queja, this.estado, this.fecha, this.success = true });

  factory ComplaintsModel.fromJson(Map<String, dynamic> json) => new ComplaintsModel(
    queja    : json["queja"],
    estado   : json["estado"],
    fecha    : json["fecha"], 
    success  : json["ok"], 
  );

  Map<String, dynamic> toJson() => {
    "queja"    : queja,
    "estado"   : estado,
    "fecha"    : fecha,
    "success"  : success,
  };

}