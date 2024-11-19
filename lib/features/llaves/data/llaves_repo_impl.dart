import 'package:dartz/dartz.dart';

import '../../../core/utils/api_response.dart';
import '../domain/abstract_llaves_repo.dart';
import '../domain/llaves_model.dart';
import 'llaves_api_impl.dart';

class LlavesRepositoryImpl extends AbstractLlavesRepository {
  final LlavesApiImpl _llavesApi;

  LlavesRepositoryImpl(this._llavesApi);

  @override
  Future<Either<Failure, List<LlavesModel>>> getLlaves() async {
    try {
      final llaves = await _llavesApi.getAllLlaves();
      return Right(llaves);
    } catch (e) {
      return Left(Failure(false, e.toString()));
    }
  }

  @override
  Future<Either<Failure, LlavesModel>> getLlave(int id) async {
    try {
      final llave = await _llavesApi.getLlave(id);
      return Right(llave);
    } catch (e) {
      return Left(Failure(false, e.toString()));
    }
  }

  @override
  Future<Either<Failure, Success>> createLlave(LlavesModel llave) async {
    try {
      final response = await _llavesApi.createLlave(llave);
      if (response.status) {
        return Right(
          Success(
            response.status,
            response.message,
          ),
        );
      }
      throw Exception(response.message);
    } catch (e) {
      return Left(Failure(false, e.toString()));
    }
  }

  @override
  Future<Either<Failure, Success>> updateLlave(LlavesModel llave) async {
    try {
      final response = await _llavesApi.updateLlave(llave);
      if (response.status) {
        return Right(
          Success(
            response.status,
            response.message,
          ),
        );
      }
      throw Exception(response.message);
    } catch (e) {
      return Left(Failure(false, e.toString()));
    }
  }

  @override
  Future<Either<Failure, Success>> deleteLlave(LlavesModel llave) async {
    try {
      final response = await _llavesApi.deleteLlave(llave);
      if (response.status) {
        return Right(
          Success(
            response.status,
            response.message,
          ),
        );
      }
      throw Exception(response.message);
    } catch (e) {
      return Left(Failure(false, e.toString()));
    }
  }
}
