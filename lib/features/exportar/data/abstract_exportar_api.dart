import '../../../core/utils/api_response.dart';

abstract class AbstractExportarApi {
  Future<ApiResponse> exportar();
  Future<ApiResponse> exportarYBorrar();
}
