import 'package:bitacora/core/utils/api_response.dart';
import 'package:dartz/dartz.dart';

import '../domain/asociados_model.dart';

//una clase abstracta que se encarga de obtener todos los asociados
abstract class AbstractAsociadosApi {
  // obtener todos los asociados
  Future<List<AsociadosModel>> getAllAsociados();
  Future<AsociadosModel> getAsociado(int id);
  Future<ApiResponse> createAsociado(AsociadosModel asociado);
}
