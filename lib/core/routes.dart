import 'package:flutter/material.dart';
import '../ui/screens/splash_screen.dart';
import '../ui/screens/role_selection_new.dart';
import '../ui/screens/new_register.dart';
import '../ui/screens/login_screen.dart';

/// Named routes for SalonX app navigation
class Routes {
  static const String splash = '/splash';
  static const String roleSelection = '/role-selection';
  static const String login = '/login';
  static const String register = '/register';

  // Customer routes
  static const String home = '/home';
  static const String services = '/services';
  static const String serviceDetail = '/service-detail';
  static const String booking = '/booking';
  static const String queue = '/queue';
  static const String products = '/products';
  static const String productDetail = '/product-detail';
  static const String cart = '/cart';
  static const String payment = '/payment';
  static const String paymentHistory = '/payment-history';
  static const String notifications = '/notifications';
  static const String profile = '/profile';
  static const String feedback = '/feedback';
  static const String settings = '/settings';

  // Admin routes
  static const String adminHome = '/admin-home';
  static const String adminQueue = '/admin-queue';
  static const String adminInventory = '/admin-inventory';
  static const String adminServices = '/admin-services';
  static const String adminReports = '/admin-reports';
  static const String adminStaff = '/admin-staff';

  // Route generator
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      
      case roleSelection:
        return MaterialPageRoute(builder: (_) => const RoleSelectionScreen());
      
      case register:
        final role = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => RegisterScreen(role: role),
        );
      
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      
      // Add other routes here as they are implemented
      
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
