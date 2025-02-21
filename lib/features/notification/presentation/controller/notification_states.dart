abstract class NotificationStates {}

class NotificationInitial extends NotificationStates {}

class GetNotificationLoadingState extends NotificationStates {}
class GetNotificationSuccessState extends NotificationStates {}
class GetNotificationErrorState extends NotificationStates {
  final String error;
  GetNotificationErrorState(this.error);
}