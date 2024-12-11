import 'package:bitacora/core/utils/api_response.dart';
import 'package:bitacora/core/utils/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import 'abstract_exportar_repo.dart';

class ExportarUseCase extends UseCase<ApiResponse, NoParams> {
  final AbstractExportarRepository repository;

  ExportarUseCase(this.repository);

  @override
  Future<Either<Failure, Success>> call(NoParams params) async {
    final result = await repository.exportar();
    return result.fold((l) => Left(l), (r) async => Right(r));
  }
}

class ExportarYBorrarUseCase extends UseCase<ApiResponse, NoParams> {
  final AbstractExportarRepository repository;

  ExportarYBorrarUseCase(this.repository);

  @override
  Future<Either<Failure, Success>> call(NoParams params) async {
    final result = await repository.exportarYBorrar();
    return result.fold((l) => Left(l), (r) async => Right(r));
  }
}
