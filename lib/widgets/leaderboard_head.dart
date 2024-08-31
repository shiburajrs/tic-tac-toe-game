import 'package:flutter/material.dart';

import '../utils/custom_painter.dart';
import '../utils/text_style_utils.dart';

class CustomShapeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 30,
      height: 40,
      child: Stack(
        children: [
          CustomPaint(
            painter: CustomShapePainter(),
            child: Container(),
          ),
          Center(
            child: Text(
              'Leaderboard',
              style: TextStyles.bold(fontSize: 22, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}