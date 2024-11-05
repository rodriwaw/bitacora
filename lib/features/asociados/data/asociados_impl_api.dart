import 'package:bitacora/core/utils/injections.dart';
import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/utils/api_response.dart';
import '../../../shared/data/database.dart';
import '../domain/asociados_model.dart';
import 'abstract_asociados_api.dart';

//aqui va la implementacion de la clase AsociadoImplApi
class AsociadosImplApi extends AbstractAsociadosApi {
  AsociadosImplApi();

  //override de la funcion getAllAsociados
  @override
  Future<List<AsociadosModel>> getAllAsociados() async {
    //obtener todos los asociados
    try {
      //aqui se obtienen los asociados de la base de datos
      Database db = sl.get<DBCreator>().database;
      List<Map<String, dynamic>> asociados = await db.query('asociados');
      //prod
      return AsociadosModel.fromMapList(asociados);
      //test
      /* await Future.delayed(Duration(seconds: 2));
      return []; */
    } catch (e) {
      throw Exception('Error al obtener los asociados');
    }
  }

  @override
  Future<AsociadosModel> getAsociado(int id) async {
    try {
      Database db = sl.get<DBCreator>().database;
      List<Map<String, dynamic>> asociado = await db.query('asociados', where: 'id = ?', whereArgs: [id]);
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
      throw Exception(e.toString());
    }
  }

  @override
  Future<ApiResponse> createAsociado(AsociadosModel asociado) async {
    try {
      Database db = sl.get<DBCreator>().database;
      await db.insert('asociados', asociado.toJson());
      return Success(true, 'Asociado creado correctamente');
    } catch (e) {
      return Failure(false, 'Error al crear el asociado');
    }
  }
}

/*   var db = await openDatabase(path, readOnly: true);
  print("Database is ready"); */
