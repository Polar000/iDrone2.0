import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_radii.dart';
import '../core/theme/app_typography.dart';

class AdminDashboardFullView extends StatelessWidget {
  const AdminDashboardFullView({super.key});

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

          // KPI Cards Row
          Row(
            children: [
              Expanded(child: _buildKpiCard(context, title: 'Servicios hoy', value: '12', icon: Icons.agriculture_outlined, color: AppColors.emerald)),
              const SizedBox(width: 16),
              Expanded(child: _buildKpiCard(context, title: 'Reservas pendientes', value: '5', icon: Icons.pending_actions, color: AppColors.warning)),
              const SizedBox(width: 16),
              Expanded(child: _buildKpiCard(context, title: 'En curso', value: '4', icon: Icons.flight_takeoff, color: AppColors.info)),
              const SizedBox(width: 16),
              Expanded(child: _buildKpiCard(context, title: 'Clientes activos', value: '128', icon: Icons.people_outline, color: AppColors.deepForest)),
            ],
          ),

          const SizedBox(height: 28),

          // Analytical Charts Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hectarage Line Chart
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: AppRadii.largeBorderRadius,
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hectáreas atendidas por mes', style: AppTypography.title(context, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 220,
                        child: LineChart(
                          LineChartData(
                            gridData: const FlGridData(show: false),
                            titlesData: const FlTitlesData(show: true),
                            borderData: FlBorderData(show: false),
                            lineBarsData: [
                              LineChartBarData(
                                spots: const [
                                  FlSpot(1, 120),
                                  FlSpot(2, 210),
                                  FlSpot(3, 180),
                                  FlSpot(4, 340),
                                  FlSpot(5, 520),
                                ],
                                isCurved: true,
                                color: AppColors.emerald,
                                barWidth: 4,
                                dotData: const FlDotData(show: true),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20),

              // Crops Distribution Donut Chart
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: AppRadii.largeBorderRadius,
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Distribución por cultivo', style: AppTypography.title(context, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 220,
                        child: PieChart(
                          PieChartData(
                            sectionsSpace: 4,
                            centerSpaceRadius: 40,
                            sections: [
                              PieChartSectionData(value: 45, color: AppColors.emerald, title: 'Maíz (45%)', radius: 45, titleStyle: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold)),
                              PieChartSectionData(value: 30, color: AppColors.forest, title: 'Caña (30%)', radius: 45, titleStyle: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold)),
                              PieChartSectionData(value: 25, color: AppColors.lime, title: 'Otros (25%)', radius: 45, titleStyle: const TextStyle(fontSize: 10, color: AppColors.darkText, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKpiCard(BuildContext context, {required String title, required String value, required IconData icon, required Color color}) {
    return Container(
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
