class GetAllClientsModel {
  bool? status;
  int? total;
  List<ClientsData>? data;
  int? currentPage;
  int? lastPage;
  int? perPage;
  int? from;
  int? to;

  GetAllClientsModel(
      {this.status,
        this.total,
        this.data,
        this.currentPage,
        this.lastPage,
        this.perPage,
        this.from,
        this.to});

  GetAllClientsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    total = json['total'];
    if (json['data'] != null) {
      data = <ClientsData>[];
      json['data'].forEach((v) {
        data!.add(new ClientsData.fromJson(v));
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

class ClientsData {
  int? id;
  String? name;
  String? phone;
  String? email;
  num? balance;
  int? distEarningRate;
  String? createdAt;

  ClientsData(
      {this.id,
        this.name,
        this.phone,
        this.email,
        this.balance,
        this.distEarningRate,
        this.createdAt});

  ClientsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    balance = json['balance'];
    distEarningRate = json['dist_earning_rate'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['balance'] = this.balance;
    data['dist_earning_rate'] = this.distEarningRate;
    data['created_at'] = this.createdAt;
    return data;
  }
}
