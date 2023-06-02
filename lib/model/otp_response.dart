class OtpResponse {
  String? token;
  String? user;
  int? userId;

  OtpResponse({this.token, this.user, this.userId});

  OtpResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['user'] = user;
    data['user_id'] = userId;
    return data;
    }
}