import 'package:bitacora/core/router_config.dart';
import 'package:bitacora/core/style_const.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainMenuPage extends StatelessWidget {
  const MainMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: StyleConst.kcolorCafe,
            titleTextStyle: const TextStyle(
              color: StyleConst.kcolorBlanco,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            toolbarHeight: 60,
            title: const Padding(
              padding: EdgeInsets.only(left: 22),
              child: Text('INICIO'),
            ),
            automaticallyImplyLeading: false,
          ),
          body: DecoratedBox(
            decoration: const BoxDecoration(
              color: StyleConst.kcolorBg,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      color: StyleConst.kcolorCard,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: SizedBox(
                        height: 200,
                        width: 200,
                        child: InkWell(
                          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                          onTap: () {
                            context.pushNamed(kAsociadosPageRoute);
                          },
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.people_alt_rounded,
                                size: 110,
                                color: StyleConst.kcolorCafe,
                              ),
                              Text(
                                'ASOCIADOS',
                                style: TextStyle(
                                  color: StyleConst.kcolorCafeOscuro,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 50),
                    Card(
                      color: StyleConst.kcolorCard,
                      child: SizedBox(
                        height: 200,
                        width: 200,
                        child: InkWell(
                          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                          onTap: () {
                            context.pushNamed(kLlavesPageRoute);
                          },
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.key_rounded,
                                size: 110,
                                color: StyleConst.kcolorCafe,
                              ),
                              Text(
                                'LLAVES',
                                style: TextStyle(
                                  color: StyleConst.kcolorCafeOscuro,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      color: StyleConst.kcolorCard,
                      child: SizedBox(
                        height: 200,
                        width: 200,
                        child: InkWell(
                          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                          onTap: () {
                            context.pushNamed(kBitacoraPageRoute);
                          },
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.book_rounded,
                                color: StyleConst.kcolorCafe,
                                size: 110,
                              ),
                              Text(
                                'BITÁCORA',
                                style: TextStyle(
                                  color: StyleConst.kcolorCafeOscuro,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 50),
                    Card(
                      color: StyleConst.kcolorCard,
                      child: SizedBox(
                        height: 200,
                        width: 200,
                        child: InkWell(
                          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                          onTap: () {
                            context.pushNamed(kExportarPageRoute);
                          },
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.file_download,
                                color: StyleConst.kcolorCafe,
                                size: 110,
                              ),
                              Text(
                                'EXPORTAR',
                                style: TextStyle(
                                  color: StyleConst.kcolorCafeOscuro,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
