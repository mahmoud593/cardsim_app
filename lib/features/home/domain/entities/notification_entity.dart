class NotificationEntity {
  final String id;
  final String createdAt;
  final NotificationDataEntity data;


  NotificationEntity({
    required this.id,
    required this.createdAt,
    required this.data,
  });

}

class NotificationDataEntity {

  final String title;
  final String data;
  final String image;
  final String status;


  NotificationDataEntity({
    required this.title,
    required this.data,
    required this.image,
    required this.status,
  });

}
