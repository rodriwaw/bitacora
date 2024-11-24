import 'dart:convert';

class BitacoraModel {
  int? id;
  String fecha;
  String movimiento;
  int idAsociado;
  String? asociado;
  int idLlave;
  String? numLlave;
  int estatus;
  String? fechaEliminado;

  BitacoraModel({
    this.id,
    required this.fecha,
    required this.movimiento,
    required this.idAsociado,
    required this.idLlave,
    required this.estatus,
    this.asociado,
    this.numLlave,
    this.fechaEliminado,
  });

  factory BitacoraModel.fromJson(Map<String, dynamic> json) {
    return BitacoraModel(
      id: json['id'],
      fecha: json['fecha'],
      movimiento: json['movimiento'],
      idAsociado: json['id_asociado'],
      idLlave: json['id_llave'],
      estatus: json['estatus'],
      numLlave: json['num_llave'],
      asociado: json['asociado'],
      fechaEliminado: json['fecha_eliminado'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fecha': fecha,
      'movimiento': movimiento,
      'id_asociado': idAsociado,
      'id_llave': idLlave,
      'estatus': estatus,
      'fecha_eliminado': fechaEliminado,
    };
  }

  static List<BitacoraModel> fromJsonList(List list) {
    return list.map((item) => BitacoraModel.fromJson(item)).toList();
  }

  static List<BitacoraModel> fromMapList(List list) {
    return list.map((item) => BitacoraModel.fromJson(jsonDecode(jsonEncode(item)))).toList();
  }
}
