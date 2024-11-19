import '../../../core/utils/api_response.dart';
import '../domain/departamentos_model.dart';

abstract class AbstractDepartamentosApi {
  Future<List<DepartamentosModel>> getAllDepartamentos();
  Future<ApiResponse> createDepartamento(DepartamentosModel departamento);
}