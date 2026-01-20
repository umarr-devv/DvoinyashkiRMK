part of 'notification_cubit.dart';

enum NotificationType { success, info, error }

class NotificationData {
  NotificationData({
    this.icon,
    required this.type,
    required this.title,
    required this.description,
  }) : date = DateTime.now();

  final IconData? icon;
  final NotificationType type;
  final String title;
  final String description;
  final DateTime date;
}
