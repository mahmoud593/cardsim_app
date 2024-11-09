class PaymentMethodModel {
  bool? status;
  List<Data>? data;

  PaymentMethodModel({this.status, this.data});

  PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? details;
  String? notes;
  String? tax;
  String? image;

  Data({this.id, this.name, this.details, this.notes, this.tax, this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    details = json['details'];
    notes = json['notes'];
    tax = json['tax'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['details'] = this.details;
    data['notes'] = this.notes;
    data['tax'] = this.tax;
    data['image'] = this.image;
    return data;
  }
}