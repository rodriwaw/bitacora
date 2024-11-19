import 'dart:convert';

class DepartamentosModel {
  int id;
  String nombre;

  DepartamentosModel({
    required this.id,
    required this.nombre,
  });

  factory DepartamentosModel.fromJson(Map<String, dynamic> json) {
    return DepartamentosModel(
      id: json['id'],
      nombre: json['nombre'],
    );
  }

  Map<String, dynamic> toJson() => {
        'nombre': nombre,
      };

  static List<DepartamentosModel> fromMapList(List list) {
    // para convertir a json y luego a objeto
    return list.map((item) => DepartamentosModel.fromJson(jsonDecode(jsonEncode(item)))).toList();
  }
}
