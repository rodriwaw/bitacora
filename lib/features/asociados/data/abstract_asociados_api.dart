import '../../../core/utils/api_response.dart';
import '../domain/asociados_model.dart';

//una clase abstracta que se encarga de obtener todos los asociados
abstract class AbstractAsociadosApi {
  // obtener todos los asociados
  Future<List<AsociadosModel>> getAllAsociados();
  Future<List<AsociadosConLlaveModel>> getAllAsociadosConLlaveDisponible();
  Future<List<AsociadosConLlaveModel>> getAllAsociadosConLlavePrestada();
  Future<AsociadosModel> getAsociado(int id);
  Future<AsociadosConLlaveModel> getAsociadoByNum(String numAsociado);
  Future<ApiResponse> createAsociado(AsociadosModel asociado);
  Future<ApiResponse> updateAsociado(AsociadosModel asociado);
  Future<ApiResponse> deleteAsociado(AsociadosModel asociado);
}
