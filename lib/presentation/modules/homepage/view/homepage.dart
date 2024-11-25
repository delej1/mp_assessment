import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpassessment/data/constants/colors.dart';
import 'package:mpassessment/presentation/animations/homepage_animations.dart';
import 'package:mpassessment/presentation/modules/homepage/view/components/card_section.dart';
import 'package:mpassessment/presentation/modules/homepage/view/components/greeting_section.dart';
import 'package:mpassessment/presentation/modules/homepage/view/components/image_list.dart';
import 'package:mpassessment/presentation/modules/homepage/view/components/top_bar.dart';

class Homepage extends StatefulWidget {
  final HomepageAnimations homepageAnimations;
  const Homepage({super.key, required this.homepageAnimations});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.white,
            AppColors.primaryA.withOpacity(0.9),
          ],
        )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                TopBar(
                  widthAnimation:
                      widget.homepageAnimations.locationRowWidthAnimation,
                  avatarFadeAnimation:
                      widget.homepageAnimations.avatarFadeAnimation,
                  textFadeAnimation:
                      widget.homepageAnimations.locationTextFadeAnimation,
                ),
                SizedBox(height: 20.h),
                GreetingSection(
                  greetingFadeAnimation:
                      widget.homepageAnimations.greetingFadeAnimation,
                  subtitleFadeAnimation:
                      widget.homepageAnimations.subtitleFadeAnimation,
                  greetingSlideAnimation:
                      widget.homepageAnimations.greetingSlideAnimation,
                  subtitleSlideAnimation:
                      widget.homepageAnimations.subtitleSlideAnimation,
                ),
                SizedBox(height: 20.h),
                CardSection(
                    fadeAnimation: widget.homepageAnimations.cardFadeAnimation),
                SizedBox(height: 20.h),
                ImageListSection(
                  fadeAnimation:
                      widget.homepageAnimations.imageListFadeAnimation,
                  imageSlideAnimation:
                      widget.homepageAnimations.imageListSlideAnimation,
                  sliderSlideAnimation:
                      widget.homepageAnimations.sliderSlideAnimation,
                  textAnimation:
                      widget.homepageAnimations.addressTextFadeAnimation,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
