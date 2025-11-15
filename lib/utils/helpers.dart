import 'package:intl/intl.dart';

class Helpers {
  static String formatCurrency(double amount, String currencySymbol) {
    final formatter = NumberFormat('#,##0.00');
    return '$currencySymbol${formatter.format(amount)}';
  }
  
  static String formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }
  
  static String formatDateShort(DateTime date) {
    return DateFormat('dd/MM/yy').format(date);
  }
  
  static String formatMonth(DateTime date) {
    return DateFormat('MMMM yyyy').format(date);
  }
  
  static String getMonthYear(DateTime date) {
    return DateFormat('MMM yyyy').format(date);
  }
  
  static DateTime getStartOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }
  
  static DateTime getEndOfMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0, 23, 59, 59);
  }
  
  static String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }
  
  static String getRelativeDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateOnly = DateTime(date.year, date.month, date.day);
    
    if (dateOnly == today) return 'Today';
    if (dateOnly == yesterday) return 'Yesterday';
    
    final difference = today.difference(dateOnly).inDays;
    if (difference < 7) return '${difference} days ago';
    
    return formatDate(date);
  }
}
