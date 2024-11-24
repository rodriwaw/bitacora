import 'package:dartz/dartz.dart';

import '../../../core/utils/api_response.dart';
import '../domain/abstract_bitacora_repo.dart';
import '../domain/bitacora_model.dart';
import 'bitacora_api_impl.dart';

class BitacoraRepositoryImpl extends AbstractBitacoraRepository {
  final BitacoraApiImpl _bitacoraApi;

  BitacoraRepositoryImpl(this._bitacoraApi);

  @override
  Future<Either<Failure, List<BitacoraModel>>> getBitacora() async {
    try {
      final bitacora = await _bitacoraApi.getAllBitacora();
      return Right(bitacora);
    } catch (e) {
      return Left(Failure(false, e.toString()));
    }
  }

  @override
  Future<Either<Failure, Success>> createBitacora(BitacoraModel bitacora) async {
    try {
      final response = await _bitacoraApi.createBitacora(bitacora);
      if (response.status) {
        return Right(
          Success(
            response.status,
            response.message,
          ),
        );
      }
      throw response.message;
    } catch (e) {
      return Left(Failure(false, e.toString()));
    }
  }


  @override
  Future<Either<Failure, Success>> deleteBitacora(BitacoraModel bitacora) async {
    try {
      final response = await _bitacoraApi.deleteBitacora(bitacora);
      if (response.status) {
        return Right(
          Success(
            response.status,
            response.message,
          ),
        );
      }
      throw response.message;
    } catch (e) {
      return Left(Failure(false, e.toString()));
    }
  }
}
