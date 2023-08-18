part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class CreateMessage extends NotificationEvent {
  String message;
  CreateMessage({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
