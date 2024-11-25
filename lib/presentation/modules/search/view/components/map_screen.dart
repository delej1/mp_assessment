import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:mpassessment/data/constants/colors.dart';
import 'package:mpassessment/presentation/modules/search/view/components/custom_marker.dart';

class MapScreen extends StatefulWidget {
  final String selectedOption;

  const MapScreen({
    super.key,
    required this.selectedOption,
  });

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  late AnimationController _markerAnimationController;
  late Animation<double> _markerSlideAnimation;

  // Marker data
  final List<Map<String, dynamic>> _accommodations = [
    {"location": LatLng(59.940000, 30.340000), "price": 220},
    {"location": LatLng(59.928000, 30.330000), "price": 180},
    {"location": LatLng(59.934000, 30.320000), "price": 250},
    {"location": LatLng(59.934000, 30.350000), "price": 210},
    {"location": LatLng(59.944000, 30.350000), "price": 270},
    {"location": LatLng(59.934280, 30.335099), "price": 190},
  ];

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _markerAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    // Animation to slide/expand markers
    _markerSlideAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _markerAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void didUpdateWidget(MapScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedOption != widget.selectedOption) {
      // Reset and restart the animation
      _markerAnimationController.reset();
      _markerAnimationController.forward();
    }
  }

  @override
  void dispose() {
    _markerAnimationController.dispose();
    super.dispose();
  }

  Future<void> runAnimation() async {
    _markerAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(59.934280, 30.335099),
          initialZoom: 13.5,
        ),
        children: [
          // Tile layer
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            tileBuilder: _darkModeTileBuilder,
          ),

          // Custom Marker Layer
          MarkerLayer(
            markers: _accommodations.map((accommodation) {
              final LatLng position = accommodation['location'] as LatLng;
              final int price = accommodation['price'] as int;

              return Marker(
                point: position,
                width: widget.selectedOption == "Price" ? 50.w : 30.w,
                height: widget.selectedOption == "Price" ? 20.h : 30.h,
                child: AnimatedChatBubbleMarker(
                  position: position,
                  label: widget.selectedOption == "Price" ? "\$$price" : "",
                  animation: _markerSlideAnimation,
                  color: widget.selectedOption == "Price"
                      ? AppColors.primaryA
                      : Colors.transparent,
                  isIcon: widget.selectedOption != "Price",
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _darkModeTileBuilder(
    BuildContext context,
    Widget tileWidget,
    TileImage tile,
  ) {
    return ColorFiltered(
      colorFilter: const ColorFilter.matrix(<double>[
        -0.2126, -0.7152, -0.0722, 0, 255, // Red channel
        -0.2126, -0.7152, -0.0722, 0, 255, // Green channel
        -0.2126, -0.7152, -0.0722, 0, 255, // Blue channel
        0, 0, 0, 1, 0, // Alpha channel
      ]),
      child: tileWidget,
    );
  }
}
