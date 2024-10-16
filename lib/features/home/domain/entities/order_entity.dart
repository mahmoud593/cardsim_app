class OrderEntity {
  final DateTime createdAt;
  final String id;
  final String productName;
  final int quantity;
  final double orderTotal;
  final String status;
  final String field;

  OrderEntity(
    this.createdAt,
    this.id,
    this.productName,
    this.quantity,
    this.orderTotal,
    this.status,
    this.field,
  );
}
