import 'package:bitacora/core/utils/api_response.dart';
import 'package:bitacora/features/departamentos/data/departamentos_api_impl.dart';
import 'package:bitacora/features/departamentos/domain/abs_departamentos_repo.dart';
import 'package:dartz/dartz.dart';

import '../domain/departamentos_model.dart';

class DepartamentosRepositoryImpl extends AbstractDepartamentosRepository {
  final DepartamentosApiImpl _departamentoApi;

  DepartamentosRepositoryImpl(this._departamentoApi);

  @override
  Future<Either<Failure, Success>> createDepartamento(DepartamentosModel departamento) async {
    try {
      final response = await _departamentoApi.createDepartamento(departamento);
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

  @override
  Future<Either<Failure, List<DepartamentosModel>>> getAllDepartamentos() async {
    try {
      final departamentos = await _departamentoApi.getAllDepartamentos();
      return Right(departamentos);
    } catch (e) {
      return Left(Failure(false, e.toString()));
    }
  }
}
