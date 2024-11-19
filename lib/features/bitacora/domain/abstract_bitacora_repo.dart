import 'package:dartz/dartz.dart';

import '../../../core/utils/api_response.dart';
import 'bitacora_model.dart';

abstract class AbstractBitacoraRepository {
  Future<Either<Failure, List<BitacoraModel>>> getBitacora();
  Future<Either<Failure, Success>> createBitacora(BitacoraModel bitacora);
  Future<Either<Failure, Success>> deleteBitacora(BitacoraModel bitacora);
}