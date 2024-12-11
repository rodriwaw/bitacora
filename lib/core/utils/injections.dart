
import 'package:bitacora/features/bitacora/bitacora_injection.dart';
import 'package:bitacora/features/llaves/llaves_injection.dart';
import 'package:get_it/get_it.dart';

import '../../features/asociados/asociado_injection.dart';
import '../../features/departamentos/departamento_injection.dart';
import '../../features/exportar/exportar_injection.dart';
import '../../shared/app_injections.dart';

final sl = GetIt.instance;

Future<void> initInjections()async{
  await initAppInjections();
  await initAsociadosInjections();
  await initDepartamentosInjections();
  await initLlavesInjections();
  await initBitacoraInjections();
  await initExportarInjections();
}