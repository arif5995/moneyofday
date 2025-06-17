import 'dart:math' as math;

import 'package:flutter/material.dart';

const double buttonSize = 50;

class CircularFab2Widget extends StatefulWidget {
  const CircularFab2Widget({super.key});

  @override
  State<CircularFab2Widget> createState() => _CircularFab2WidgetState();
}

class _CircularFab2WidgetState extends State<CircularFab2Widget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Flow(
    delegate: FlowMenuDelegate(controller: animationController),
    children: <IconData>[
      Icons.ac_unit,
      Icons.add_chart_sharp,
      Icons.access_alarm_outlined,
      Icons.add,
    ].map<Widget>(buildFab).toList(),
  );

  Widget buildFab(IconData icon) => SizedBox(
    width: buttonSize,
    height: buttonSize,
    child: FloatingActionButton(
      heroTag: UniqueKey(),
      elevation: 0,
      splashColor: Colors.black,
      child: Icon(
        icon,
        size: 24,
        color: Colors.white,
      ),
      onPressed: () {
        if (animationController.status == AnimationStatus.completed) {
          animationController.reverse();
        } else {
          animationController.forward();
        }
      },
    ),
  );
}

class FlowMenuDelegate extends FlowDelegate {
  final Animation<double> controller;

  FlowMenuDelegate({required this.controller}) : super(repaint: controller);

  @override
  void paintChildren(FlowPaintingContext context) {
    final size = context.size;
    const xStart = 250 - buttonSize;
    final yStart = (size.height - 50) - buttonSize;
    final n = context.childCount;
    for (int i = 0; i < n; i++) {
      final lastItem = i == context.childCount - 1;
      setValue(value) => lastItem ? 0.0 : value;
      final radius = 80 * controller.value;
      final theta1 = (i + 0.5)  * math.pi / (n - 1);
      // final theta2 = i * (math.pi) / (n - 2);
      final x = xStart - setValue(radius * math.cos(theta1));
      final y = yStart - setValue(radius * math.sin(theta1));

      context.paintChild(i,
          transform: Matrix4.identity()
            ..translate(x, y, 0)
            ..translate(buttonSize / 2, buttonSize / 2)
            ..rotateZ(180 * (1 - controller.value) * math.pi / 180)
            ..scale(lastItem ? 1.0 : math.max(controller.value, 0.5))
            ..translate(-buttonSize / 2, -buttonSize / 2));
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}
