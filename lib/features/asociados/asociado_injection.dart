import 'package:bitacora/features/asociados/data/asociados_impl_api.dart';
import 'package:bitacora/features/asociados/data/asociados_repository_impl.dart';
import 'package:bitacora/features/asociados/domain/abstract_asociados_repository.dart';
import 'package:bitacora/features/asociados/domain/asociados_usecase.dart';

import '../../core/utils/injections.dart';

initAsociadosInjections() {
  sl.registerSingleton<AsociadosImplApi>(AsociadosImplApi());
  sl.registerSingleton<AbstractAsociadosRepository>(AsociadosRepositoryImpl(sl()));
  sl.registerSingleton<GetAsociadosUseCase>(GetAsociadosUseCase(sl()));
  sl.registerSingleton<GetAsociadoUseCase>(GetAsociadoUseCase(sl()));
  sl.registerSingleton<CreateAsociadoUseCase>(CreateAsociadoUseCase(sl()));
}


//llamar con getIt.registerSingleton(ArticlesUseCase(sl()));
