import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart' as latlng;
import 'package:mpassessment/data/constants/assets.dart';
import 'package:mpassessment/data/constants/colors.dart';

class AnimatedChatBubbleMarker extends StatelessWidget {
  final latlng.LatLng position;
  final String label;
  final Animation<double> animation; // Pass animation to control the expansion
  final Color color;
  final bool isIcon; // Determine if marker should display icon or text

  const AnimatedChatBubbleMarker({
    super.key,
    required this.position,
    required this.label,
    required this.animation,
    required this.color,
    required this.isIcon,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.scale(
          scale: animation.value, // Use animation for scaling
          alignment: Alignment.centerLeft,
          child: isIcon
              ? ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.r),
                    topLeft: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r),
                  ),
                  child: Image.asset(
                    Assets.markerIc,
                    fit: BoxFit.cover,
                  ),
                )
              : CustomPaint(
                  painter: ChatBubblePainter(color: color),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    child: Center(
                      child: Text(
                        label,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}

class ChatBubblePainter extends CustomPainter {
  final Color color;

  ChatBubblePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    final path = Path();
    // Draw chat bubble shape
    path.moveTo(0, size.height); // Start at bottom-left corner
    path.lineTo(0, 10); // Bottom-left corner (sharp)
    path.quadraticBezierTo(0, 0, 10, 0); // Top-left corner (rounded)
    path.lineTo(size.width - 10, 0); // Top-right corner
    path.quadraticBezierTo(
        size.width, 0, size.width, 10); // Top-right corner (rounded)
    path.lineTo(size.width, size.height - 10); // Bottom-right corner
    path.quadraticBezierTo(
        size.width, size.height, size.width - 10, size.height); // Rounded
    path.lineTo(10, size.height); // Bottom edge
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
