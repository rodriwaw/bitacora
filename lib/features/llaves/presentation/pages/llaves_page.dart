import 'package:bitacora/core/widgets/appbar.dart';
import 'package:flutter/material.dart';

import '../../../../core/style_const.dart';

class LlavesPage extends StatefulWidget {
  const LlavesPage({super.key});

  @override
  _LlavesPageState createState() => _LlavesPageState();
}

class _LlavesPageState extends State<LlavesPage> {
  @override
  Widget build(BuildContext context) => _LlavesPageView(this);
}

class _LlavesPageView extends StatelessWidget {
  final _LlavesPageState state;

  const _LlavesPageView(this.state);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(
          context: context,
          title: 'LLAVES',
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
                          //    context.pushNamed(kLlavesPageRoute);
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
