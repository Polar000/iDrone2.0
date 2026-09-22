import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/widgets/app_buttons.dart';

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onComplete;

  const OnboardingScreen({super.key, required this.onComplete});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _slides = [
    {
      'title': 'Drones agrícolas para un futuro mejor',
      'subtitle': 'Tecnología de precisión para cuidar y hacer crecer tu campo con máximo rendimiento.',
      'icon': 'agriculture',
    },
    {
      'title': 'Productividad y ahorro de insumos',
      'subtitle': 'Optimiza la aplicación de nutrientes y protección con mapeo aéreo avanzado.',
      'icon': 'analytics',
    },
    {
      'title': 'Solicita, programa y monitorea',
      'subtitle': 'Sigue el avance en tiempo real de tus cultivos desde la comodidad de tu smartphone.',
      'icon': 'flight_takeoff',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deepForest,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemCount: _slides.length,
                itemBuilder: (context, index) {
                  final slide = _slides[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 220,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.forest.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(color: AppColors.lime.withOpacity(0.3)),
                          ),
                          child: Icon(
                            index == 0
                                ? Icons.agriculture
                                : index == 1
                                    ? Icons.analytics_outlined
                                    : Icons.flight_takeoff_rounded,
                            size: 100,
                            color: AppColors.lime,
                          ),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          slide['title']!,
                          textAlign: TextAlign.center,
                          style: AppTypography.headline(context, color: AppColors.white),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          slide['subtitle']!,
                          textAlign: TextAlign.center,
                          style: AppTypography.body(context, color: AppColors.cream.withOpacity(0.8)),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _slides.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: _currentPage == index ? 28 : 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index ? AppColors.lime : AppColors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
              child: PrimaryButton(
                text: _currentPage == _slides.length - 1 ? 'Comenzar' : 'Siguiente',
                onPressed: () {
                  if (_currentPage < _slides.length - 1) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  } else {
                    widget.onComplete();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
