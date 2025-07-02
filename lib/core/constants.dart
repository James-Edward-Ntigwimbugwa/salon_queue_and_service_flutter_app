class AppConstants {
  // Base URL for API
  static const String baseUrl = "https://api.example.com";

  // Authentication Endpoints
  static const String login = "/api/accounts/login/";
  static const String register = "/api/accounts/register/";
  static const String logout = "/api/accounts/logout/";
  static const String profile = "/api/accounts/profile/";
  static const String changePassword = "/api/accounts/change-password/";
  static const String updateProfile = "/api/accounts/update-profile/";

  // Inventory Endpoints
  static const String categories = "/api/inventory/categories/";
  static const String products = "/api/inventory/products/";

  // Order Queue & Bookings Endpoints
  static const String orderQueue = "/api/order_queue/";
  static const String bookings = "/api/order_queue/bookings/";

  // Notifications Endpoints
  static const String notifications = "/api/notifications/";
  static const String notificationPreferences = "/api/notifications/preferences/";

  // Payments Endpoints
  static const String payments = "/api/payments/";
  static const String transactions = "/api/payments/transactions/";

  // Reports Endpoints
  static const String inventoryReports = "/api/reports/inventory/";
  static const String salesReports = "/api/reports/sales/";

  // Services Endpoints
  static const String services = "/api/services/";
  static const String serviceCategories = "/api/services/categories/";
  static const String serviceFeedback = "/api/services/feedback/";
}
