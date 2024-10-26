import 'package:bitacora/core/widgets/appbar.dart';
import 'package:flutter/material.dart';

import '../../../../core/style_const.dart';

class BitacoraPage extends StatefulWidget {
  const BitacoraPage({super.key});

  @override
  _BitacoraPageState createState() => _BitacoraPageState();
}

class _BitacoraPageState extends State<BitacoraPage> {
  @override
  Widget build(BuildContext context) => _BitacoraPageView(this);
}

class _BitacoraPageView extends StatelessWidget {
  final _BitacoraPageState state;

  const _BitacoraPageView(this.state);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(
          context: context,
          title: 'BITÁCORA',
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
                          //    context.pushNamed(kBitacoraPageRoute);
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
                              'Bitacora',
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
