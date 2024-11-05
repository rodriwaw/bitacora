import 'package:bitacora/core/router_config.dart';
import 'package:bitacora/core/style_const.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({super.key});

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  late double _width;
  bool _isLandScape = false;

  late double _cardSideSize;
  late double _spacing;
  @override
  Widget build(BuildContext context) => _MainMenuPageView(this);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;
    _width = MediaQuery.of(context).size.width;
    _setSizes();
  }

  void _setSizes() {
    _spacing = _width * .025;
    if (_isLandScape) {
      _cardSideSize = _width * (1 / 5);
    } else {
      _cardSideSize = _width * (1 / 3);
    }
  }

  void _goToAsociados() {
    context.pushNamed(kAsociadosPageRoute);
  }

  void _goToLlaves() {
    context.pushNamed(kLlavesPageRoute);
  }

  void _goToBitacora() {
    context.pushNamed(kBitacoraPageRoute);
  }

  void _goToExportar() {
    context.pushNamed(kExportarPageRoute);
  }
}

class _MainMenuPageView extends StatelessWidget {
  final _MainMenuPageState state;
  const _MainMenuPageView(this.state);

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
              padding: EdgeInsets.only(left: 24),
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
                        height: state._cardSideSize,
                        width: state._cardSideSize,
                        child: InkWell(
                          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                          onTap: state._goToAsociados,
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
                    SizedBox(width: state._spacing),
                    Card(
                      color: StyleConst.kcolorCard,
                      child: SizedBox(
                        height: state._cardSideSize,
                        width: state._cardSideSize,
                        child: InkWell(
                          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                          onTap: state._goToLlaves,
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
                SizedBox(height: state._spacing),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      color: StyleConst.kcolorCard,
                      child: SizedBox(
                        height: state._cardSideSize,
                        width: state._cardSideSize,
                        child: InkWell(
                          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                          onTap: state._goToBitacora,
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
                    SizedBox(width: state._spacing),
                    Card(
                      color: StyleConst.kcolorCard,
                      child: SizedBox(
                        height: state._cardSideSize,
                        width: state._cardSideSize,
                        child: InkWell(
                          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                          onTap: state._goToExportar,
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
          ),),
    );
  }
}
