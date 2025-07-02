/// Core constants for the SalonX app

class ApiConstants {
  static const String baseUrl = 'https://api.salonx.com'; // Replace with actual backend URL

  // Authentication
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String refreshToken = '/auth/refresh-token';

  // Services
  static const String services = '/services';
  static const String serviceDetail = '/services/'; // + id

  // Products
  static const String products = '/products';
  static const String productDetail = '/products/'; // + id

  // Bookings
  static const String bookings = '/bookings';
  static const String bookingDetail = '/bookings/'; // + id

  // Queue
  static const String queue = '/queue';

  // Notifications
  static const String notifications = '/notifications';

  // Payments
  static const String payments = '/payments';

  // Reports
  static const String reports = '/reports';

  // Staff
  static const String staff = '/staff';

  // Feedback
  static const String feedback = '/feedback';
}

class AppColors {
  static const int primaryColorValue = 0xFF000000; // Black
  static const int secondaryColorValue = 0xFFFFFFFF; // White

  static const int accentColorValue = 0xFF1E88E5; // Blue accent

  static const int errorColorValue = 0xFFD32F2F; // Red
  static const int successColorValue = 0xFF388E3C; // Green
}

class AppStrings {
  static const String appName = 'SalonX';

  static const String errorNetwork = 'Network error. Please try again.';
  static const String errorUnknown = 'An unknown error occurred.';
  static const String loading = 'Loading...';

  static const String roleCustomer = 'Customer';
  static const String roleAdmin = 'Admin';
}
