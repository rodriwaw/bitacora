

import 'package:bitacora/core/utils/injections.dart';
import 'package:bitacora/features/exportar/data/exportar_api_impl.dart';
import 'package:bitacora/features/exportar/domain/abstract_exportar_repo.dart';

import 'data/exportar_repo_impl.dart';
import 'domain/exportar_usecase.dart';

initExportarInjections(){
  sl.registerSingleton<ExportarApiImpl>(ExportarApiImpl());
  sl.registerSingleton<AbstractExportarRepository>(ExportarRepositoryImpl(sl()));
  //usecases
  sl.registerSingleton<ExportarUseCase>(ExportarUseCase(sl()));
  sl.registerSingleton<ExportarYBorrarUseCase>(ExportarYBorrarUseCase(sl()));
}