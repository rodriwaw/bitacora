//aqui va el modelo del asociado que se obtiene de la base de datos

import 'dart:convert';

class AsociadosModel {
  int? id;
  String numeroAsociado;
  int departamento; // Se puede cambiar por un objeto DepartamentoEntity
  String nombre;
  String apellidoPaterno;
  String apellidoMaterno;
  // String alias;
  String fechaAlta;
  String? fechaBaja;
  int estatus;
  String? numLlave;

  AsociadosModel({
    this.id,
    required this.numeroAsociado,
    required this.nombre,
    required this.departamento,
    required this.estatus,
    required this.fechaAlta,
    this.fechaBaja,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
    //   required this.alias,
    this.numLlave,
  });

  factory AsociadosModel.fromJson(Map<String, dynamic> json) {
    return AsociadosModel(
      id: json['id'],
      numeroAsociado: json['num_asociado'],
      nombre: json['nombre'],
      departamento: json['id_departamento'],
      estatus: json['estatus'],
      fechaAlta: json['fecha_alta'],
      fechaBaja: json['fecha_baja'],
      apellidoPaterno: json['apellido_paterno'],
      apellidoMaterno: json['apellido_materno'],
      numLlave: json['num_llave'],
//      alias: json['alias'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'num_asociado': numeroAsociado,
      'nombre': nombre,
      'id_departamento': departamento,
      'estatus': estatus,
      'fecha_alta': fechaAlta,
      'fecha_baja': fechaBaja,
      'apellido_paterno': apellidoPaterno,
      'apellido_materno': apellidoMaterno,
      //  'num_llave': numLlave,
      //     'alias': alias,
    };
  }

  //devuelve una lista de asociados a partir de una lista de json
  static List<AsociadosModel> fromJsonList(List list) {
    return list.map((item) => AsociadosModel.fromJson(item)).toList();
  }

  static List<AsociadosModel> fromMapList(List list) {
    return list.map((item) => AsociadosModel.fromJson(jsonDecode(jsonEncode(item)))).toList();
  }
}

class AsociadosConLlaveModel {
  int id;
  String nombre;
  String? numAsociado;
  String? departamento;
  String? numLlave;
  int? idLlave;

  AsociadosConLlaveModel({
    required this.id,
    required this.nombre,
    this.numAsociado,
    this.departamento,
    this.numLlave,
    this.idLlave,
  });

  factory AsociadosConLlaveModel.fromJson(Map<String, dynamic> json) {
    return AsociadosConLlaveModel(
      id: json['id'],
      nombre: json['nombre'],
      numAsociado: json['num_asociado'],
      departamento: json['departamento'],
      numLlave: json['num_llave'],
      idLlave: json['id_llave'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'num_asociado': numAsociado,
      'departamento': departamento,
      'num_llave': numLlave,
    'id_llave': idLlave,
    };
  }

  //devuelve una lista de asociados a partir de una lista de json
  static List<AsociadosConLlaveModel> fromJsonList(List list) {
    return list.map((item) => AsociadosConLlaveModel.fromJson(item)).toList();
  }

  static List<AsociadosConLlaveModel> fromMapList(List list) {
    return list.map((item) => AsociadosConLlaveModel.fromJson(jsonDecode(jsonEncode(item)))).toList();
  }
}
