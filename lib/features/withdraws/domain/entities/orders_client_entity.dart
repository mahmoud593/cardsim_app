  class OrdersClientEntity {
  final int id;
  final String tracking;
  final String productName;
  final String user;
  final double orderTotal;
  final int profit;
  final String status;
  final String createdAt;

  OrdersClientEntity(
      {required this.id,
      required this.tracking,
      required this.productName,
      required this.user,
      required this.orderTotal,
      required this.profit,
      required this.status,
      required this.createdAt});
}
