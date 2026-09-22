import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radii.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/widgets/app_buttons.dart';

class FieldMapperScreen extends StatefulWidget {
  const FieldMapperScreen({super.key});

  @override
  State<FieldMapperScreen> createState() => _FieldMapperScreenState();
}

class _FieldMapperScreenState extends State<FieldMapperScreen> {
  final MapController _mapController = MapController();
  final List<LatLng> _polygonPoints = [];
  final _nameController = TextEditingController();
  String _selectedCrop = 'Maíz';

  void _addPoint(LatLng point) {
    setState(() {
      _polygonPoints.add(point);
    });
  }

  void _clearPoints() {
    setState(() {
      _polygonPoints.clear();
    });
  }

  double _calculateAreaInHectares() {
    if (_polygonPoints.length < 3) return 0.0;
    // Approximated polygon area calculation for display
    double area = 0.0;
    int j = _polygonPoints.length - 1;
    for (int i = 0; i < _polygonPoints.length; i++) {
      area += (_polygonPoints[j].longitude + _polygonPoints[i].longitude) *
          (_polygonPoints[j].latitude - _polygonPoints[i].latitude);
      j = i;
    }
    return (area.abs() * 111319.5 * 111319.5 / 2.0 / 10000.0);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final computedArea = _calculateAreaInHectares();

    return Scaffold(
      body: Stack(
        children: [
          // Interactive Map
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: const LatLng(14.2819, -89.8943), // Jutiapa
              initialZoom: 15.0,
              onTap: (_, point) => _addPoint(point),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.idrone.app',
              ),
              if (_polygonPoints.length >= 3)
                PolygonLayer(
                  polygons: [
                    Polygon(
                      points: _polygonPoints,
                      color: AppColors.lime.withOpacity(0.4),
                      borderColor: AppColors.emerald,
                      borderStrokeWidth: 3,
                    ),
                  ],
                ),
              MarkerLayer(
                markers: _polygonPoints
                    .map(
                      (pt) => Marker(
                        point: pt,
                        width: 20,
                        height: 20,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.emerald,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),

          // Map Control Floating Buttons
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: isDark ? AppColors.darkSurface : Colors.white,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: AppColors.darkText),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.deepForest,
                    borderRadius: AppRadii.pillBorderRadius,
                  ),
                  child: Text(
                    'Toca el mapa para definir vértices',
                    style: AppTypography.caption(context, color: AppColors.lime, fontWeight: FontWeight.bold),
                  ),
                ),
                CircleAvatar(
                  backgroundColor: isDark ? AppColors.darkSurface : Colors.white,
                  child: IconButton(
                    icon: const Icon(Icons.refresh, color: AppColors.error),
                    onPressed: _clearPoints,
                  ),
                ),
              ],
            ),
          ),

          // Bottom Sheet info and save
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurface : Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                boxShadow: const [
                  BoxShadow(color: Colors.black26, blurRadius: 16, offset: Offset(0, -4)),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Nueva parcela', style: AppTypography.title(context, fontWeight: FontWeight.bold)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.softGreen,
                          borderRadius: AppRadii.pillBorderRadius,
                        ),
                        child: Text(
                          '${computedArea.toStringAsFixed(1)} ha',
                          style: AppTypography.body(context, color: AppColors.emerald, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Nombre de la finca / parcela',
                      border: OutlineInputBorder(borderRadius: AppRadii.mediumBorderRadius),
                    ),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: _selectedCrop,
                    decoration: InputDecoration(
                      labelText: 'Cultivo principal',
                      border: OutlineInputBorder(borderRadius: AppRadii.mediumBorderRadius),
                    ),
                    items: ['Maíz', 'Caña de azúcar', 'Melón', 'Ganadería']
                        .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                        .toList(),
                    onChanged: (val) => setState(() => _selectedCrop = val!),
                  ),
                  const SizedBox(height: 20),
                  PrimaryButton(
                    text: 'Guardar parcela',
                    onPressed: _polygonPoints.length < 3
                        ? null
                        : () {
                            Navigator.pop(context);
                          },
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
