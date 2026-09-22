import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radii.dart';
import '../../core/theme/app_shadows.dart';
import '../../core/theme/app_typography.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String _selectedFilter = 'Todos';

  final List<Map<String, dynamic>> _history = [
    {
      'title': 'Fumigación Agrícola',
      'parcel': 'Finca El Paraíso',
      'area': '8.2 ha',
      'date': '15 Sep 2026',
      'status': 'Completado',
      'cost': 'Q 1,376.00',
    },
    {
      'title': 'Abonado / Sólidos',
      'parcel': 'Parcela Los Olivos',
      'area': '6.1 ha',
      'date': '02 Ago 2026',
      'status': 'Completado',
      'cost': 'Q 1,020.00',
    },
    {
      'title': 'Fertilización Foliar',
      'parcel': 'Finca San José',
      'area': '4.2 ha',
      'date': '10 Jul 2026',
      'status': 'Cancelado',
      'cost': 'Q 0.00',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.cream,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Historial de servicios', style: AppTypography.headline(context)),
              const SizedBox(height: 16),
              // Filter Chips
              Row(
                children: ['Todos', 'Completados', 'Cancelados'].map((filter) {
                  final isSel = _selectedFilter == filter;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedFilter = filter),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSel ? AppColors.emerald : (isDark ? AppColors.darkSurface : AppColors.white),
                        borderRadius: AppRadii.pillBorderRadius,
                        border: Border.all(color: AppColors.emerald),
                      ),
                      child: Text(
                        filter,
                        style: AppTypography.caption(
                          context,
                          color: isSel ? Colors.white : (isDark ? Colors.white : AppColors.darkText),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _history.length,
                  itemBuilder: (context, index) {
                    final item = _history[index];
                    final isComplete = item['status'] == 'Completado';

                    return Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkSurface : AppColors.white,
                        borderRadius: AppRadii.largeBorderRadius,
                        border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.border),
                        boxShadow: AppShadows.soft,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(item['title'], style: AppTypography.body(context, fontWeight: FontWeight.bold)),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: isComplete ? AppColors.softGreen : Colors.red.withOpacity(0.1),
                                  borderRadius: AppRadii.pillBorderRadius,
                                ),
                                child: Text(
                                  item['status'],
                                  style: AppTypography.caption(
                                    context,
                                    color: isComplete ? AppColors.emerald : Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text('${item['parcel']} • ${item['area']}', style: AppTypography.caption(context)),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(item['date'], style: AppTypography.caption(context, color: AppColors.mutedText)),
                              Text(item['cost'], style: AppTypography.body(context, fontWeight: FontWeight.bold, color: AppColors.emerald)),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
