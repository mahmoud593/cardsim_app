class GoogleAuthError {
  bool? status;
  String? message;

  GoogleAuthError({this.message, this.status});

  GoogleAuthError.fromJson(Map<String, dynamic> json) {
    message = json['message']??"";
    status = json['status']??false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}
