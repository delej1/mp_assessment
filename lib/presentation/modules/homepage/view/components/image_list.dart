import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpassessment/data/constants/assets.dart';
import 'package:mpassessment/data/constants/colors.dart';

class ImageListSection extends StatelessWidget {
  final Animation<double> fadeAnimation;
  final Animation<Offset> imageSlideAnimation;
  final Animation<double> sliderSlideAnimation;
  final Animation<double> textAnimation;

  const ImageListSection({
    super.key,
    required this.fadeAnimation,
    required this.imageSlideAnimation,
    required this.sliderSlideAnimation,
    required this.textAnimation,
  });

  @override
  Widget build(BuildContext context) {
    // Example property data
    final List<Map<String, String>> properties = [
      {
        "image": Assets.interior1Img,
        "address": "Sunset Boulevard, 12",
      },
      {
        "image": Assets.interior2Img,
        "address": "Main Street, 10",
      },
      {
        "image": Assets.interior3Img,
        "address": "Park Lane, 34",
      },
      {
        "image": Assets.interior4Img,
        "address": "Gladkova St., 25",
      },
    ];

    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(
        position: imageSlideAnimation,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r),
              topRight: Radius.circular(10.r),
            ),
            color: AppColors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Full-width Image (Column -> 1 Image Stack)
              _buildFullWidthCard(properties[0]),
              SizedBox(height: 8.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildMediumCard(properties[1]),
                  Column(
                    children: [
                      _buildSmallCard(properties[2]),
                      SizedBox(
                        height: 8.h,
                      ),
                      _buildSmallCard(properties[3]),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFullWidthCard(Map<String, String> property) {
    return Stack(
      children: [
        // Full-width Image
        ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Image.asset(
            property["image"]!,
            height: 180.h,
            width: ScreenUtil().screenWidth * 0.95,
            fit: BoxFit.cover,
          ),
        ),

        // Slider Overlay
        Positioned(
          bottom: 0,
          child: AnimatedSlider(
            address: property["address"]!,
            slideAnimation: sliderSlideAnimation,
            textAnimation: textAnimation,
            maxWidth: ScreenUtil().screenWidth * 0.88,
          ),
        ),
      ],
    );
  }

  Widget _buildMediumCard(Map<String, String> property) {
    return Stack(
      children: [
        // Small Image
        ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Image.asset(
            property["image"]!,
            height: 240.h,
            width: ScreenUtil().screenWidth * 0.47,
            fit: BoxFit.cover,
          ),
        ),

        // Slider Overlay
        Positioned(
          bottom: 0,
          child: AnimatedSlider(
            address: property["address"]!,
            slideAnimation: sliderSlideAnimation,
            textAnimation: textAnimation,
            maxWidth: ScreenUtil().screenWidth * 0.40,
          ),
        ),
      ],
    );
  }

  Widget _buildSmallCard(Map<String, String> property) {
    return Stack(
      children: [
        // Small Image
        ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Image.asset(
            property["image"]!,
            height: 115.h,
            width: ScreenUtil().screenWidth * 0.47,
            fit: BoxFit.cover,
          ),
        ),

        // Slider Overlay
        Positioned(
          bottom: 0,
          child: AnimatedSlider(
            address: property["address"]!,
            slideAnimation: sliderSlideAnimation,
            textAnimation: textAnimation,
            maxWidth: ScreenUtil().screenWidth * 0.40,
          ),
        ),
      ],
    );
  }
}

class AnimatedSlider extends StatelessWidget {
  final String address;
  final double maxWidth;
  final Animation<double> slideAnimation;
  final Animation<double> textAnimation;

  const AnimatedSlider({
    super.key,
    required this.address,
    required this.maxWidth, // Explicitly passed max width
    required this.slideAnimation,
    required this.textAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: slideAnimation,
      builder: (context, child) {
        final currentWidth = maxWidth * slideAnimation.value;
        return Padding(
          padding: EdgeInsets.only(left: 10.0.w, right: 10.w, bottom: 10.w),
          child: Container(
            width: currentWidth > 50.w
                ? currentWidth
                : 50.w, // Use the explicitly passed width
            decoration: BoxDecoration(
              color: AppColors.color1.withOpacity(0.8),
              borderRadius: BorderRadius.circular(25.r),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Address Text
                  Flexible(
                    child: Align(
                      alignment: Alignment.center,
                      child: FadeTransition(
                        opacity: textAnimation,
                        child: Text(
                          address,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryC,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Arrow Button
                  Container(
                    width: 36.w,
                    height: 36.h,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.primaryC,
                      size: 10.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
