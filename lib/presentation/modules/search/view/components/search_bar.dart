import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpassessment/data/constants/assets.dart';
import 'package:mpassessment/data/constants/colors.dart';

class CustomSearchBar extends StatelessWidget {
  final Animation<double> animation;
  const CustomSearchBar({super.key, required this.animation});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: SizedBox(
              width: ScreenUtil().screenWidth * 0.6,
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.white,
                  prefixIcon: Icon(Icons.search),
                  hintText: "Saint Petersburg",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0.r),
                    borderSide: BorderSide.none,
                  ),
                ),
                readOnly: true,
              ),
            ),
          ),
          SizedBox(width: 8.0.w),
          ScaleTransition(
            scale: animation,
            child: Container(
              padding: EdgeInsets.all(8.0.w),
              width: ScreenUtil().screenWidth * 0.12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
              ),
              child: Image.asset(Assets.filterIc),
            ),
          )
        ],
      ),
    );
  }
}
