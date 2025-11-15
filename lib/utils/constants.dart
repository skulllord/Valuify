class AppConstants {
  static const String appName = 'Valuify';
  
  // Spacing
  static const double spacing4 = 4.0;
  static const double spacing8 = 8.0;
  static const double spacing12 = 12.0;
  static const double spacing16 = 16.0;
  static const double spacing24 = 24.0;
  static const double spacing32 = 32.0;
  
  // Border Radius
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 24.0;
  
  // Animation Duration
  static const Duration animationDuration = Duration(milliseconds: 300);
  
  // Default Categories
  static const List<Map<String, dynamic>> defaultCategories = [
    {'name': 'Food & Dining', 'icon': '🍔', 'color': 0xFFFF6B6B, 'type': 'expense'},
    {'name': 'Shopping', 'icon': '🛍️', 'color': 0xFF4ECDC4, 'type': 'expense'},
    {'name': 'Transportation', 'icon': '🚗', 'color': 0xFF45B7D1, 'type': 'expense'},
    {'name': 'Entertainment', 'icon': '🎬', 'color': 0xFF96CEB4, 'type': 'expense'},
    {'name': 'Bills & Utilities', 'icon': '💡', 'color': 0xFFFECA57, 'type': 'expense'},
    {'name': 'Healthcare', 'icon': '🏥', 'color': 0xFFEE5A6F, 'type': 'expense'},
    {'name': 'Education', 'icon': '📚', 'color': 0xFF786FA6, 'type': 'expense'},
    {'name': 'Salary', 'icon': '💰', 'color': 0xFF26DE81, 'type': 'income'},
    {'name': 'Freelance', 'icon': '💼', 'color': 0xFF20BF6B, 'type': 'income'},
    {'name': 'Investment', 'icon': '📈', 'color': 0xFF0FB9B1, 'type': 'income'},
  ];
  
  // Currency List
  static const List<Map<String, String>> currencies = [
    {'code': 'USD', 'symbol': '\$', 'name': 'US Dollar'},
    {'code': 'EUR', 'symbol': '€', 'name': 'Euro'},
    {'code': 'GBP', 'symbol': '£', 'name': 'British Pound'},
    {'code': 'INR', 'symbol': '₹', 'name': 'Indian Rupee'},
    {'code': 'JPY', 'symbol': '¥', 'name': 'Japanese Yen'},
    {'code': 'CNY', 'symbol': '¥', 'name': 'Chinese Yuan'},
  ];
}
