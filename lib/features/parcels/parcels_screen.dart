import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radii.dart';
import '../../core/theme/app_shadows.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/widgets/app_buttons.dart';
import 'field_mapper_screen.dart';
import 'parcel_detail_screen.dart';

class ParcelsScreen extends StatefulWidget {
  final VoidCallback onRequestService;

  const ParcelsScreen({super.key, required this.onRequestService});

  @override
  State<ParcelsScreen> createState() => _ParcelsScreenState();
}

class _ParcelsScreenState extends State<ParcelsScreen> {
  final List<Map<String, dynamic>> _parcels = [
    {
      'id': 'p1',
      'name': 'Finca El Paraíso',
      'area': '8.2 ha',
      'crop': 'Maíz',
      'location': 'Jutiapa, Guatemala',
      'status': 'Activo',
      'image': 'assets/images/maps/parcel1.jpg',
    },
    {
      'item': 'p2',
      'name': 'Parcela Los Olivos',
      'area': '6.1 ha',
      'crop': 'Caña de azúcar',
      'location': 'Escuintla, Guatemala',
      'status': 'Activo',
      'image': 'assets/images/maps/parcel2.jpg',
    },
    {
      'id': 'p3',
      'name': 'Finca San José',
      'area': '4.2 ha',
      'crop': 'Melón',
      'location': 'Zacapa, Guatemala',
      'status': 'Activo',
      'image': 'assets/images/maps/parcel3.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.cream,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Mis Parcelas', style: AppTypography.headline(context)),
                      const SizedBox(height: 2),
                      Text('3 parcelas • 18.5 ha totales', style: AppTypography.caption(context)),
                    ],
                  ),
                  PrimaryButton(
                    text: '+ Nueva',
                    width: 110,
                    height: 42,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const FieldMapperScreen()),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Search Bar
              Container(
                height: 52,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkSurface : AppColors.white,
                  borderRadius: AppRadii.mediumBorderRadius,
                  border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.border),
                  boxShadow: AppShadows.soft,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: AppColors.mutedText),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        style: AppTypography.body(context),
                        decoration: const InputDecoration(
                          hintText: 'Buscar parcelas por nombre o cultivo...',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: AppColors.mutedText, fontSize: 14),
                        ),
                      ),
                    ),
                    const Icon(Icons.tune_outlined, color: AppColors.emerald),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Parcel List
              ..._parcels.map((parcel) => _buildParcelCard(context, parcel)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildParcelCard(BuildContext context, Map<String, dynamic> parcel) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ParcelDetailScreen(
              parcel: parcel,
              onRequestService: widget.onRequestService,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : AppColors.white,
          borderRadius: AppRadii.largeBorderRadius,
          border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.border),
          boxShadow: AppShadows.soft,
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
                  child: Container(
                    height: 120,
                    width: double.infinity,
                    color: AppColors.deepForest,
                    child: Image.asset(
                      parcel['image'],
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: AppColors.forest,
                        child: const Icon(Icons.map, color: Colors.white, size: 48),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.softGreen,
                      borderRadius: AppRadii.pillBorderRadius,
                    ),
                    child: Text(
                      parcel['status'],
                      style: AppTypography.caption(context, color: AppColors.emerald, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(parcel['name'], style: AppTypography.title(context, fontWeight: FontWeight.bold)),
                      Text(parcel['area'], style: AppTypography.title(context, color: AppColors.emerald, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.grass_outlined, size: 16, color: AppColors.mutedText),
                      const SizedBox(width: 4),
                      Text(parcel['crop'], style: AppTypography.caption(context)),
                      const SizedBox(width: 12),
                      const Icon(Icons.location_on_outlined, size: 16, color: AppColors.mutedText),
                      const SizedBox(width: 4),
                      Text(parcel['location'], style: AppTypography.caption(context)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
