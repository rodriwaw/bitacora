import 'package:bitacora/core/utils/api_response.dart';
import 'package:bitacora/features/bitacora/domain/bitacora_model.dart';

abstract class AbstractBitacoraApi {
  Future<List<BitacoraModel>> getAllBitacora();
  Future<ApiResponse> createBitacora(BitacoraModel bitacora);
  Future<ApiResponse> deleteBitacora(BitacoraModel bitacora);
}
