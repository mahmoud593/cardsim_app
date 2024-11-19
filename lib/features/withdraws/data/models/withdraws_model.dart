

import 'package:games_app/features/withdraws/data/models/withdraws_data_model.dart';

import '../../domain/entities/withdraws_entity.dart';

class WithdrawsModel extends WithdrawsEntity {
  WithdrawsModel(
      {required super.total,
      required super.data,
      required super.currentPage,
      required super.lastPage,
      required super.perPage,
      required super.from,
      required super.to,
      required super.status});

  factory WithdrawsModel.fromJson(Map<String, dynamic> json) {
    return WithdrawsModel(
      total: json['total']??0,
      data: List<WithdrawsDataModel>.from(
          json['data'].map((x) => WithdrawsDataModel.fromJson(x))),
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      perPage: json['per_page'],
      from: json['from'],
      to: json['to'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'current_page': currentPage,
      'last_page': lastPage,
      'per_page': perPage,
      'from': from,
      'to': to,
      'data': data,
    };
  }

  @override
  String toString() {
    return 'WithdrawsModel(total: $total, currentPage: $currentPage, lastPage: $lastPage, perPage: $perPage, from: $from, to: $to, data: $data)';
  }
}
