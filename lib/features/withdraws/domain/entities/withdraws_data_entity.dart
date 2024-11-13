class WithdrawsDataEntity {
  final int id;
  final String tracking;
  final int amount;
  final String status;
  final int prevBalance;
  final int newBalance;
  final String notes;
  final String createdAt;

  WithdrawsDataEntity(
    this.id,
    this.tracking,
    this.amount,
    this.status,
    this.prevBalance,
    this.newBalance,
    this.notes,
    this.createdAt,
  );
}
