import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpassessment/data/constants/colors.dart';

class CompactBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CompactBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 30.w,
      ), // Reduce overall width// Add padding
      decoration: BoxDecoration(
        color: AppColors.primaryC.withOpacity(0.9),
        borderRadius: BorderRadius.circular(30.r), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent, // Disable ripple effect
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: AppColors.white,
          unselectedItemColor: AppColors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            _buildNavItem(Icons.search, "Search", currentIndex == 0),
            _buildNavItem(Icons.chat_bubble, "Chat", currentIndex == 1),
            _buildNavItem(Icons.home_filled, "Home", currentIndex == 2),
            _buildNavItem(
                Icons.notifications, "Notifications", currentIndex == 3),
            _buildNavItem(Icons.person, "Profile", currentIndex == 4),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
      IconData icon, String label, bool isSelected) {
    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: Duration(milliseconds: 1000),
        padding: EdgeInsets.all(8.w),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryA // Colored background for selected
              : AppColors.primaryC,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 20.sp,
          color: AppColors.white,
        ),
      ),
      label: label,
    );
  }
}
