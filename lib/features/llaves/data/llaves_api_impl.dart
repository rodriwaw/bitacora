import 'package:bitacora/core/utils/injections.dart';
import 'package:bitacora/features/llaves/data/abstract_llaves_api.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/utils/api_response.dart';
import '../../../shared/data/database.dart';
import '../domain/llaves_model.dart';

class LlavesApiImpl extends AbstractLlavesApi {
  LlavesApiImpl();

  @override
  Future<List<LlavesModel>> getAllLlaves() async {
    try {
      //aqui se obtienen los asociados de la base de datos
      Database db = sl.get<DBCreator>().database;
      List<Map<String, dynamic>> llaves = await db.query('llaves', where: 'estatus <> 0');
      //prod
      return LlavesModel.fromMapList(llaves);
      //test
      /* await Future.delayed(Duration(seconds: 2));
      return []; */
    } catch (e) {
      throw (e.toString());
    }
  }

  @override
  Future<LlavesModel> getLlave(int id) async {
    try {
      Database db = sl.get<DBCreator>().database;
      List<Map<String, dynamic>> llave = await db.query('llaves', where: 'id = ?', whereArgs: [id]);
      if (llave.isEmpty) {
        throw ('No se encontró la llave');
      }
      return LlavesModel.fromJson(llave.first);
    } catch (e) {
      throw (e.toString());
    }
  }

  @override
  Future<ApiResponse> createLlave(LlavesModel llave) async {
    try {
      Database db = sl.get<DBCreator>().database;
      var dbExecResult = await db.insert('llaves', llave.toJson());
      if (dbExecResult != 0) {
        return Success(true, 'Llave creada correctamente');
      }
      return Failure(false, 'No se pudo crear la llave. $dbExecResult');
    } catch (e) {
      return Failure(false, e.toString());
    }
  }

  @override
  Future<ApiResponse> updateLlave(LlavesModel llave) async {
    try {
      Database db = sl.get<DBCreator>().database;
      var dbExecResult = await db.update('llaves', llave.toJson(), where: 'id = ?', whereArgs: [llave.id]);
      if (dbExecResult != 0) {
        return Success(true, 'Llave actualizada correctamente');
      }
      return Failure(false, 'No se pudo actualizar la llave');
    } catch (e) {
      return Failure(false, e.toString());
    }
  }

  @override
  Future<ApiResponse> deleteLlave(LlavesModel llave) async {
    try {
      Database db = sl.get<DBCreator>().database;
      llave.estatus = 0; //cambiar el estatus a 0
      llave.fechaBaja = DateTime.now().toString(); //agregar la fecha de baja
      var dbExecResult = await db.update('llaves', llave.toJson(), where: 'id = ?', whereArgs: [llave.id]);
      if (dbExecResult == 1) {
        return Success(true, 'Llave eliminada correctamente');
      }
      return Failure(false, 'No se pudo eliminar la llave');
    } catch (e) {
      return Failure(false, e.toString());
    }
  }
}
