import 'package:bitacora/core/utils/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../core/utils/api_response.dart';
import 'abstract_bitacora_repo.dart';
import 'bitacora_model.dart';

class GetBitacoraUseCase extends UseCase<List<BitacoraModel>, NoParams> {
  final AbstractBitacoraRepository repository;

  GetBitacoraUseCase(this.repository);

  @override
  Future<Either<Failure, List<BitacoraModel>>> call(NoParams params) async {
    final result = await repository.getBitacora();
    return result.fold((l) => Left(l), (r) async => Right(r));
  }
}

class CreateBitacoraUseCase extends UseCase<ApiResponse, BitacoraModel> {
  final AbstractBitacoraRepository repository;

  CreateBitacoraUseCase(this.repository);

  @override
  Future<Either<Failure, Success>> call(BitacoraModel params) async {
    final result = await repository.createBitacora(params);
    return result.fold((l) => Left(l), (r) async => Right(r));
  }
}

class DeleteBitacoraUseCase extends UseCase<ApiResponse, BitacoraModel> {
  final AbstractBitacoraRepository repository;

  DeleteBitacoraUseCase(this.repository);

  @override
  Future<Either<Failure, Success>> call(BitacoraModel params) async {
    final result = await repository.deleteBitacora(params);
    return result.fold((l) => Left(l), (r) async => Right(r));
  }
}
