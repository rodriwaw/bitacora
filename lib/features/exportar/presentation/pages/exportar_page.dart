import 'package:bitacora/shared/presentation/appbar.dart';
import 'package:flutter/material.dart';

import '../../../../core/style_const.dart';

class ExportarPage extends StatefulWidget {
  const ExportarPage({super.key});

  @override
  ExportarPageState createState() => ExportarPageState();
}

class ExportarPageState extends State<ExportarPage> {
  @override
  Widget build(BuildContext context) => _ExportarPageView(this);
}

class _ExportarPageView extends StatelessWidget {
  final ExportarPageState state;

  const _ExportarPageView(this.state);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(
          context: context,
          title: 'EXPORTAR DATOS',
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
                          //    context.pushNamed(kExportarPageRoute);
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
                              'Exportar',
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
        ),
      ),
    );
  }
}
