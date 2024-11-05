import 'package:dartz/dartz.dart';

import '../api_response.dart';

abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}
//una clase que se le puede pasar a un UseCase para que no reciba parametros
class NoParams {}
