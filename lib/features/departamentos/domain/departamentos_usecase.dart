import 'package:bitacora/core/utils/usecases/usecase.dart';
import 'package:bitacora/features/departamentos/domain/abs_departamentos_repo.dart';
import 'package:bitacora/features/departamentos/domain/departamentos_model.dart';
import 'package:dartz/dartz.dart';
import '../../../core/utils/api_response.dart';

class GetDepartamentosUseCase extends UseCase<List<DepartamentosModel>, NoParams>{
  final AbstractDepartamentosRepository repository;

  GetDepartamentosUseCase(this.repository);

  @override
  Future<Either<Failure, List<DepartamentosModel>>> call(NoParams params) async {
    final result = await repository.getAllDepartamentos();
    return result.fold((l) => Left(l), (r) async => Right(r));
  }
}

class CreateDepartamentoUseCase extends UseCase<ApiResponse, DepartamentosModel>{
  final AbstractDepartamentosRepository repository;

  CreateDepartamentoUseCase(this.repository);

  @override
  Future<Either<Failure, Success>> call(DepartamentosModel params) async {
    final result = await repository.createDepartamento(params);
    return result.fold((l) => Left(l), (r) async => Right(r));
  }
}