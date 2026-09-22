import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_radii.dart';
import '../core/theme/app_typography.dart';

class AdminDashboardView extends StatelessWidget {
  const AdminDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Buenos días, Admin', style: AppTypography.headline(context)),
          Text('Resumen operativo y métricas generales del servicio.', style: AppTypography.caption(context)),
          const SizedBox(height: 24),

          // KPI Cards Grid
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildKpiCard(context, title: 'Servicios hoy', value: '12', icon: Icons.agriculture_outlined, color: AppColors.emerald),
              _buildKpiCard(context, title: 'Reservas pendientes', value: '5', icon: Icons.pending_actions, color: AppColors.warning),
              _buildKpiCard(context, title: 'En curso', value: '4', icon: Icons.flight_takeoff, color: AppColors.info),
              _buildKpiCard(context, title: 'Clientes activos', value: '128', icon: Icons.people_outline, color: AppColors.deepForest),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKpiCard(BuildContext context, {required String title, required String value, required IconData icon, required Color color}) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadii.largeBorderRadius,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: AppRadii.mediumBorderRadius,
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: AppTypography.headline(context, color: color)),
              Text(title, style: AppTypography.caption(context)),
            ],
          ),
        ],
      ),
    );
  }
}
