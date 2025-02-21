import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/home/domain/entities/notification_entity.dart';
import 'package:games_app/features/home/domain/repos/home_repo.dart';
import 'package:games_app/features/notification/presentation/controller/notification_states.dart';

class NotificationCubit extends Cubit<NotificationStates> {

  NotificationCubit(this.homeRepo) : super(NotificationInitial());

  List<NotificationEntity> notifications = [];
  final HomeRepo homeRepo;

  Future<void> getNotification() async {
    notifications=[];
    emit(GetNotificationLoadingState());
    var result = await homeRepo.getNotifications();
    result.fold(
            (l) => emit(GetNotificationErrorState(l.error)),
            (r) {
              notifications = r;
              emit(GetNotificationSuccessState());
    });
  }


}