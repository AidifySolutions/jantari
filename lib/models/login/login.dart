class Authentication {
  String? message;
  TokenResponse? tokenResponse;
  Admin? admin;

  Authentication({this.message, this.tokenResponse, this.admin});

  Authentication.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    tokenResponse = json['tokenResponse'] != null
        ? new TokenResponse.fromJson(json['tokenResponse'])
        : null;
    admin = json['admin'] != null ?  Admin.fromJson(json['admin']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = this.message;
    if (this.tokenResponse != null) {
      data['tokenResponse'] = this.tokenResponse!.toJson();
    }
    if (this.admin != null) {
      data['admin'] = this.admin!.toJson();
    }
    return data;
  }
}

class TokenResponse {
  String? accessToken;
  String? expiresIn;
  String? refreshToken;

  TokenResponse({this.accessToken, this.expiresIn, this.refreshToken});

  TokenResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    expiresIn = json['expires_in'];
    refreshToken = json['refresh_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['expires_in'] = this.expiresIn;
    data['refresh_token'] = this.refreshToken;
    return data;
  }
}

class Admin {
  String? id;
  String? name;
  String? email;
  String? password;
  String? phoneNumber;
  String? createdAt;

  Admin(
      {this.id,
        this.name,
        this.email,
        this.password,
        this.phoneNumber,
        this.createdAt});

  Admin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phoneNumber = json['phoneNumber'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phoneNumber'] = this.phoneNumber;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
