import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'notification_data.dart';
part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  void add(NotificationData notification) {
    final List<NotificationData> notifications = List.from(state.notifications);
    notifications.insert(0, notification);
    final newState = state.copyWith(notifications: notifications);
    emit(NotificationUpdate(newState));
  }

  void clear() {
    final newState = state.copyWith(notifications: []);
    emit(NotificationUpdate(newState));
  }
}
