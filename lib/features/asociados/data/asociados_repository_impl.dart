import 'package:bitacora/features/asociados/data/asociados_impl_api.dart';
import 'package:bitacora/features/asociados/domain/abstract_asociados_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../core/utils/api_response.dart';
import '../domain/asociados_model.dart';

//una clase que implementa la interfaz AbstractAsociadoRepository
class AsociadosRepositoryImpl extends AbstractAsociadosRepository {
  //se crea una instancia de la clase AsociadoImplApi
  final AsociadosImplApi _asociadoApi;

  AsociadosRepositoryImpl(this._asociadoApi);

  //cuerpo de la funcion, devuelve una lista de asociados o un objeto Failure
  //esto indica cómo se debe hacer
  @override
  Future<Either<Failure, List<AsociadosModel>>> getAsociados() async {
    try {
      final asociados = await _asociadoApi.getAllAsociados();
      return Right(asociados);
    } catch (e) {
      return Left(Failure(false, e.toString()));
    }
  }

  @override
  Future<Either<Failure, AsociadosModel>> getAsociado(int id) async {
    try {
      final asociado = await _asociadoApi.getAsociado(id);
      return Right(asociado);
    } catch (e) {
      return Left(Failure(false, e.toString()));
    }
  }

  @override
  Future<Either<Failure, Success>> createAsociado(AsociadosModel asociado) async {
    try {
      final response = await _asociadoApi.createAsociado(asociado);
      return Right(
        Success(
          response.status,
          response.message,
        ),
      );
    } catch (e) {
      return Left(Failure(false, e.toString()));
    }
  }
}
