import 'package:bitacora/features/asociados/domain/abstract_asociados_repository.dart';
import 'package:bitacora/features/asociados/domain/asociados_model.dart';
import 'package:dartz/dartz.dart';

import '../../../core/utils/api_response.dart';
import '../../../core/utils/usecases/usecase.dart';

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

class GetAsociadoUseCase extends UseCase<AsociadosModel, int> {
  final AbstractAsociadosRepository repository;

  GetAsociadoUseCase(this.repository);

  @override
  Future<Either<Failure, AsociadosModel>> call(int params) async {
    final result = await repository.getAsociado(params);
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
