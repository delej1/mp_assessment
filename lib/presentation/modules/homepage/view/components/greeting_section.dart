import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GreetingSection extends StatelessWidget {
  final Animation<double> greetingFadeAnimation;
  final Animation<double> subtitleFadeAnimation;
  final Animation<Offset> greetingSlideAnimation;
  final Animation<Offset> subtitleSlideAnimation;

  const GreetingSection({
    super.key,
    required this.greetingFadeAnimation,
    required this.subtitleFadeAnimation,
    required this.greetingSlideAnimation,
    required this.subtitleSlideAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // First Text: "Hi, Marina"
          SlideTransition(
            position: greetingSlideAnimation,
            child: FadeTransition(
              opacity: greetingFadeAnimation,
              child: Text(
                "Hi, Bamidele",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400),
              ),
            ),
          ),
          SizedBox(height: 8.h),

          // Second Text: "let's select your perfect place"
          SlideTransition(
            position: subtitleSlideAnimation,
            child: FadeTransition(
              opacity: subtitleFadeAnimation,
              child: Text(
                "let's select your\nperfect place",
                style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
