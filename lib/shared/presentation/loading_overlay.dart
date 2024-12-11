import 'package:flutter/material.dart';
import '../../core/style_const.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key});

  @override
  Widget build(context) => Positioned(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        left: 0,
        top: 0,
        child: ClipRRect(
          child: Material(
            color: Colors.grey.withOpacity(0.5),
            child: FadeTransition(
              opacity: const AlwaysStoppedAnimation(1),
              child: Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    StyleConst.kcolorAzul,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
