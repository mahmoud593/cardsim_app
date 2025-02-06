class ErrorModel {
  String? message;
  String? errors;

  ErrorModel({this.message, this.errors});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    message = json['message']??"";
    errors = json['errors']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['errors'] = errors;
    return data;
  }
}
