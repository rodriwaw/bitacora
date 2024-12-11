import 'package:bitacora/features/exportar/data/exportar_api_impl.dart';
import 'package:bitacora/features/exportar/domain/abstract_exportar_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../core/utils/api_response.dart';

class ExportarRepositoryImpl extends AbstractExportarRepository{
  final ExportarApiImpl _exportarApi;

  ExportarRepositoryImpl(this._exportarApi);

  @override
  Future<Either<Failure, Success>> exportar() async {
    try {
      final exportado = await _exportarApi.exportar();
      if (exportado is Failure) {
        return Left(exportado);
      }else if (exportado is Success) {
        return Right(exportado);
      }
      return Left(Failure(false, 'Error desconocido'));
    } catch (e) {
      return Left(Failure(false, e.toString()));
    }
  }

  @override
  Future<Either<Failure, Success>> exportarYBorrar() async {
    try {
      final exportado = await _exportarApi.exportarYBorrar();
      if (exportado is Failure) {
        return Left(exportado);
      }else if (exportado is Success) {
        return Right(exportado);
      }
      return Left(Failure(false, 'Error desconocido'));
    } catch (e) {
      return Left(Failure(false, e.toString()));
    }
  }
}