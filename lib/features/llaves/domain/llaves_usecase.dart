import 'package:dartz/dartz.dart';

import '../../../core/utils/api_response.dart';
import '../../../core/utils/usecases/usecase.dart';
import 'abstract_llaves_repo.dart';
import 'llaves_model.dart';

class GetLlavesUseCase extends UseCase<List<LlavesModel>, NoParams> {
  final AbstractLlavesRepository repository;

  GetLlavesUseCase(this.repository);

  @override
  Future<Either<Failure, List<LlavesModel>>> call(NoParams params) async {
    final result = await repository.getLlaves();
    return result.fold((l) => Left(l), (r) async => Right(r));
  }
}

class GetLlaveUseCase extends UseCase<LlavesModel, int> {
  final AbstractLlavesRepository repository;

  GetLlaveUseCase(this.repository);

  @override
  Future<Either<Failure, LlavesModel>> call(int params) async {
    final result = await repository.getLlave(params);
    return result.fold((l) => Left(l), (r) async => Right(r));
  }
}

class CreateLlaveUseCase extends UseCase<ApiResponse, LlavesModel> {
  final AbstractLlavesRepository repository;

  CreateLlaveUseCase(this.repository);

  @override
  Future<Either<Failure, Success>> call(LlavesModel params) async {
    final result = await repository.createLlave(params);
    return result.fold((l) => Left(l), (r) async => Right(r));
  }
}

class UpdateLlaveUseCase extends UseCase<ApiResponse, LlavesModel> {
  final AbstractLlavesRepository repository;

  UpdateLlaveUseCase(this.repository);

  @override
  Future<Either<Failure, Success>> call(LlavesModel params) async {
    final result = await repository.updateLlave(params);
    return result.fold((l) => Left(l), (r) async => Right(r));
  }
}

class DeleteLlaveUseCase extends UseCase<ApiResponse, LlavesModel> {
  final AbstractLlavesRepository repository;

  DeleteLlaveUseCase(this.repository);

  @override
  Future<Either<Failure, Success>> call(LlavesModel params) async {
    final result = await repository.deleteLlave(params);
    return result.fold((l) => Left(l), (r) async => Right(r));
  }
}