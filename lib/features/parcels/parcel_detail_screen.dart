import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radii.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/widgets/app_buttons.dart';

class ParcelDetailScreen extends StatelessWidget {
  final Map<String, dynamic> parcel;
  final VoidCallback onRequestService;

  const ParcelDetailScreen({
    super.key,
    required this.parcel,
    required this.onRequestService,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(parcel['name'] ?? 'Detalle de Parcela'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Satellite Map Header Image
            ClipRRect(
              borderRadius: AppRadii.largeBorderRadius,
              child: Container(
                height: 200,
                width: double.infinity,
                color: AppColors.deepForest,
                child: Image.asset(
                  parcel['image'] ?? 'assets/images/maps/parcel1.jpg',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: AppColors.forest,
                    child: const Icon(Icons.map, color: Colors.white, size: 60),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Parcel Main Info Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurface : AppColors.white,
                borderRadius: AppRadii.largeBorderRadius,
                border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.border),
              ),
              child: Column(
                children: [
                  _buildInfoRow(context, 'Área total:', parcel['area'] ?? '8.2 ha'),
                  const Divider(),
                  _buildInfoRow(context, 'Cultivo:', parcel['crop'] ?? 'Maíz'),
                  const Divider(),
                  _buildInfoRow(context, 'Ubicación:', parcel['location'] ?? 'Jutiapa'),
                  const Divider(),
                  _buildInfoRow(context, 'Estado:', parcel['status'] ?? 'Activo', isHighlight: true),
                ],
              ),
            ),

            const SizedBox(height: 24),
            Text('Historial de aplicaciones', style: AppTypography.title(context, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            // Timeline Items
            _buildTimelineItem(
              context,
              title: 'Fumigación Agrícola',
              date: '15 Ago 2026',
              status: 'Completado',
            ),
            _buildTimelineItem(
              context,
              title: 'Abonado de Suelo',
              date: '02 Jun 2026',
              status: 'Completado',
            ),

            const SizedBox(height: 32),
            PrimaryButton(
              text: 'Solicitar servicio para esta parcela',
              onPressed: () {
                Navigator.pop(context);
                onRequestService();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value, {bool isHighlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTypography.body(context, color: AppColors.mutedText)),
          Text(
            value,
            style: AppTypography.body(
              context,
              fontWeight: FontWeight.bold,
              color: isHighlight ? AppColors.emerald : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(BuildContext context, {required String title, required String date, required String status}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurfaceElevated : AppColors.softGreen,
        borderRadius: AppRadii.mediumBorderRadius,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.check_circle, color: AppColors.emerald, size: 20),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.body(context, fontWeight: FontWeight.bold)),
                  Text(date, style: AppTypography.caption(context)),
                ],
              ),
            ],
          ),
          Text(status, style: AppTypography.caption(context, color: AppColors.emerald, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
