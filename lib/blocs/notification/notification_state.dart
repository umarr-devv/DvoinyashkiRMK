// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'notification_cubit.dart';

class NotificationState extends Equatable {
  const NotificationState({this.notifications = const []});

  final List<NotificationData> notifications;

  NotificationState copyWith({List<NotificationData>? notifications}) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
    );
  }

  NotificationState.from(NotificationState other)
    : notifications = other.notifications;

  @override
  List<Object?> get props => [notifications];
}

final class NotificationInitial extends NotificationState {}

final class NotificationUpdate extends NotificationState {
  NotificationUpdate(super.state) : super.from();
}
