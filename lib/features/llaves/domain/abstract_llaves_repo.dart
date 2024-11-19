import 'package:dartz/dartz.dart';

import '../../../core/utils/api_response.dart';
import 'llaves_model.dart';

abstract class AbstractLlavesRepository {
  Future<Either<Failure, List<LlavesModel>>> getLlaves();
  Future<Either<Failure, LlavesModel>> getLlave(int id);
  Future<Either<Failure, Success>> createLlave(LlavesModel llave);
  Future<Either<Failure, Success>> updateLlave(LlavesModel llave);
  Future<Either<Failure, Success>> deleteLlave(LlavesModel llave);
}
