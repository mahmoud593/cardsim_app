import 'package:games_app/features/home/domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity {

  NotificationModel({
    required super.id,
    required super.createdAt,
    required super.data
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    id: json['id'],
    createdAt: json['created_at'],
    data: NotificationDataModel.fromJson(json['data'])
  );

}

class NotificationDataModel extends NotificationDataEntity {

  NotificationDataModel({
    required super.title,
    required super.data,
    required super.image,
    required super.status
  });

  factory NotificationDataModel.fromJson(Map<String, dynamic> json) => NotificationDataModel(
    title: json['title'],
    data: json['data'],
    image: json['image'],
    status: json['status']
  );


}
