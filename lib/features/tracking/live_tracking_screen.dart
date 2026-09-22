import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radii.dart';
import '../../core/theme/app_typography.dart';

class LiveTrackingScreen extends StatefulWidget {
  const LiveTrackingScreen({super.key});

  @override
  State<LiveTrackingScreen> createState() => _LiveTrackingScreenState();
}

class _LiveTrackingScreenState extends State<LiveTrackingScreen> {
  final LatLng _dronePos = const LatLng(14.2825, -89.8938);
  final List<LatLng> _polygonPoints = [
    const LatLng(14.2810, -89.8950),
    const LatLng(14.2840, -89.8950),
    const LatLng(14.2840, -89.8920),
    const LatLng(14.2810, -89.8920),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('Aplicación en Curso')),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: _dronePos,
              initialZoom: 16.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.idrone.app',
              ),
              PolygonLayer(
                polygons: [
                  Polygon(
                    points: _polygonPoints,
                    color: AppColors.lime.withOpacity(0.35),
                    borderColor: AppColors.emerald,
                    borderStrokeWidth: 3,
                  ),
                ],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: _dronePos,
                    width: 48,
                    height: 48,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.deepForest,
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 10)],
                      ),
                      child: const Icon(Icons.flight_takeoff, color: AppColors.lime, size: 28),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Bottom Sheet Progress
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurface : Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 16)],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Aplicación en curso', style: AppTypography.title(context, fontWeight: FontWeight.bold)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.softGreen,
                          borderRadius: AppRadii.pillBorderRadius,
                        ),
                        child: Text(
                          'En sitio',
                          style: AppTypography.caption(context, color: AppColors.emerald, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Progreso: 82%', style: AppTypography.body(context, fontWeight: FontWeight.bold)),
                      Text('6.7 ha / 8.2 ha', style: AppTypography.caption(context)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: AppRadii.pillBorderRadius,
                    child: LinearProgressIndicator(
                      value: 0.82,
                      minHeight: 10,
                      backgroundColor: isDark ? AppColors.darkSurfaceElevated : AppColors.softGreen,
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.emerald),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Dron #03 • Agras T40', style: AppTypography.caption(context, fontWeight: FontWeight.bold)),
                      Text('Operador: Carlos Méndez', style: AppTypography.caption(context)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
