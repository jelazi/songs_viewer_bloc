import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyProgressIndicator extends StatefulWidget {
  double? usableTime;
  Duration? duration;
  Color color;
  Color backgroundColor;
  bool isRepeat = true;
  Function? afterFinished;
  Stream<bool>? isClose;

  MyProgressIndicator({
    super.key,
    this.usableTime,
    this.duration,
    this.isRepeat = true,
    this.afterFinished,
    this.isClose,
    required this.color,
    required this.backgroundColor,
  });

  @override
  State<MyProgressIndicator> createState() => _MyProgressIndicatorState();
}

class _MyProgressIndicatorState extends State<MyProgressIndicator> with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: widget.duration ?? const Duration(seconds: 10),
    )..addListener(() {
        setState(() {});
      });
    controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        if (widget.afterFinished != null) {
          widget.afterFinished!();
        }
      }
    });
    if (widget.usableTime != null) {
      controller.value = widget.usableTime!;
    }
    if (widget.isClose != null) {
      widget.isClose!.listen((event) {
        controller.stop();
      });
    }
    if (widget.isRepeat) {
      controller.repeat(reverse: false);
    } else {
      controller.forward();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: controller.value,
      color: widget.color,
      backgroundColor: widget.backgroundColor,
    );
  }
}
