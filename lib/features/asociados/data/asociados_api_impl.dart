import 'package:sqflite/sqflite.dart';

import '../../../core/utils/api_response.dart';
import '../../../core/utils/injections.dart';
import '../../../shared/data/database.dart';
import '../domain/asociados_model.dart';
import 'abstract_asociados_api.dart';

//aqui va la implementacion de la clase AsociadoImplApi
class AsociadosApiImpl extends AbstractAsociadosApi {
  AsociadosApiImpl();

  //override de la funcion getAllAsociados
  @override
  Future<List<AsociadosModel>> getAllAsociados() async {
    //obtener todos los asociados
    try {
      //aqui se obtienen los asociados de la base de datos
      Database db = sl.get<DBCreator>().database;
      List<Map<String, dynamic>> asociados = await db.query('asociados', where: 'estatus = ?', whereArgs: [1]);
      //prod
      return AsociadosModel.fromMapList(asociados);
      //test
      /* await Future.delayed(Duration(seconds: 2));
      return []; */
    } catch (e) {
      throw (e.toString());
    }
  }

  @override
  Future<List<AsociadosConLlaveModel>> getAllAsociadosConLlaveDisponible() async {
    try {
      Database db = sl.get<DBCreator>().database;
      List<Map<String, dynamic>> asociados = await db.rawQuery(
          '''SELECT A.id, A.num_asociado, (A.nombre || " "  || A.apellido_paterno || " "  || A.apellido_materno) AS nombre, 
          L.num_llave, L.id AS id_llave, D.nombre AS departamento
          FROM asociados as A
          INNER JOIN 
          llaves as L 
          ON A.id = L.asignada_a
          JOIN departamentos as D
          ON A.id_departamento = D.id
          WHERE A.estatus = 1 AND L.estatus = 2;''');
      return AsociadosConLlaveModel.fromMapList(asociados);
    } catch (e) {
      throw (e.toString());
    }
  }

  @override
  Future<List<AsociadosConLlaveModel>> getAllAsociadosConLlavePrestada() async {
    try {
      Database db = sl.get<DBCreator>().database;
      List<Map<String, dynamic>> asociados = await db.rawQuery(
          '''SELECT A.id, A.num_asociado, (A.nombre || " "  || A.apellido_paterno || " "  || A.apellido_materno) AS nombre, 
          L.num_llave, L.id AS id_llave, D.nombre AS departamento
          FROM asociados as A
          INNER JOIN 
          llaves as L 
          ON A.id = L.asignada_a
          JOIN departamentos as D
          ON A.id_departamento = D.id
          WHERE A.estatus = 1 AND L.estatus = 3;''');
      return AsociadosConLlaveModel.fromMapList(asociados);
    } catch (e) {
      throw (e.toString());
    }
  }

  @override
  Future<AsociadosModel> getAsociado(int id) async {
    try {
      Database db = sl.get<DBCreator>().database;
      List<Map<String, dynamic>> asociado = await db.query('asociados', where: 'id = ?', whereArgs: [id]);
      if (asociado.isEmpty) {
        throw ('No se encontró el asociado');
      }
      return AsociadosModel.fromJson(asociado.first);
      /* return AsociadosModel(
        id: 1,
        numeroAsociado: 1,
        nombre: 'Luis Rodrigo',
        departamento: 'Sistemas',
        estatus: 1,
        fechaAlta: '2024-10-27',
      ); */
    } catch (e) {
      throw (e.toString());
    }
  }

  @override
  Future<AsociadosConLlaveModel> getAsociadoByNum(String numAsociado) async {
    try {
      Database db = sl.get<DBCreator>().database;
      List<Map<String, dynamic>> asociado = await db.rawQuery(
          '''SELECT A.id, A.num_asociado, (A.nombre || " "  || A.apellido_paterno || " "  || A.apellido_materno) AS nombre, 
          L.num_llave, L.id AS id_llave, D.nombre AS departamento, L.estatus AS estatus_llave
          FROM asociados as A
          INNER JOIN 
          llaves as L 
          ON A.id = L.asignada_a
          JOIN departamentos as D
          ON A.id_departamento = D.id
          WHERE A.estatus = 1  AND A.num_asociado = $numAsociado;''');
      // AND L.estatus = 3
      if (asociado.isEmpty) {
        throw ('El asociado con el número $numAsociado no existe');
      }
      if (asociado.first['estatus_llave'] != 3) {
        throw ('La llave ${asociado.first['num_llave']} no ha sido prestada');
      }
      return AsociadosConLlaveModel.fromJson(asociado.first);
    } catch (e) {
      throw (e.toString());
    }
  }

  @override
  Future<ApiResponse> createAsociado(AsociadosModel asociado) async {
    try {
      Database db = sl.get<DBCreator>().database;
      var dbExecResult = await db.insert('asociados', asociado.toJson());
      if (dbExecResult != 0) {
        return Success(true, 'Asociado creado correctamente');
      }
      return Failure(false, 'No se pudo crear el asociado. $dbExecResult');
    } catch (e) {
      return Failure(false, e.toString());
    }
  }

  @override
  Future<ApiResponse> updateAsociado(AsociadosModel asociado) async {
    try {
      Database db = sl.get<DBCreator>().database;
      var dbExecResult = await db.update('asociados', asociado.toJson(), where: 'id = ?', whereArgs: [asociado.id]);
      if (dbExecResult != 0) {
        return Success(true, 'Asociado actualizado correctamente');
      }
      return Failure(false, 'No se pudo actualizar el asociado');
    } catch (e) {
      return Failure(false, e.toString());
    }
  }

  @override
  Future<ApiResponse> deleteAsociado(AsociadosModel asociado) async {
    try {
      Database db = sl.get<DBCreator>().database;
      //remove llave from asociado
      var dbExecResult = await db.update('llaves', {'estatus': 1, 'asignada_a': null},
          where: 'asignada_a = ?', whereArgs: [asociado.id]);
      if (dbExecResult == 0) {
        return Failure(false, 'No se pudo eliminar la llave del asociado');
      }
      asociado.estatus = 0; //cambiar el estatus a 0
      asociado.fechaBaja = DateTime.now().toString(); //agregar la fecha de baja
      dbExecResult = await db.update('asociados', asociado.toJson(), where: 'id = ?', whereArgs: [asociado.id]);
      if (dbExecResult == 1) {
        return Success(true, 'Asociado eliminado correctamente');
      }
      return Failure(false, 'No se pudo eliminar el asociado');
    } catch (e) {
      return Failure(false, e.toString());
    }
  }
}

/*   var db = await openDatabase(path, readOnly: true);
  print("Database is ready"); */
