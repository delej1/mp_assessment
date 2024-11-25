import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpassessment/presentation/animations/search_animations.dart';
import 'package:mpassessment/presentation/modules/search/view/components/floating_btns.dart';
import 'package:mpassessment/presentation/modules/search/view/components/map_screen.dart';
import 'package:mpassessment/presentation/modules/search/view/components/search_bar.dart';
import 'package:mpassessment/presentation/modules/search/view/components/variant_btn.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => SearchState();
}

class SearchState extends State<Search> with SingleTickerProviderStateMixin {
  final GlobalKey<FloatingButtonsState> _floatingButtonsKey =
      GlobalKey<FloatingButtonsState>();
  final GlobalKey<MapScreenState> _mapScreenKey = GlobalKey<MapScreenState>();

  late SearchAnimations searchAnimations;

  String selectedOption = "Price";
  bool hasAnimationPlayed = false;

  void removePopupIfOpen() {
    _floatingButtonsKey.currentState?.removeOptionsPopup();
  }

  @override
  void initState() {
    super.initState();
    searchAnimations = SearchAnimations(
      scaleController: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 800),
      ),
    );
  }

  void _startAnimations() async {
    // Only play the animation if it hasn't already been played
    if (!hasAnimationPlayed) {
      try {
        await Future.delayed(Duration(microseconds: 500));
        await searchAnimations.scaleController.forward();
        hasAnimationPlayed = true; // Mark animation as played
        _mapScreenKey.currentState?.runAnimation();
      } catch (e) {
        debugPrint("Error starting animations: $e");
      }
    }
  }

  void resetAnimations() {
    if (!hasAnimationPlayed) {
      searchAnimations.scaleController.reset();
      _startAnimations();
    }
  }

  @override
  void dispose() {
    searchAnimations.scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map View
          MapScreen(
            key: _mapScreenKey,
            selectedOption: selectedOption,
          ),
          // Search Bar
          Positioned(
            top: 40.0.h,
            left: 16.0.w,
            right: 16.0.w,
            child: CustomSearchBar(
              animation: searchAnimations.searchBarScaleAnimation,
            ),
          ),
          // Floating Buttons
          Positioned(
            bottom: 100.0.h,
            left: 30.0.w,
            child: FloatingButtons(
              animation: searchAnimations.floatingButtonsScaleAnimation,
              key: _floatingButtonsKey,
              onOptionSelected: (option) {
                setState(() {
                  selectedOption = option;
                });
              },
            ),
          ),
          // Sticky Button
          Positioned(
            bottom: 100.0.h,
            right: 16.0.w,
            child: ScaleTransition(
              scale: searchAnimations.variantListScaleAnimation,
              child: ListVariantsButton(),
            ),
          ),
        ],
      ),
    );
  }
}
