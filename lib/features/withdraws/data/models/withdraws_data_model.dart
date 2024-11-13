import '../../domain/entities/withdraws_data_entity.dart';

class WithdrawsDataModel extends WithdrawsDataEntity {
  WithdrawsDataModel(
    super.id,
    super.tracking,
    super.amount,
    super.status,
    super.prevBalance,
    super.newBalance,
    super.notes,
    super.createdAt,
  );


  factory WithdrawsDataModel.fromJson(Map<String, dynamic> json) {
    return WithdrawsDataModel(
      json['id'],
      json['tracking'],
      json['amount'],
      json['status'],
      json['prev_balance'],
      json['new_balance'],
      json['notes']??'',
      json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tracking': tracking,
      'amount': amount,
      'status': status,
      'prev_balance': prevBalance,
      'new_balance': newBalance,
      'notes': notes,
      'created_at': createdAt,
    };
  }


  @override
  String toString() {
    return 'WithdrawsDataModel(id: $id, tracking: $tracking, amount: $amount, status: $status, prevBalance: $prevBalance, newBalance: $newBalance, notes: $notes, createdAt: $createdAt)';
  }
}
