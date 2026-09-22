import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'data/supabase_service.dart';
import 'features/auth/splash_screen.dart';
import 'features/auth/onboarding_screen.dart';
import 'features/auth/login_screen.dart';
import 'features/home/home_screen.dart';
import 'features/parcels/parcels_screen.dart';
import 'features/history/history_screen.dart';
import 'features/profile/profile_screen.dart';
import 'features/bookings/booking_wizard_screen.dart';
import 'features/tracking/live_tracking_screen.dart';
import 'features/profile/profile_screen.dart' show WeatherScreen, NotificationsScreen;
import 'operator/operator_home_screen.dart';
import 'admin/admin_shell_screen.dart';
import 'shared/widgets/custom_bottom_navigation.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => SupabaseBackendService()..initialize(),
      child: const IDroneApp(),
    ),
  );
}

class IDroneApp extends StatefulWidget {
  const IDroneApp({super.key});

  @override
  State<IDroneApp> createState() => _IDroneAppState();
}

class _IDroneAppState extends State<IDroneApp> {
  bool _isDarkMode = false;
  String _authState = 'splash'; // splash, onboarding, login, main, operator, admin
  int _currentTab = 0;

  void _toggleDarkMode(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iDRONE',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: _buildCurrentScreen(),
    );
  }

  Widget _buildCurrentScreen() {
    switch (_authState) {
      case 'splash':
        return SplashScreen(
          onFinish: () => setState(() => _authState = 'onboarding'),
        );
      case 'onboarding':
        return OnboardingScreen(
          onComplete: () => setState(() => _authState = 'login'),
        );
      case 'login':
        return LoginScreen(
          onLoginSuccess: () => setState(() => _authState = 'main'),
        );
      case 'operator':
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => setState(() => _authState = 'main'),
            ),
          ),
          body: const OperatorHomeScreen(),
        );
      case 'admin':
        return AdminShellScreen(
          onExitAdmin: () => setState(() => _authState = 'main'),
        );
      case 'main':
      default:
        return Scaffold(
          drawer: Drawer(
            child: ListView(
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(color: Color(0xFF063F35)),
                  child: Text('iDRONE Vistas', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                ),
                ListTile(
                  leading: const Icon(Icons.map),
                  title: const Text('Aplicación en Curso (Tracking)'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const LiveTrackingScreen()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.cloud),
                  title: const Text('Clima Agrícola'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const WeatherScreen()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.notifications),
                  title: const Text('Notificaciones'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen()));
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.badge),
                  title: const Text('Panel de Operador'),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() => _authState = 'operator');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.admin_panel_settings),
                  title: const Text('Panel Administrador (SaaS)'),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() => _authState = 'admin');
                  },
                ),
              ],
            ),
          ),
          body: IndexedStack(
            index: _currentTab,
            children: [
              HomeScreen(
                onNavigateTab: (index) => setState(() => _currentTab = index),
                onRequestService: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BookingWizardScreen(
                        onBookingComplete: () {},
                      ),
                    ),
                  );
                },
              ),
              ParcelsScreen(
                onRequestService: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BookingWizardScreen(
                        onBookingComplete: () {},
                      ),
                    ),
                  );
                },
              ),
              const HistoryScreen(),
              ProfileScreen(
                isDarkMode: _isDarkMode,
                onToggleDarkMode: _toggleDarkMode,
                onLogout: () => setState(() => _authState = 'login'),
              ),
            ],
          ),
          bottomNavigationBar: CustomBottomNavigation(
            currentIndex: _currentTab,
            onTap: (index) => setState(() => _currentTab = index),
            onActionTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BookingWizardScreen(
                    onBookingComplete: () {},
                  ),
                ),
              );
            },
          ),
        );
    }
  }
}
