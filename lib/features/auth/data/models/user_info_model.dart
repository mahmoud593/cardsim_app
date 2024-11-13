class UserInfoModel {
  String? token;
  String? name;
  String? email;
  String? phone;
  String? image;
  bool? email_2fa;
  bool? google_2fa;
  String? is_active;
  String? created_at;
  int? id;
  String? distProfit;


  UserInfoModel({
    this.token,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.email_2fa,
    this.google_2fa,
    this.is_active,
    this.created_at,
    this.id,
    this.distProfit
  });


  UserInfoModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    email_2fa = json['email_2fa'];
    google_2fa = json['google_2fa'];
    is_active = json['is_active'];
    created_at = json['created_at'];
    id = json['id'];
    distProfit = json['dist_profit'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['image'] = image;
    data['email_2fa'] = email_2fa;
    data['google_2fa'] = google_2fa;
    data['is_active'] = is_active;
    data['created_at'] = created_at;
    data['id'] = id;
    data['dist_profit'] = distProfit;
    return data;
  }
}