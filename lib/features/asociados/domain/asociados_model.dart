//aqui va el modelo del asociado que se obtiene de la base de datos

class AsociadosModel {
  int id;
  int numeroAsociado;
  String departamento; // Se puede cambiar por un objeto DepartamentoEntity
  String nombre;
  String apellidoPaterno;
  String apellidoMaterno;
  String alias;
  String fechaAlta;
  String? fechaBaja;
  int estatus;

  AsociadosModel({
    this.id = 0,
    required this.numeroAsociado,
    required this.nombre,
    required this.departamento,
    required this.estatus,
    required this.fechaAlta,
    this.fechaBaja,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
    required this.alias,
  });

  factory AsociadosModel.fromJson(Map<String, dynamic> json) {
    return AsociadosModel(
      id: json['id'],
      numeroAsociado: json['num_asociado'],
      nombre: json['nombre'],
      departamento: json['departamento'],
      estatus: json['estatus'],
      fechaAlta: json['fecha_alta'],
      fechaBaja: json['fecha_baja'],
      apellidoPaterno: json['apellido_paterno'],
      apellidoMaterno: json['apellido_materno'],
      alias: json['alias'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'num_asociado': numeroAsociado,
      'nombre': nombre,
      'departamento': departamento,
      'estatus': estatus,
      'fecha_alta': fechaAlta,
      'fecha_baja': fechaBaja,
      'apellido_paterno': apellidoPaterno,
      'apellido_materno': apellidoMaterno,
      'alias': alias,
    };
  }

  //devuelve una lista de asociados a partir de una lista de json
  static List<AsociadosModel> fromJsonList(List list) {
    return list.map((item) => AsociadosModel.fromJson(item)).toList();
  }

  static List<AsociadosModel> fromMapList(List list) {
    return list.map((item) => AsociadosModel.fromJson(item)).toList();
  }
}
