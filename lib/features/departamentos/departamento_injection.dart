

import 'package:bitacora/core/utils/injections.dart';
import 'package:bitacora/features/departamentos/data/departamentos_repo_impl.dart';
import 'package:bitacora/features/departamentos/domain/abs_departamentos_repo.dart';

import 'data/departamentos_api_impl.dart';
import 'domain/departamentos_usecase.dart';

initDepartamentosInjections() {
  sl.registerSingleton<DepartamentosApiImpl>(DepartamentosApiImpl());
  sl.registerSingleton<AbstractDepartamentosRepository>(DepartamentosRepositoryImpl(sl()));
  sl.registerSingleton<GetDepartamentosUseCase>(GetDepartamentosUseCase(sl()));
  sl.registerSingleton<CreateDepartamentoUseCase>(CreateDepartamentoUseCase(sl()));
}