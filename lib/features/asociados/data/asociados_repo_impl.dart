import 'package:dartz/dartz.dart';

import '../../../core/utils/api_response.dart';
import '../domain/abstract_asociados_repo.dart';
import '../domain/asociados_model.dart';
import 'asociados_api_impl.dart';

//una clase que implementa la interfaz AbstractAsociadoRepository
class AsociadosRepositoryImpl extends AbstractAsociadosRepository {
  //se crea una instancia de la clase AsociadoImplApi
  final AsociadosApiImpl _asociadoApi;

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
  Future<Either<Failure, List<AsociadosConLlaveModel>>> getAllAsociadosConLlaveDisponible() async {
    try {
      final asociados = await _asociadoApi.getAllAsociadosConLlaveDisponible();
      return Right(asociados);
    } catch (e) {
      return Left(Failure(false, e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AsociadosConLlaveModel>>> getAllAsociadosConLlavePrestada() async {
    try {
      final asociados = await _asociadoApi.getAllAsociadosConLlavePrestada();
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
  Future<Either<Failure, AsociadosConLlaveModel>> getAsociadoByNum(String numAsociado) async {
    try {
      final asociado = await _asociadoApi.getAsociadoByNum(numAsociado);
      return Right(asociado);
    } catch (e) {
      return Left(Failure(false, e.toString()));
    }
  }

  @override
  Future<Either<Failure, Success>> createAsociado(AsociadosModel asociado) async {
    try {
      final response = await _asociadoApi.createAsociado(asociado);
      if (response.status) {
        return Right(
          Success(
            response.status,
            response.message,
          ),
        );
      }
      throw Exception(response.message);
    } catch (e) {
      return Left(Failure(false, e.toString()));
    }
  }

  @override
  Future<Either<Failure, Success>> updateAsociado(AsociadosModel asociado) async {
    try {
      final response = await _asociadoApi.updateAsociado(asociado);
      if (response.status) {
        return Right(
          Success(
            response.status,
            response.message,
          ),
        );
      }
      throw Exception(response.message);
    } catch (e) {
      return Left(Failure(false, e.toString()));
    }
  }

  @override
  Future<Either<Failure, Success>> deleteAsociado(AsociadosModel asociado) async {
    try {
      //cambia el estatus del asociado a 0
      final response = await _asociadoApi.deleteAsociado(asociado);
      if (response.status) {
        return Right(
          Success(
            response.status,
            response.message,
          ),
        );
      }
      throw Exception(response.message);
    } catch (e) {
      return Left(Failure(false, e.toString()));
    }
  }
}
