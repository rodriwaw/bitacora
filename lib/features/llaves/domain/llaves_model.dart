import 'dart:convert';

class LlavesModel {
  int? id;
  String numLlave;
  String descripcion;
  String fechaAlta;
  String? fechaBaja;
  int estatus;
  int? idAsociado;

  LlavesModel({
     this.id ,
    required this.numLlave,
    required this.descripcion,
    required this.fechaAlta,
    this.fechaBaja,
    required this.estatus, // 1 = Activa, 0 = Inactiva, 1 = Activa y asignada, 0 = Inactiva y asignada, 
    this.idAsociado,
  });

  factory LlavesModel.fromJson(Map<String, dynamic> json) {
    return LlavesModel(
      id: json['id'],
      numLlave: json['num_llave'],
      descripcion: json['descripcion'],
      fechaAlta: json['fecha_alta'],
      fechaBaja: json['fecha_baja'],
      estatus: json['estatus'],
      idAsociado: json['asignada_a'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'num_llave': numLlave,
      'descripcion': descripcion,
      'fecha_alta': fechaAlta,
      'fecha_baja': fechaBaja,
      'estatus': estatus,
      'asignada_a': idAsociado,
    };
  }

  static List<LlavesModel> fromJsonList(List list) {
    return list.map((item) => LlavesModel.fromJson(item)).toList();
  }

  static List<LlavesModel> fromMapList(List list) {
    return list.map((item) => LlavesModel.fromJson(jsonDecode(jsonEncode(item)))).toList();
  }
}
