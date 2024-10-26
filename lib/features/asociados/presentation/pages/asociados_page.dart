import 'package:bitacora/core/widgets/appbar.dart';
import 'package:flutter/material.dart';

import '../../../../core/style_const.dart';

class AsociadosPage extends StatefulWidget {
  const AsociadosPage({super.key});

  @override
  _AsociadosPageState createState() => _AsociadosPageState();
}

class _AsociadosPageState extends State<AsociadosPage> {
  @override
  Widget build(BuildContext context) => _AsociadosPageView(this);
}

class _AsociadosPageView extends StatelessWidget {
  final _AsociadosPageState state;

  const _AsociadosPageView(this.state);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(
          context: context,
          title: 'ASOCIADOS',
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
                          //    context.pushNamed(kAsociadosPageRoute);
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
