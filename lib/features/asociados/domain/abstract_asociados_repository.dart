import 'package:bitacora/features/asociados/domain/asociados_model.dart';
import 'package:dartz/dartz.dart';

import '../../../core/utils/api_response.dart';

//una clase abstracta que se encarga de obtener todos los asociados
//devuelve una lista de asociados o un objeto Failure
//esto solo indica qué se debe hacer, no cómo se debe hacer
abstract class AbstractAsociadosRepository {
  Future<Either<Failure, List<AsociadosModel>>> getAsociados();
  Future<Either<Failure, AsociadosModel>> getAsociado(int id);
  Future<Either<Failure, Success>> createAsociado(AsociadosModel asociado);
}
