class CurrencyModel {
  bool? status;
  List<Data>? data;

  CurrencyModel({this.status, this.data});

  CurrencyModel.fromJson(Map<String, dynamic> json) {
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
  String? short;
  String? code;
  num? exchangeRate;

  Data({this.id, this.short, this.code, this.exchangeRate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    short = json['short'];
    code = json['code'];
    exchangeRate = json['exchange_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['short'] = this.short;
    data['code'] = this.code;
    data['exchange_rate'] = this.exchangeRate;
    return data;
  }
}
