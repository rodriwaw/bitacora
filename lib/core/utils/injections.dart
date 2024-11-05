
import 'package:get_it/get_it.dart';

import '../../features/asociados/asociado_injection.dart';
import '../../shared/app_injections.dart';

final sl = GetIt.instance;

Future<void> initInjections()async{
  await initAppInjections();
  await initAsociadosInjections();
}