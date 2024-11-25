import 'package:flutter/animation.dart';

class HomepageAnimations {
  final AnimationController topBarController;
  final AnimationController greetingController;
  final AnimationController cardController;
  final AnimationController carouselController;
  final AnimationController sliderController;
  final AnimationController bottomNavController;

  late Animation<double> locationRowWidthAnimation;
  late Animation<double> avatarFadeAnimation;
  late Animation<double> locationTextFadeAnimation;

  late Animation<double> greetingFadeAnimation;
  late Animation<double> subtitleFadeAnimation;
  late Animation<Offset> greetingSlideAnimation;
  late Animation<Offset> subtitleSlideAnimation;

  late Animation<double> cardFadeAnimation;

  late Animation<double> imageListFadeAnimation;
  late Animation<Offset> imageListSlideAnimation;

  late Animation<double> sliderSlideAnimation;
  late Animation<double> addressTextFadeAnimation;

  late Animation<double> bottomNavFadeAnimation;
  late Animation<Offset> bottomNavSlideAnimation;

  HomepageAnimations({
    required this.topBarController,
    required this.greetingController,
    required this.cardController,
    required this.carouselController,
    required this.sliderController,
    required this.bottomNavController,
  }) {
    // Location Row Width Animation
    locationRowWidthAnimation = Tween<double>(
      begin: 0.0, // Start with 0 width
      end: 1.0, // Fully expanded width (normalized)
    ).animate(CurvedAnimation(
      parent: topBarController,
      curve: Curves.easeInOut,
    ));

    // Avatar Fade Animation (no sliding, just appear)
    avatarFadeAnimation = Tween<double>(
      begin: 0.0, // Completely transparent
      end: 1.0, // Fully visible
    ).animate(CurvedAnimation(
      parent: topBarController,
      curve: Curves.easeIn,
    ));

    locationTextFadeAnimation = Tween<double>(
      begin: 0.0, // Fully transparent
      end: 1.0, // Fully visible
    ).animate(CurvedAnimation(
      parent: topBarController,
      curve: Interval(
        0.9, // Delay the start until way through the parent animation
        1.0, // Complete at the end of the parent animation
        curve: Curves.easeOut, // Smooth fade-in
      ),
    ));

    //Define animations for each child in greetings section with staggered delays
    greetingSlideAnimation = Tween<Offset>(
      begin: Offset(0.0, 0.5), // Start slightly below
      end: Offset.zero, // End at normal position
    ).animate(CurvedAnimation(
      parent: greetingController,
      curve: Interval(0.0, 0.5, curve: Curves.easeOut), // First child slides in
    ));

    greetingFadeAnimation = Tween<double>(
      begin: 0.0, // Fully transparent
      end: 1.0, // Fully visible
    ).animate(CurvedAnimation(
      parent: greetingController,
      curve: Interval(0.0, 0.5, curve: Curves.easeOut),
    ));

    subtitleSlideAnimation = Tween<Offset>(
      begin: Offset(0.0, 0.5), // Start slightly below
      end: Offset.zero, // End at normal position
    ).animate(CurvedAnimation(
      parent: greetingController,
      curve:
          Interval(0.5, 1.0, curve: Curves.easeOut), // Second child slides in
    ));

    subtitleFadeAnimation = Tween<double>(
      begin: 0.0, // Fully transparent
      end: 1.0, // Fully visible
    ).animate(CurvedAnimation(
      parent: greetingController,
      curve: Interval(0.5, 1.0, curve: Curves.easeOut),
    ));

    // Card Fade Animation (appears after greeting section finishes)
    cardFadeAnimation = Tween<double>(
      begin: 0.0, // Fully transparent
      end: 1.0, // Fully visible
    ).animate(CurvedAnimation(
      parent: cardController,
      curve: Interval(0.2, 1.0, curve: Curves.easeOut), // Delayed fade-in
    ));

    // Image list section fade and slide animations
    imageListFadeAnimation = Tween<double>(
      begin: 0.0, // Fully transparent
      end: 1.0, // Fully visible
    ).animate(CurvedAnimation(
      parent: carouselController,
      curve: Curves.easeInOut,
    ));

    imageListSlideAnimation = Tween<Offset>(
      begin: Offset(0.0, 0.5), // Start slightly below
      end: Offset.zero, // End at normal position
    ).animate(CurvedAnimation(
      parent: carouselController, // Use the controller for the Image List
      curve: Curves.easeOut, // Smooth slide-in animation
    ));

    sliderSlideAnimation = Tween<double>(
      begin: 0.0, // Start with no width
      end: 1.0, // Fully expanded (normalized)
    ).animate(CurvedAnimation(
      parent: sliderController,
      curve: Curves.easeInOut, // Smooth transition
    ));

    addressTextFadeAnimation = Tween<double>(
      begin: 0.0, // Fully transparent
      end: 1.0, // Fully visible
    ).animate(CurvedAnimation(
      parent: sliderController,
      curve: Interval(
        0.9, // Delay the start until way through the parent animation
        1.0, // Complete at the end of the parent animation
        curve: Curves.easeOut, // Smooth fade-in
      ),
    ));

    // Bottom Navigation Animations
    bottomNavSlideAnimation = Tween<Offset>(
      begin: Offset(0.0, 1.0), // Start off-screen (below)
      end: Offset.zero, // Slide to its normal position
    ).animate(CurvedAnimation(
      parent: bottomNavController,
      curve: Curves.easeInOut,
    ));

    bottomNavFadeAnimation = Tween<double>(
      begin: 0.0, // Fully transparent
      end: 1.0, // Fully visible
    ).animate(CurvedAnimation(
      parent: bottomNavController,
      curve: Curves.easeInOut,
    ));
  }
}
