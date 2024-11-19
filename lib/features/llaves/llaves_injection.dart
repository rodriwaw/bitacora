import '../../core/utils/injections.dart';
import 'data/llaves_api_impl.dart';
import 'data/llaves_repo_impl.dart';
import 'domain/abstract_llaves_repo.dart';
import 'domain/llaves_usecase.dart';

initLlavesInjections() {
  sl.registerSingleton<LlavesApiImpl>(LlavesApiImpl());
  sl.registerSingleton<AbstractLlavesRepository>(LlavesRepositoryImpl(sl()));
  //usecases
  sl.registerSingleton<GetLlavesUseCase>(GetLlavesUseCase(sl()));
  sl.registerSingleton<GetLlaveUseCase>(GetLlaveUseCase(sl()));
  sl.registerSingleton<CreateLlaveUseCase>(CreateLlaveUseCase(sl()));
  sl.registerSingleton<UpdateLlaveUseCase>(UpdateLlaveUseCase(sl()));
  sl.registerSingleton<DeleteLlaveUseCase>(DeleteLlaveUseCase(sl()));
}
