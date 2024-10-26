import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/router_config.dart';
import 'core/theme.dart';

void main() {
  // ensure initialized
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: themeData,
      title: 'Bitácora de Préstamos de Llaves',
      routerConfig: routerConfig,
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
    );
  }
}
