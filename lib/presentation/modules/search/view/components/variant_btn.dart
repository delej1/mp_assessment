import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpassessment/data/constants/colors.dart';

class ListVariantsButton extends StatelessWidget {
  const ListVariantsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {}, // Navigate to list view
      icon: Icon(Icons.list),
      label: Text("List of variants"),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.white.withOpacity(0.5),
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0.r),
        ),
      ),
    );
  }
}
