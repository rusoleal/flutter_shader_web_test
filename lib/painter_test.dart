
import 'dart:ui';

import 'package:flutter/material.dart';

class TestPainter extends StatefulWidget {

  Color color;

  TestPainter({super.key, required this.color});

  @override
  State<StatefulWidget> createState() {
    return TestPainterState();
  }

}

class TestPainterState extends State<TestPainter> {

  FragmentProgram? program;

  @override
  void initState() {
    super.initState();

    FragmentProgram.fromAsset('shaders/simple.frag').then((value) {
      program = value;
      setState(() {});
    },);
  }

  @override
  Widget build(BuildContext context) {

    if (program == null) {
      return Container();
    }

    return CustomPaint(
      painter: TestPainterPainter(program!, widget.color)
    );
  }

}

class TestPainterPainter extends CustomPainter {

  FragmentProgram program;
  Color color;

  TestPainterPainter(this.program, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint p = Paint();
    var shader = program.fragmentShader();
    shader.setFloat(0, color.red/255);
    shader.setFloat(1, color.green/255);
    shader.setFloat(2, color.blue/255);
    shader.setFloat(3, color.alpha/255);
    p.shader = shader;

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

}