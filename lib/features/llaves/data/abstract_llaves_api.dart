import '../../../core/utils/api_response.dart';
import '../domain/llaves_model.dart';

abstract class AbstractLlavesApi {
  Future<List<LlavesModel>> getAllLlaves();
  Future<LlavesModel> getLlave(int id);
  Future<ApiResponse> createLlave(LlavesModel llave);
  Future<ApiResponse> updateLlave(LlavesModel llave);
  Future<ApiResponse> deleteLlave(LlavesModel llave);
}
