import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radii.dart';
import '../../core/theme/app_typography.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.cream,
      appBar: AppBar(title: const Text('Clima Agrícola')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Weather Hero Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.deepForest, AppColors.forest],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: AppRadii.heroBorderRadius,
              ),
              child: Column(
                children: [
                  const Icon(Icons.wb_sunny_outlined, size: 64, color: AppColors.lime),
                  const SizedBox(height: 12),
                  Text('24°C', style: AppTypography.display(context, color: Colors.white)),
                  Text('Muy despejado • Viento calmo', style: AppTypography.body(context, color: AppColors.lime)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Spraying Recommendation Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.softGreen,
                borderRadius: AppRadii.largeBorderRadius,
                border: Border.all(color: AppColors.emerald),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle_outline, color: AppColors.emerald, size: 32),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Condiciones Favorables', style: AppTypography.body(context, color: AppColors.deepForest, fontWeight: FontWeight.bold)),
                        Text('Ventana ideal para fumigación y fertilización foliar.', style: AppTypography.caption(context, color: AppColors.deepForest)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Metrics Grid
            Row(
              children: [
                Expanded(child: _buildWeatherMetric(context, 'Humedad', '68%', Icons.water_drop_outlined)),
                const SizedBox(width: 12),
                Expanded(child: _buildWeatherMetric(context, 'Viento', '12 km/h', Icons.air)),
                const SizedBox(width: 12),
                Expanded(child: _buildWeatherMetric(context, 'Lluvia', '5%', Icons.umbrella_outlined)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherMetric(BuildContext context, String title, String val, IconData icon) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : Colors.white,
        borderRadius: AppRadii.mediumBorderRadius,
        border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.border),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.emerald, size: 24),
          const SizedBox(height: 8),
          Text(val, style: AppTypography.body(context, fontWeight: FontWeight.bold)),
          Text(title, style: AppTypography.caption(context)),
        ],
      ),
    );
  }
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.cream,
      appBar: AppBar(title: const Text('Notificaciones')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildNotificationTile(
            context,
            title: 'Servicio por comenzar',
            subtitle: 'El operador Carlos Méndez se dirige a Finca El Paraíso.',
            time: 'Hace 10 min',
            isUnread: true,
          ),
          _buildNotificationTile(
            context,
            title: 'Pago confirmado',
            subtitle: 'Recibo por reserva del 25% generado correctamente.',
            time: 'Hace 2 horas',
            isUnread: false,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationTile(BuildContext context, {required String title, required String subtitle, required String time, required bool isUnread}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isUnread
            ? (isDark ? AppColors.darkSurfaceElevated : AppColors.softGreen)
            : (isDark ? AppColors.darkSurface : Colors.white),
        borderRadius: AppRadii.mediumBorderRadius,
        border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isUnread ? Icons.notifications_active : Icons.notifications_none,
            color: isUnread ? AppColors.emerald : AppColors.mutedText,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.body(context, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(subtitle, style: AppTypography.caption(context)),
                const SizedBox(height: 6),
                Text(time, style: AppTypography.caption(context, color: AppColors.mutedText)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final Function(bool) onToggleDarkMode;
  final bool isDarkMode;
  final VoidCallback onLogout;

  const ProfileScreen({
    super.key,
    required this.onToggleDarkMode,
    required this.isDarkMode,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.cream,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 44,
                backgroundColor: AppColors.emerald,
                child: const Text('CR', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 12),
              Text('Carlos Rodríguez', style: AppTypography.title(context, fontWeight: FontWeight.bold)),
              Text('Guatemala • Cliente Pro', style: AppTypography.caption(context)),
              const SizedBox(height: 28),

              // Option Tiles
              _buildProfileOption(context, icon: Icons.person_outline, label: 'Mis datos personales'),
              _buildProfileOption(context, icon: Icons.payment_outlined, label: 'Métodos de pago'),
              _buildProfileOption(
                context,
                icon: Icons.dark_mode_outlined,
                label: 'Modo Oscuro',
                trailing: Switch(
                  value: isDarkMode,
                  activeColor: AppColors.lime,
                  onChanged: onToggleDarkMode,
                ),
              ),
              _buildProfileOption(context, icon: Icons.help_outline, label: 'Ayuda y soporte'),
              const SizedBox(height: 20),

              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text('Cerrar sesión', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                onTap: onLogout,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption(BuildContext context, {required IconData icon, required String label, Widget? trailing}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : Colors.white,
        borderRadius: AppRadii.mediumBorderRadius,
        border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.border),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.emerald),
        title: Text(label, style: AppTypography.body(context, fontWeight: FontWeight.w600)),
        trailing: trailing ?? const Icon(Icons.chevron_right, color: AppColors.mutedText),
        onTap: trailing == null ? () {} : null,
      ),
    );
  }
}
