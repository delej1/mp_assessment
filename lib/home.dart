import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpassessment/presentation/animations/homepage_animations.dart';
import 'package:mpassessment/presentation/components/compact_navbar.dart';
import 'package:mpassessment/presentation/modules/homepage/view/components/card_section.dart';
import 'package:mpassessment/presentation/modules/homepage/view/homepage.dart';
import 'package:mpassessment/presentation/modules/search/view/search.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  // Define a GlobalKey for Search
  final GlobalKey<SearchState> _searchKey = GlobalKey<SearchState>();
  late HomepageAnimations homepageAnimations;
  int currentIndex = 2;

  late List<Widget?> _pages;

  @override
  void initState() {
    super.initState();

    homepageAnimations = HomepageAnimations(
      topBarController: AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1400),
      ),
      greetingController: AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1200),
      ),
      cardController: AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1200),
      ),
      carouselController: AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1000),
      ),
      sliderController: AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1000),
      ),
      bottomNavController: AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 600),
      ),
    );

    _pages = [
      Search(key: _searchKey),
      null,
      Homepage(homepageAnimations: homepageAnimations),
      null,
      null,
    ];

    _startAnimations();
  }

  void _startAnimations() async {
    try {
      if (currentIndex == 2) {
        await homepageAnimations.topBarController.forward();
        await homepageAnimations.greetingController.forward();
        homepageAnimations.cardController.forward();
        await homepageAnimations.carouselController.forward();
        await homepageAnimations.sliderController.forward();
        await homepageAnimations.bottomNavController.forward();

        // Mark the card animation as completed
        hasCardSectionAnimated = true;
      }
    } catch (e) {
      debugPrint("Error starting animations: $e");
    }
  }

  void _stopAnimations() {
    homepageAnimations.topBarController.stop();
    homepageAnimations.greetingController.stop();
    homepageAnimations.cardController.stop();
    homepageAnimations.carouselController.stop();
    homepageAnimations.sliderController.stop();
    homepageAnimations.bottomNavController.stop();
  }

  @override
  void dispose() {
    homepageAnimations.topBarController.dispose();
    homepageAnimations.greetingController.dispose();
    homepageAnimations.cardController.dispose();
    homepageAnimations.carouselController.dispose();
    homepageAnimations.sliderController.dispose();
    homepageAnimations.bottomNavController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // IndexedStack to maintain the state of pages
          IndexedStack(
            index: currentIndex,
            children: _pages.map((page) => page ?? Container()).toList(),
          ),

          // Positioned bottom navigation bar
          Positioned(
            bottom: 20.h,
            left: 20.w,
            right: 20.w,
            child: SlideTransition(
              position: homepageAnimations.bottomNavSlideAnimation,
              child: FadeTransition(
                opacity: homepageAnimations.bottomNavFadeAnimation,
                child: CompactBottomNavBar(
                    currentIndex: currentIndex,
                    onTap: (index) {
                      // Restrict navigation to valid pages
                      if (_pages[index] != null) {
                        setState(() {
                          // Close any open popups in Search when switching away
                          if (index != 0) {
                            _searchKey.currentState?.removePopupIfOpen();
                          }
                          if (index == 0 && currentIndex != index) {
                            _searchKey.currentState?.resetAnimations();
                          }
                          if (index == 2) {
                            _startAnimations();
                          } else {
                            _stopAnimations();
                          }
                          currentIndex = index;
                        });
                      }
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
