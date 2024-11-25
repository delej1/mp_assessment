import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpassessment/data/constants/colors.dart';

class FloatingButtons extends StatefulWidget {
  final Function(String) onOptionSelected;
  final Animation<double> animation;
  const FloatingButtons(
      {super.key, required this.onOptionSelected, required this.animation});

  @override
  State<FloatingButtons> createState() => FloatingButtonsState();
}

class FloatingButtonsState extends State<FloatingButtons>
    with SingleTickerProviderStateMixin {
  final List<String> options = [
    "Cosy areas",
    "Price",
    "Infrastructure",
    "Without any layer"
  ];
  String selectedOption = "Price"; // Default selected option
  OverlayEntry? _overlayEntry;
  late AnimationController _popupController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _popupController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _popupController,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    // Ensure overlay is removed before disposing of the widget
    _removeOptionsPopup(force: true);
    _popupController.dispose();
    super.dispose();
  }

  void removeOptionsPopup() {
    _removeOptionsPopup();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ScaleTransition(
          scale: widget.animation,
          child: FloatingActionButton(
            onPressed: () {
              if (_overlayEntry != null) {
                _removeOptionsPopup();
              } else {
                _showOptionsPopup(context);
              }
            },
            shape: CircleBorder(),
            backgroundColor: AppColors.white.withOpacity(0.5),
            foregroundColor: AppColors.white,
            child: _getIconForOption(selectedOption, false, isMain: true),
          ),
        ),
        SizedBox(height: 2.0.h),
        ScaleTransition(
          scale: widget.animation,
          child: FloatingActionButton(
            onPressed: () {},
            shape: CircleBorder(),
            backgroundColor: AppColors.white.withOpacity(0.5),
            foregroundColor: AppColors.white,
            child: Icon(Icons.my_location),
          ),
        ),
      ],
    );
  }

  // Show the popup using an Overlay
  void _showOptionsPopup(BuildContext context) {
    if (_overlayEntry != null) return;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          bottom: 150.0.h,
          left: 10.0.w, // Position above the Floating Button
          child: Material(
            color: Colors.transparent,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                width: 180.0.w, // Set custom width for the popup
                padding: EdgeInsets.all(2.0.w),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20.0.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: options.map((option) {
                    final isSelected = option == selectedOption;
                    return ListTile(
                      leading: _getIconForOption(option, isSelected),
                      title: Text(
                        option,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? AppColors.primaryA : Colors.black,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          selectedOption = option;
                        });
                        widget.onOptionSelected(option); // Notify parent
                        _removeOptionsPopup();
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        );
      },
    );
    Overlay.of(context).insert(_overlayEntry!);
    _popupController.forward(); // Start the animation
  }

  void _removeOptionsPopup({bool force = false}) {
    if (_overlayEntry != null) {
      if (force) {
        _overlayEntry?.remove();
        _overlayEntry = null;
      } else {
        _popupController.reverse().then((_) {
          _overlayEntry?.remove();
          _overlayEntry = null;
        });
      }
    }
  }

  Widget _getIconForOption(String option, bool isSelected, {bool? isMain}) {
    IconData iconData;
    switch (option) {
      case "Cosy areas":
        iconData = Icons.shield_outlined; // Example icon for "Cosy areas"
        break;
      case "Price":
        iconData =
            Icons.account_balance_wallet_outlined; // Example icon for "Price"
        break;
      case "Infrastructure":
        iconData = Icons.business_sharp; // Example icon for "Infrastructure"
        break;
      case "Without any layer":
        iconData =
            Icons.layers_outlined; // Example icon for "Without any layer"
        break;
      default:
        iconData = Icons.help_outline; // Default icon
    }
    return Icon(
      iconData,
      color: isSelected
          ? AppColors.primaryA
          : isMain != null && isMain
              ? AppColors.white
              : AppColors.primaryB,
      size: 20.sp,
    );
  }
}
