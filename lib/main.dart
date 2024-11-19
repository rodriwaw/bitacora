import 'package:flutter/material.dart';
import 'core/router_config.dart';
import 'core/theme.dart';
import 'core/utils/injections.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  // ensure initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Inject all dependencies
  await initInjections();
  // Run the app
  runApp(const MainApp());
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
      locale: const Locale('es', 'MX'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es', 'MX'),
      ],
    );
  }
}
