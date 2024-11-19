import 'package:dartz/dartz.dart';

import '../../../core/utils/api_response.dart';
import '../../../core/utils/usecases/usecase.dart';
import 'abstract_asociados_repo.dart';
import 'asociados_model.dart';

//todos los asociados, con  y sin llave asociada
class GetAsociadosUseCase extends UseCase<List<AsociadosModel>, NoParams> {
  final AbstractAsociadosRepository repository;

  GetAsociadosUseCase(this.repository);

  @override
  Future<Either<Failure, List<AsociadosModel>>> call(NoParams params) async {
    final result = await repository.getAsociados();
    //devuelve el resultado de la consulta
    //l es el error y r es el resultado
    return result.fold((l) => Left(l), (r) async => Right(r));
  }
}

//solo los asociados con llave asociada
class GetAsociadosConLlaveDispUseCase extends UseCase<List<AsociadosConLlaveModel>, NoParams> {
  final AbstractAsociadosRepository repository;

  GetAsociadosConLlaveDispUseCase(this.repository);

  @override
  Future<Either<Failure, List<AsociadosConLlaveModel>>> call(NoParams params) async {
    final result = await repository.getAllAsociadosConLlaveDisponible();
    //devuelve el resultado de la consulta
    //l es el error y r es el resultado
    return result.fold((l) => Left(l), (r) async => Right(r));
  }
}

class GetAsociadosConLlavePresUseCase extends UseCase<List<AsociadosConLlaveModel>, NoParams> {
  final AbstractAsociadosRepository repository;

  GetAsociadosConLlavePresUseCase(this.repository);

  @override
  Future<Either<Failure, List<AsociadosConLlaveModel>>> call(NoParams params) async {
    final result = await repository.getAllAsociadosConLlavePrestada();
    //devuelve el resultado de la consulta
    //l es el error y r es el resultado
    return result.fold((l) => Left(l), (r) async => Right(r));
  }
}

class GetAsociadoUseCase extends UseCase<AsociadosModel, int> {
  final AbstractAsociadosRepository repository;

  GetAsociadoUseCase(this.repository);

  @override
  Future<Either<Failure, AsociadosModel>> call(int params) async {
    final result = await repository.getAsociado(params);
    return result.fold((l) => Left(l), (r) async => Right(r));
  }
}

class GetAsociadoByNumUseCase extends UseCase<AsociadosConLlaveModel, String> {
  final AbstractAsociadosRepository repository;

  GetAsociadoByNumUseCase(this.repository);

  @override
  Future<Either<Failure, AsociadosConLlaveModel>> call(String params) async {
    final result = await repository.getAsociadoByNum(params);
    return result.fold((l) => Left(l), (r) async => Right(r));
  }
}

class CreateAsociadoUseCase extends UseCase<ApiResponse, AsociadosModel> {
  final AbstractAsociadosRepository repository;

  CreateAsociadoUseCase(this.repository);

  @override
  Future<Either<Failure, Success>> call(AsociadosModel params) async {
    final result = await repository.createAsociado(params);
    return result.fold((l) => Left(l), (r) async => Right(r));
  }
}

class UpdateAsociadoUseCase extends UseCase<ApiResponse, AsociadosModel> {
  final AbstractAsociadosRepository repository;

  UpdateAsociadoUseCase(this.repository);

  @override
  Future<Either<Failure, Success>> call(AsociadosModel params) async {
    final result = await repository.updateAsociado(params);
    return result.fold((l) => Left(l), (r) async => Right(r));
  }
}

class DeleteAsociadoUseCase extends UseCase<ApiResponse, AsociadosModel> {
  final AbstractAsociadosRepository repository;

  DeleteAsociadoUseCase(this.repository);

  @override
  Future<Either<Failure, Success>> call(AsociadosModel params) async {
    final result = await repository.deleteAsociado(params);
    return result.fold((l) => Left(l), (r) async => Right(r));
  }
}
