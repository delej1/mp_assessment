import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountUpAnimation extends StatelessWidget {
  final int value;
  final Color color;
  const CountUpAnimation({super.key, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<int>(
      tween: IntTween(begin: 0, end: value),
      duration: Duration(seconds: 4),
      builder: (context, val, _) {
        return Text(
          val.toString(),
          style: TextStyle(
              fontSize: 32.sp, color: color, fontWeight: FontWeight.bold),
        );
      },
    );
  }
}
