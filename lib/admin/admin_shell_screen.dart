import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import 'admin_dashboard_full_view.dart';
import 'admin_bookings_table_view.dart';

class AdminShellScreen extends StatefulWidget {
  final VoidCallback onExitAdmin;

  const AdminShellScreen({super.key, required this.onExitAdmin});

  @override
  State<AdminShellScreen> createState() => _AdminShellScreenState();
}

class _AdminShellScreenState extends State<AdminShellScreen> {
  int _selectedNavIndex = 0;

  final List<Map<String, dynamic>> _sidebarItems = [
    {'title': 'Dashboard', 'icon': Icons.dashboard_outlined},
    {'title': 'Reservas', 'icon': Icons.calendar_today_outlined},
    {'title': 'Operaciones', 'icon': Icons.flight_takeoff},
    {'title': 'Clientes', 'icon': Icons.people_outline},
    {'title': 'Parcelas', 'icon': Icons.map_outlined},
    {'title': 'Operadores', 'icon': Icons.badge_outlined},
    {'title': 'Drones', 'icon': Icons.precision_manufacturing_outlined},
    {'title': 'Servicios', 'icon': Icons.agriculture_outlined},
    {'title': 'Reportes', 'icon': Icons.bar_chart_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1024;

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: Row(
        children: [
          // Permanent Dark Deep Forest Sidebar
          Container(
            width: isDesktop ? 240 : 70,
            color: AppColors.deepForest,
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Logo Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.lime,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.flight_takeoff, color: AppColors.deepForest, size: 20),
                      ),
                      if (isDesktop) ...[
                        const SizedBox(width: 12),
                        Text(
                          'iDRONE Admin',
                          style: AppTypography.title(context, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                const Divider(color: Colors.white24),

                // Navigation Items
                Expanded(
                  child: ListView.builder(
                    itemCount: _sidebarItems.length,
                    itemBuilder: (context, index) {
                      final item = _sidebarItems[index];
                      final isSelected = _selectedNavIndex == index;

                      return GestureDetector(
                        onTap: () => setState(() => _selectedNavIndex = index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.emerald : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                item['icon'],
                                color: isSelected ? AppColors.lime : Colors.white70,
                                size: 22,
                              ),
                              if (isDesktop) ...[
                                const SizedBox(width: 12),
                                Text(
                                  item['title'],
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : Colors.white70,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Exit Admin Button
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: IconButton(
                    icon: const Icon(Icons.exit_to_app, color: Colors.white70),
                    tooltip: 'Volver a App Móvil',
                    onPressed: widget.onExitAdmin,
                  ),
                ),
              ],
            ),
          ),

          // Main View Content Area
          Expanded(
            child: Column(
              children: [
                // Top Header Bar
                Container(
                  height: 64,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: BorderSide(color: AppColors.border)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _sidebarItems[_selectedNavIndex]['title'],
                        style: AppTypography.title(context, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.notifications_none, color: AppColors.mutedText),
                            onPressed: () {},
                          ),
                          const SizedBox(width: 16),
                          const CircleAvatar(
                            radius: 16,
                            backgroundColor: AppColors.emerald,
                            child: Text('AD', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(width: 8),
                          if (isDesktop)
                            Text('Administrador', style: AppTypography.body(context, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ],
                  ),
                ),

                // Active View Body
                Expanded(
                  child: _selectedNavIndex == 1
                      ? const AdminBookingsTableView()
                      : const AdminDashboardFullView(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
