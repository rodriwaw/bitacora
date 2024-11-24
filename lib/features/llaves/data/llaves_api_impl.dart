import 'package:bitacora/core/utils/injections.dart';
import 'package:bitacora/features/llaves/data/abstract_llaves_api.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/utils/api_response.dart';
import '../../../shared/data/database.dart';
import '../../asociados/domain/asociados_model.dart';
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
    String successMessage = 'Llave actualizada correctamente';
    try {
      LlavesModel llaveActual = await getLlave(llave.id!);
      Database db = sl.get<DBCreator>().database;

      //validar que no se pueda actualizar una llave eliminada
      if (llaveActual.estatus == 0) {
        return Failure(false, 'No se puede actualizar una llave eliminada');
      }
      //validar que no se pueda actualizar una llave que está prestada
      else if (llaveActual.estatus == 3) {
        return Failure(false, 'No se puede actualizar una llave que está prestada, primero debe ser devuelta');
      }
      //si se esta cambiando el asociado de la llave
      if (llaveActual.idAsociado != llave.idAsociado) {
        List<Map<String, dynamic>> asociadosConLlaveDispRaw = await db.rawQuery(
            '''SELECT A.id, A.num_asociado, CONCAT(A.nombre,' ', A.apellido_paterno,' ', A.apellido_materno) AS nombre, 
          L.num_llave, L.id AS id_llave, D.nombre AS departamento
          FROM asociados as A
          INNER JOIN 
          llaves as L 
          ON A.id = L.asignada_a
          JOIN departamentos as D
          ON A.id_departamento = D.id
          WHERE A.estatus = 1 AND L.estatus = 2;''');
        //obtener todos los asociados con llaves disponibles
        List<AsociadosConLlaveModel> asociadosConLlaveDisp =
            AsociadosConLlaveModel.fromMapList(asociadosConLlaveDispRaw);
        List<Map<String, dynamic>> asociadosConLlavePresRaw = await db.rawQuery(
            '''SELECT A.id, A.num_asociado, CONCAT(A.nombre,' ', A.apellido_paterno,' ', A.apellido_materno) AS nombre, 
          L.num_llave, L.id AS id_llave, D.nombre AS departamento
          FROM asociados as A
          INNER JOIN 
          llaves as L 
          ON A.id = L.asignada_a
          JOIN departamentos as D
          ON A.id_departamento = D.id
          WHERE A.estatus = 1 AND L.estatus = 3;''');
        //obtener todos los asociados con llaves disponibles
        List<AsociadosConLlaveModel> asociadosConLlavePres =
            AsociadosConLlaveModel.fromMapList(asociadosConLlavePresRaw);
        //validar que el asociado al que se le quiere asignar la llave no tenga una llave asignada
        if (asociadosConLlaveDisp.any((e) => e.id == llave.idAsociado)) {
          // si tiene una llave asignada, quitarsela
          var dbExecResult = await db
              .rawUpdate('UPDATE llaves SET estatus = 1, asignada_a = NULL WHERE asignada_a = ?', [llave.idAsociado]);
          if (dbExecResult == 0) {
            return Failure(false, 'No se pudo quitar la llave al asociado');
          } else {
            //si se quitó la llave al asociado, se debe actualizar la llave
            successMessage = 'Llave actualizada correctamente, se quitó la llave anterior al asociado seleccionado';
          }
        } else if(asociadosConLlavePres.any((e) => e.id == llave.idAsociado)){
          return Failure(false, 'No se puede asignar la llave a este asociado, ya que tiene una llave prestada');
        }
      }

      var dbExecResult = await db.update('llaves', llave.toJson(), where: 'id = ?', whereArgs: [llave.id]);
      if (dbExecResult != 0) {
        return Success(true, successMessage);
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
      if (llave.estatus == 3) {
        return Failure(false, 'No se puede eliminar una llave que está prestada');
      }
      llave.estatus = 0; //cambiar el estatus a 0
      llave.fechaBaja = DateTime.now().toString(); //agregar la fecha de baja
      llave.idAsociado = null; //quitar la asignación de la llave
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
