import 'package:dartz/dartz.dart';

import '../../../core/utils/api_response.dart';

abstract class AbstractExportarRepository {
  Future<Either<Failure, Success>> exportar();
  Future<Either<Failure, Success>> exportarYBorrar();
}
