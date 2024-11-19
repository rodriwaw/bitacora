import 'package:bitacora/features/bitacora/data/bitacora_api_impl.dart';
import 'package:bitacora/features/bitacora/data/bitacora_repo_impl.dart';
import 'package:bitacora/features/bitacora/domain/abstract_bitacora_repo.dart';

import '../../core/utils/injections.dart';
import 'domain/bitacora_usecase.dart';

initBitacoraInjections() {
  sl.registerSingleton<BitacoraApiImpl>(BitacoraApiImpl());
  sl.registerSingleton<AbstractBitacoraRepository>(BitacoraRepositoryImpl(sl()));
  //usecases
  sl.registerSingleton<GetBitacoraUseCase>(GetBitacoraUseCase(sl()));
  sl.registerSingleton<CreateBitacoraUseCase>(CreateBitacoraUseCase(sl()));
  sl.registerSingleton<DeleteBitacoraUseCase>(DeleteBitacoraUseCase(sl()));
}
