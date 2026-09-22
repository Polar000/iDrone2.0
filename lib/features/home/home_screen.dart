import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radii.dart';
import '../../core/theme/app_shadows.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/widgets/app_buttons.dart';
import '../../shared/widgets/app_cards.dart';

class HomeScreen extends StatefulWidget {
  final Function(int) onNavigateTab;
  final VoidCallback onRequestService;

  const HomeScreen({
    super.key,
    required this.onNavigateTab,
    required this.onRequestService,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedServiceIndex = 0;

  final List<Map<String, String>> _services = [
    {
      'title': 'Fumigación Agrícola',
      'subtitle': 'Protección de cultivos de alta precisión',
      'badge': 'Fumigación',
      'image': 'assets/images/agriculture/fumigation.jpg',
    },
    {
      'title': 'Abonado / Sólidos',
      'subtitle': 'Mejor nutrición y dispensación de suelo',
      'badge': 'Sólidos',
      'image': 'assets/images/agriculture/fertilizer.jpg',
    },
    {
      'title': 'Fertilización Foliar',
      'subtitle': 'Absorción optimizada para crecimiento',
      'badge': 'Fertilización',
      'image': 'assets/images/agriculture/foliar.jpg',
    },
  ];

  final List<Map<String, String>> _crops = [
    {'name': 'Maíz', 'image': 'assets/images/crops/corn.jpg'},
    {'name': 'Caña', 'image': 'assets/images/crops/sugar.jpg'},
    {'name': 'Melón', 'image': 'assets/images/crops/melon.jpg'},
    {'name': 'Ganadería', 'image': 'assets/images/crops/cattle.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.cream,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. HEADER
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Buenos días',
                          style: AppTypography.caption(
                            context,
                            color: isDark ? AppColors.darkMutedText : AppColors.mutedText,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 18, color: AppColors.emerald),
                            const SizedBox(width: 4),
                            Text(
                              'Finca El Paraíso',
                              style: AppTypography.title(context, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isDark ? AppColors.darkSurface : AppColors.white,
                                shape: BoxShape.circle,
                                boxShadow: AppShadows.soft,
                              ),
                              child: const Icon(Icons.notifications_outlined, size: 22),
                            ),
                            Positioned(
                              right: 2,
                              top: 2,
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  color: AppColors.lime,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 12),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColors.emerald,
                          child: const Text('CR', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // 2. HERO HOME BANNER WITH STAT CARD OVERLAY
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Main Hero Image Banner (~38% of visible area)
                    ClipRRect(
                      borderRadius: AppRadii.heroBorderRadius,
                      child: Container(
                        height: 260,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: AppColors.deepForest,
                        ),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Image.asset(
                                'assets/images/agriculture/hero_drone.jpg',
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  color: AppColors.deepForest,
                                  child: const Icon(Icons.flight_takeoff, color: AppColors.lime, size: 80),
                                ),
                              ),
                            ),
                            // Dark Green Gradient Overlay
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      AppColors.deepForest.withOpacity(0.7),
                                      AppColors.deepForest.withOpacity(0.95),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              ),
                            ),
                            // Hero Content
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'Tu campo, en buenas manos',
                                    style: AppTypography.headline(context, color: AppColors.white),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Drones agrícolas para un campo más productivo, rentable y sostenible.',
                                    style: AppTypography.caption(context, color: AppColors.cream.withOpacity(0.85)),
                                  ),
                                  const SizedBox(height: 14),
                                  PrimaryButton(
                                    text: 'Solicitar servicio',
                                    icon: Icons.add,
                                    height: 44,
                                    width: 175,
                                    onPressed: widget.onRequestService,
                                  ),
                                  const SizedBox(height: 35), // Space for floating StatCard
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Floating StatCard Overlapping Hero Banner
                    const Positioned(
                      bottom: -45,
                      left: 14,
                      right: 14,
                      child: StatCard(
                        metric: '+500',
                        label: 'Hectáreas atendidas',
                        feature1: 'Servicio rápido',
                        feature2: 'Servicio seguro',
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 65), // Clearance for floating StatCard

              // 3. SECCIÓN SERVICIOS
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Nuestros servicios', style: AppTypography.title(context, fontWeight: FontWeight.bold)),
                    TextButton(
                      onPressed: () => widget.onNavigateTab(2),
                      child: Text('Ver todos', style: AppTypography.caption(context, color: AppColors.emerald, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 190,
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 20, right: 8),
                  scrollDirection: Axis.horizontal,
                  itemCount: _services.length,
                  itemBuilder: (context, index) {
                    final item = _services[index];
                    return ServiceCard(
                      title: item['title']!,
                      subtitle: item['subtitle']!,
                      badgeText: item['badge']!,
                      imagePath: item['image']!,
                      isSelected: _selectedServiceIndex == index,
                      onTap: () => setState(() => _selectedServiceIndex = index),
                    );
                  },
                ),
              ),

              const SizedBox(height: 28),

              // 4. CULTIVOS MÁS COMUNES
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text('Cultivos más comunes', style: AppTypography.title(context, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _crops
                      .map(
                        (crop) => CropCard(
                          name: crop['name']!,
                          imagePath: crop['image']!,
                          onTap: widget.onRequestService,
                        ),
                      )
                      .toList(),
                ),
              ),

              const SizedBox(height: 32),

              // 5. PRÓXIMO SERVICIO
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text('Próximo servicio', style: AppTypography.title(context, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkSurface : AppColors.white,
                    borderRadius: AppRadii.largeBorderRadius,
                    border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.border),
                    boxShadow: AppShadows.soft,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColors.softGreen,
                                  borderRadius: AppRadii.mediumBorderRadius,
                                ),
                                child: const Icon(Icons.flight_takeoff, color: AppColors.emerald),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Fumigación agrícola', style: AppTypography.body(context, fontWeight: FontWeight.bold)),
                                  Text('Finca El Paraíso • 8.2 ha', style: AppTypography.caption(context)),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.softGreen,
                              borderRadius: AppRadii.pillBorderRadius,
                            ),
                            child: Text(
                              'Programado',
                              style: AppTypography.caption(context, color: AppColors.emerald, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Divider(),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.calendar_today_outlined, size: 16, color: AppColors.mutedText),
                              const SizedBox(width: 6),
                              Text('15 Sep, 09:00 AM', style: AppTypography.caption(context, fontWeight: FontWeight.w600)),
                            ],
                          ),
                          SecondaryButton(
                            text: 'Ver servicio',
                            onPressed: () => widget.onNavigateTab(2),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
