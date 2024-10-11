class AuthModel {
  String? token;
  String? role;

  AuthModel({this.token, this.role});

  AuthModel.fromJson(Map<String, dynamic> json) {
    token = json['token']??"";
    role = json['role']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['role'] = role;
    return data;
  }
}