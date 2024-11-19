import '../../core/utils/injections.dart';
import 'data/asociados_api_impl.dart';
import 'data/asociados_repo_impl.dart';
import 'domain/abstract_asociados_repo.dart';
import 'domain/asociados_usecase.dart';

initAsociadosInjections() {
  sl.registerSingleton<AsociadosApiImpl>(AsociadosApiImpl());
  sl.registerSingleton<AbstractAsociadosRepository>(AsociadosRepositoryImpl(sl()));
  //usecases
  sl.registerSingleton<GetAsociadosUseCase>(GetAsociadosUseCase(sl()));
  sl.registerSingleton<GetAsociadosConLlaveDispUseCase>(GetAsociadosConLlaveDispUseCase(sl()));
  sl.registerSingleton<GetAsociadosConLlavePresUseCase>(GetAsociadosConLlavePresUseCase(sl()));
  sl.registerSingleton<GetAsociadoUseCase>(GetAsociadoUseCase(sl()));
  sl.registerSingleton<GetAsociadoByNumUseCase>(GetAsociadoByNumUseCase(sl()));
  sl.registerSingleton<CreateAsociadoUseCase>(CreateAsociadoUseCase(sl()));
  sl.registerSingleton<UpdateAsociadoUseCase>(UpdateAsociadoUseCase(sl()));
  sl.registerSingleton<DeleteAsociadoUseCase>(DeleteAsociadoUseCase(sl()));
}


//llamar con getIt.registerSingleton(ArticlesUseCase(sl()));
