import 'package:flutter/animation.dart';

class SearchAnimations {
  final AnimationController scaleController;

  late Animation<double> searchBarScaleAnimation;
  late Animation<double> floatingButtonsScaleAnimation;
  late Animation<double> variantListScaleAnimation;
  late Animation<double> markerScaleAnimation;

  SearchAnimations({required this.scaleController}) {
    searchBarScaleAnimation = CurvedAnimation(
      parent: scaleController,
      curve: Interval(0.0, 1.0, curve: Curves.easeOut),
    );

    floatingButtonsScaleAnimation = CurvedAnimation(
      parent: scaleController,
      curve: Interval(0.0, 1.0, curve: Curves.easeOut),
    );

    variantListScaleAnimation = CurvedAnimation(
      parent: scaleController,
      curve: Interval(0.0, 1.0, curve: Curves.easeOut),
    );

    markerScaleAnimation = CurvedAnimation(
      parent: scaleController,
      curve: Interval(0.0, 1.0, curve: Curves.easeOut),
    );
  }
}
