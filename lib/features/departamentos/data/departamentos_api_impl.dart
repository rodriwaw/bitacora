import 'package:bitacora/core/utils/api_response.dart';
import 'package:bitacora/features/departamentos/data/abstract_departamentos_api.dart';
import 'package:bitacora/features/departamentos/domain/departamentos_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/utils/injections.dart';
import '../../../shared/data/database.dart';

class DepartamentosApiImpl extends AbstractDepartamentosApi {
  DepartamentosApiImpl();
  @override
  Future<ApiResponse> createDepartamento(DepartamentosModel departamento) async {
    try {
      Database db = sl.get<DBCreator>().database;
      await db.insert('departamentos', departamento.toJson());
      return Success(true, 'Departamento creado correctamente');
    } catch (e) {
      return Failure(false, e.toString());
    }
  }

  @override
  Future<List<DepartamentosModel>> getAllDepartamentos() async {
    try {
      //aqui se obtienen los departamentos de la base de datos
      Database db = sl.get<DBCreator>().database;
      List<Map<String, dynamic>> departamentos = await db.query('departamentos');
      //prod
      return DepartamentosModel.fromMapList(departamentos);
      //test
      /* await Future.delayed(Duration(seconds: 2));
      return []; */
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
