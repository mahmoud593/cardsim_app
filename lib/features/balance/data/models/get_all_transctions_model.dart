class AllTranscationModel {
  bool? status;
  int? total;
  List<Data>? data;
  int? currentPage;
  int? lastPage;
  int? perPage;
  int? from;
  int? to;

  AllTranscationModel(
      {this.status,
        this.total,
        this.data,
        this.currentPage,
        this.lastPage,
        this.perPage,
        this.from,
        this.to});

  AllTranscationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    total = json['total'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    perPage = json['per_page'];
    from = json['from'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['total'] = this.total;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['current_page'] = this.currentPage;
    data['last_page'] = this.lastPage;
    data['per_page'] = this.perPage;
    data['from'] = this.from;
    data['to'] = this.to;
    return data;
  }
}

class Data {
  int? id;
  String? tracking;
  String? payment;
  int? amount;
  dynamic? tax;
  dynamic? total;
  String? image;
  String? status;
  dynamic? notes;
  String? createdAt;

  Data(
      {this.id,
        this.tracking,
        this.payment,
        this.amount,
        this.tax,
        this.total,
        this.image,
        this.status,
        this.notes,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tracking = json['tracking'];
    payment = json['payment'];
    amount = json['amount'];
    tax = json['tax'];
    total = json['total'];
    image = json['image'];
    status = json['status'];
    notes = json['notes'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tracking'] = this.tracking;
    data['payment'] = this.payment;
    data['amount'] = this.amount;
    data['tax'] = this.tax;
    data['total'] = this.total;
    data['image'] = this.image;
    data['status'] = this.status;
    data['notes'] = this.notes;
    data['created_at'] = this.createdAt;
    return data;
  }
}
