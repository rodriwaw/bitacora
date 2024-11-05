import 'package:bitacora/features/exportar/presentation/pages/exportar_page.dart';
import 'package:bitacora/features/main_menu/presentation/pages/main_menu_page.dart';
import 'package:go_router/go_router.dart';

import '../features/asociados/presentation/pages/asociados_page.dart';
import '../features/bitacora/presentation/pages/bitacora_page.dart';
import '../features/llaves/presentation/pages/llaves_page.dart';

final routerConfig = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    name: '/',
    path: '/',
    builder: (context, state) => const MainMenuPage(),
  ),
  GoRoute(
    name: kHomePageRoute,
    path: '/',
    builder: (context, state) => const MainMenuPage(),
  ),
  GoRoute(
    name: kAsociadosPageRoute,
    path: '/asociados',
    builder: (context, state) => const AsociadosPage(),
  ),
  GoRoute(
    name: kLlavesPageRoute,
    path: '/llaves',
    builder: (context, state) => const LlavesPage(),
  ),
  GoRoute(
    name: kBitacoraPageRoute,
    path: '/bitacora',
    builder: (context, state) => const BitacoraPage(),
  ),
  GoRoute(
    name: kExportarPageRoute,
    path: '/exportar',
    builder: (context, state) => const ExportarPage(),
  ),
]);

const kHomePageRoute = 'home';
const kAsociadosPageRoute = 'asociados';
const kLlavesPageRoute = 'llaves';
const kBitacoraPageRoute = 'bitacora';
const kExportarPageRoute = 'exportar';
