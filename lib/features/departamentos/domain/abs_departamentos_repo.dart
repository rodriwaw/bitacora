import 'package:bitacora/features/departamentos/domain/departamentos_model.dart';
import 'package:dartz/dartz.dart';
import '../../../core/utils/api_response.dart';

abstract class AbstractDepartamentosRepository {
  Future<Either<Failure, List<DepartamentosModel>>> getAllDepartamentos();
  Future<Either<Failure, Success>> createDepartamento(DepartamentosModel departamento);
}
