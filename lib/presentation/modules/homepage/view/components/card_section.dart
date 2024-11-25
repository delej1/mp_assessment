import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpassessment/data/constants/colors.dart';
import 'package:mpassessment/presentation/animations/count_animation.dart';

// Global flag to track if animation has already run
bool hasCardSectionAnimated = false;

class CardSection extends StatelessWidget {
  final Animation<double> fadeAnimation;

  const CardSection({super.key, required this.fadeAnimation});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: Row(
          children: [
            Expanded(
              child: Card(
                color: AppColors.primaryA,
                shape: CircleBorder(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 30.0.w, vertical: 30.0.h),
                  child: Column(
                    children: [
                      Text(
                        "BUY",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.white,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      _buildCountUpAnimation(1034, AppColors.white),
                      SizedBox(height: 8.h),
                      Text(
                        "offers",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  side: BorderSide(color: Colors.grey.shade300),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20.0.w, vertical: 20.0.h),
                  child: Column(
                    children: [
                      Text(
                        "RENT",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.primaryB,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      _buildCountUpAnimation(2212, AppColors.primaryB),
                      SizedBox(height: 8.h),
                      Text(
                        "offers",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.primaryB,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCountUpAnimation(int value, Color color) {
    if (!hasCardSectionAnimated) {
      // Run animation only if it hasn't been executed before
      return CountUpAnimation(value: value, color: color);
    }
    // Return static text once animation is complete
    return Text(
      value.toString(),
      style: TextStyle(
        fontSize: 32.sp,
        color: color,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
