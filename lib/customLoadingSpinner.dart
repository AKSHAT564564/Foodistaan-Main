import 'dart:math';

import 'package:flutter/material.dart';
import 'package:foodistan/constants.dart';
import 'package:sizer/sizer.dart';

class CustomLoadingSpinner extends StatefulWidget {
  const CustomLoadingSpinner({Key? key}) : super(key: key);

  @override
  State<CustomLoadingSpinner> createState() => _CustomLoadingSpinnerState();
}

class _CustomLoadingSpinnerState extends State<CustomLoadingSpinner>
    with TickerProviderStateMixin {
  late AnimationController controller1;
  late Animation<double> animation1;

  late AnimationController controller2;
  late Animation<double> animation2;

  late AnimationController controller3;
  late Animation<double> animation3;

  late AnimationController controller4;
  late Animation<double> animation4;

  @override
  void initState() {
    controller1 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    animation1 = Tween<double>(begin: pi, end: -pi).animate(controller1)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller1.repeat();
        } else if (status == AnimationStatus.dismissed) {
          controller1.forward();
        }
      });

    controller2 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    animation2 = Tween<double>(begin: -pi, end: pi).animate(controller2)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller2.repeat();
        } else if (status == AnimationStatus.dismissed) {
          controller2.reverse();
        }
      });

    controller3 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    animation3 = Tween<double>(begin: pi, end: -pi).animate(controller3)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller3.repeat();
        } else if (status == AnimationStatus.dismissed) {
          controller3.forward();
        }
      });

    controller4 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    animation4 = Tween<double>(begin: -pi, end: pi).animate(controller4)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller4.repeat();
        } else if (status == AnimationStatus.dismissed) {
          controller4.forward();
        }
      });

    controller1.forward();
    controller2.forward();
    controller3.forward();
    controller4.forward();

    super.initState();
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 50,
      // width: 50,
      padding: EdgeInsets.all(0.5.h),
      child: Center(
          child: SizedBox(
        height: 7.h,
        width: 7.h,
        child: CustomPaint(
          painter: SpinnerPainter(
            animation1.value,
            animation2.value,
            animation3.value,
            animation4.value,
          ),
        ),
      )),
    );
  }
}

class SpinnerPainter extends CustomPainter {
  final double startAngle1;

  final double startAngle2;

  final double startAngle3;

  final double startAngle4;

  SpinnerPainter(
      this.startAngle1, this.startAngle2, this.startAngle3, this.startAngle4);

  @override
  void paint(Canvas canvas, Size size) {
    Paint customArc = Paint()
      ..color = kYellow
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromLTRB(
        size.width * 0.1,
        size.height * 0.1,
        size.width * 0.9,
        size.height * 0.9,
      ),
      startAngle1,
      2,
      false,
      customArc,
    );

    canvas.drawArc(
      Rect.fromLTRB(
        size.width * 0.2,
        size.height * 0.2,
        size.width * 0.8,
        size.height * 0.8,
      ),
      startAngle2,
      2,
      false,
      customArc,
    );

    canvas.drawArc(
      Rect.fromLTRB(
        size.width * 0.3,
        size.height * 0.3,
        size.width * 0.7,
        size.height * 0.7,
      ),
      startAngle3,
      2,
      false,
      customArc,
    );

    canvas.drawArc(
      Rect.fromLTRB(
        size.width * 0.4,
        size.height * 0.4,
        size.width * 0.6,
        size.height * 0.6,
      ),
      startAngle4,
      2,
      false,
      customArc,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
