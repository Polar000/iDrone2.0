import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radii.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/widgets/app_buttons.dart';

class OperatorHomeScreen extends StatefulWidget {
  const OperatorHomeScreen({super.key});

  @override
  State<OperatorHomeScreen> createState() => _OperatorHomeScreenState();
}

class _OperatorHomeScreenState extends State<OperatorHomeScreen> {
  String _jobStatus = 'En camino';

  void _advanceJobStatus() {
    setState(() {
      if (_jobStatus == 'En camino') {
        _jobStatus = 'En sitio';
      } else if (_jobStatus == 'En sitio') {
        _jobStatus = 'En aplicación';
      } else if (_jobStatus == 'En aplicación') {
        _jobStatus = 'Finalizado';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.cream,
      appBar: AppBar(
        title: const Text('Panel de Operador'),
        actions: [
          IconButton(icon: const Icon(Icons.person), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Operator Header Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.deepForest,
                borderRadius: AppRadii.largeBorderRadius,
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColors.lime,
                    child: Icon(Icons.flight_takeoff, color: AppColors.deepForest),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Carlos Méndez', style: AppTypography.title(context, color: Colors.white, fontWeight: FontWeight.bold)),
                      Text('Operador Dron #03 • Agras T40', style: AppTypography.caption(context, color: AppColors.lime)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            Text('Servicios asignados hoy', style: AppTypography.title(context, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            // Active Job Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurface : Colors.white,
                borderRadius: AppRadii.largeBorderRadius,
                border: Border.all(color: AppColors.emerald, width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Fumigación Agrícola', style: AppTypography.body(context, fontWeight: FontWeight.bold)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.softGreen,
                          borderRadius: AppRadii.pillBorderRadius,
                        ),
                        child: Text(_jobStatus, style: AppTypography.caption(context, color: AppColors.emerald, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('Finca El Paraíso • 8.2 ha • Maíz', style: AppTypography.caption(context)),
                  Text('Jutiapa, Guatemala', style: AppTypography.caption(context, color: AppColors.mutedText)),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 12),

                  if (_jobStatus != 'Finalizado') ...[
                    PrimaryButton(
                      text: _jobStatus == 'En camino'
                          ? 'Marcar En Sitio'
                          : _jobStatus == 'En sitio'
                              ? 'Iniciar Aplicación'
                              : 'Finalizar Servicio',
                      onPressed: _advanceJobStatus,
                    ),
                  ] else ...[
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.softGreen,
                        borderRadius: AppRadii.mediumBorderRadius,
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle, color: AppColors.emerald),
                          const SizedBox(width: 8),
                          Text('Servicio completado con éxito', style: AppTypography.body(context, color: AppColors.emerald, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
