import 'package:games_app/features/withdraws/domain/entities/withdraws_data_entity.dart';

class WithdrawsEntity {
  final bool status;
  final int total;
  final List<WithdrawsDataEntity> data;
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int from;
  final int to;


  WithdrawsEntity(
  {
    required this.total,
    required this.data,
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.from,
    required this.to,
    required this.status,
}

  );
}
