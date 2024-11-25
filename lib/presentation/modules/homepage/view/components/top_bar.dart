import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpassessment/data/constants/assets.dart';
import 'package:mpassessment/data/constants/colors.dart';

class TopBar extends StatelessWidget {
  final Animation<double> widthAnimation;
  final Animation<double> avatarFadeAnimation;
  final Animation<double> textFadeAnimation;

  const TopBar({
    super.key,
    required this.widthAnimation,
    required this.avatarFadeAnimation,
    required this.textFadeAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AnimatedBuilder(
            animation: widthAnimation,
            builder: (context, child) {
              return ClipRect(
                child: Align(
                  widthFactor: widthAnimation.value,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: AppColors.white.withOpacity(0.5),
                    ),
                    child: FadeTransition(
                      opacity: textFadeAnimation,
                      child: Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.grey),
                          SizedBox(width: 8.0.w),
                          Text(
                            "Saint Petersburg",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 16.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          FadeTransition(
            opacity: avatarFadeAnimation,
            child: CircleAvatar(
              backgroundColor: AppColors.primaryA,
              backgroundImage: AssetImage(Assets.profileImg),
              radius: 20.r,
            ),
          ),
        ],
      ),
    );
  }
}
