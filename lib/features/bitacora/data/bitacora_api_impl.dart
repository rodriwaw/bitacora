import 'package:sqflite/sqflite.dart';

import '../../../core/utils/api_response.dart';
import '../../../core/utils/injections.dart';
import '../../../shared/data/database.dart';
import '../domain/bitacora_model.dart';
import 'abstract_bitacora_api.dart';

class BitacoraApiImpl extends AbstractBitacoraApi {
  BitacoraApiImpl();

  @override
  Future<List<BitacoraModel>> getAllBitacora() async {
    try {
      Database db = sl.get<DBCreator>().database;
      List<Map<String, dynamic>> bitacora = await db.rawQuery(
          '''SELECT B.*, CONCAT(A.nombre, ' ', A.apellido_paterno, ' ', A.apellido_materno) AS asociado, L.num_llave
        FROM bitacora AS B
        LEFT JOIN asociados AS A
        ON B.id_asociado = A.id
        LEFT JOIN llaves AS L
        ON B.id_llave = L.id
        WHERE B.estatus = 1
        ORDER BY B.fecha DESC
        ''');
      //prod
      return BitacoraModel.fromMapList(bitacora);
      //test
      /* await Future.delayed(Duration(seconds: 2));
      return []; */
    } catch (e) {
      throw (e.toString());
    }
  }

  @override
  Future<ApiResponse> createBitacora(BitacoraModel bitacora) async {
    try {
      Database db = sl.get<DBCreator>().database;
      if (bitacora.movimiento.toLowerCase() == 'salida') {
        var llave = await db.query('llaves', where: 'id = ?', whereArgs: [bitacora.idLlave]);
        if (llave.isEmpty) {
          return Failure(false, 'No se encontró la llave con el id proporcionado');
        }
        if (llave.first['asignada_a'] != bitacora.idAsociado) {
          return Failure(false, 'La llave no está asignada al asociado');
        }
        if (llave.first['estatus'] == 0) {
          return Failure(false, 'La llave se encuentra inactiva');
        }
        if (llave.first['estatus'] == 3) {
          return Failure(false, 'La llave se encuentra en préstamo');
        }
        var dbExecResult = await db.update('llaves', {'estatus': 3}, where: 'id = ?', whereArgs: [bitacora.idLlave]);
        if (dbExecResult == 0) {
          return Failure(false, 'No se pudo actualizar el estatus de la llave');
        }
      }else if (bitacora.movimiento.toLowerCase() == 'entrada') {
        var llave = await db.query('llaves', where: 'id = ?', whereArgs: [bitacora.idLlave]);
        if (llave.isEmpty) {
          return Failure(false, 'No se encontró la llave con el id proporcionado');
        }
        if (llave.first['asignada_a'] != bitacora.idAsociado) {
          return Failure(false, 'La llave no está asignada al asociado');
        }
        if (llave.first['estatus'] == 0) {
          return Failure(false, 'La llave se encuentra inactiva');
        }
        if (llave.first['estatus'] == 2) {
          return Failure(false, 'La llave se encuentra no ha sido prestada');
        }
        var dbExecResult = await db.update('llaves', {'estatus': 2}, where: 'id = ?', whereArgs: [bitacora.idLlave]);
        if (dbExecResult == 0) {
          return Failure(false, 'No se pudo actualizar el estatus de la llave');
        }
      }
      var dbExecResult = await db.insert('bitacora', bitacora.toJson());

      if (dbExecResult != 0) {
        return Success(true, 'Registro de bitácora creado correctamente');
      }
      return Failure(false, 'No se pudo crear el registro en la bitacora. $dbExecResult');
    } catch (e) {
      return Failure(false, e.toString());
    }
  }

  @override
  Future<ApiResponse> deleteBitacora(BitacoraModel bitacora) async {
    try {
      Database db = sl.get<DBCreator>().database;
      var dbExecResult = await db.delete('bitacora', where: 'id = ?', whereArgs: [bitacora.id]);
      if (dbExecResult != 0) {
        return Success(true, 'Registro de bitácora eliminado correctamente');
      }
      return Failure(false, 'No se pudo eliminar el registro de la bitacora. $dbExecResult');
    } catch (e) {
      return Failure(false, e.toString());
    }
  }
}
