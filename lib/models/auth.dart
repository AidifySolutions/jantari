class Login {
  String? accessToken;
  String? userCode;

  Login({this.accessToken, this.userCode});

  Login.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    userCode = json['user_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['user_code'] = this.userCode;
    return data;
  }
}

class User {
  String? emailAddress;
  List<String>? groupCodes;
  List<Hierarchies>? hierarchies;
  String? phoneNumber;
  Null? personnelNumber;
  bool? twoFactorEnabled;
  bool? isBlocked;
  String? id;
  String? code;
  String? name;

  User({
    this.emailAddress,
    this.groupCodes,
    this.hierarchies,
    this.phoneNumber,
    this.personnelNumber,
    this.twoFactorEnabled,
    this.isBlocked,
    this.id,
    this.code,
    this.name,
  });

  User.fromJson(Map<String, dynamic> json) {
    emailAddress = json['emailAddress'];
    groupCodes = json['groupCodes'].cast<String>();
    if (json['hierarchies'] != null) {
      hierarchies = <Hierarchies>[];
      json['hierarchies'].forEach((v) {
        hierarchies!.add(new Hierarchies.fromJson(v));
      });
    }
    phoneNumber = json['phoneNumber'];
    personnelNumber = json['personnelNumber'];
    twoFactorEnabled = json['twoFactorEnabled'];
    isBlocked = json['isBlocked'];
    id = json['id'];
    code = json['code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emailAddress'] = this.emailAddress;
    data['groupCodes'] = this.groupCodes;
    if (this.hierarchies != null) {
      data['hierarchies'] = this.hierarchies!.map((v) => v.toJson()).toList();
    }
    data['phoneNumber'] = this.phoneNumber;
    data['personnelNumber'] = this.personnelNumber;
    data['twoFactorEnabled'] = this.twoFactorEnabled;
    data['isBlocked'] = this.isBlocked;
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    return data;
  }
}

class Hierarchies {
  String? code;
  List<String>? assignedCodes;

  Hierarchies({this.code, this.assignedCodes});

  Hierarchies.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    assignedCodes = json['assignedCodes'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['assignedCodes'] = this.assignedCodes;
    return data;
  }
}

class GroupDetail {
  List<ModulePermissions>? modulePermissions;
  String? code;
  String? name;

  GroupDetail({this.modulePermissions, this.code, this.name});

  GroupDetail.fromJson(Map<String, dynamic> json) {
    if (json['modulePermissions'] != null) {
      modulePermissions = <ModulePermissions>[];
      json['modulePermissions'].forEach((v) {
        modulePermissions!.add(new ModulePermissions.fromJson(v));
      });
    }
    code = json['code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.modulePermissions != null) {
      data['modulePermissions'] =
          this.modulePermissions!.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    data['name'] = this.name;
    return data;
  }
}

class ModulePermissions {
  String? moduleCode;
  List<String>? permissions;

  ModulePermissions({this.moduleCode, this.permissions});

  ModulePermissions.fromJson(Map<String, dynamic> json) {
    moduleCode = json['moduleCode'];
    permissions = json['permissions'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['moduleCode'] = this.moduleCode;
    data['permissions'] = this.permissions;
    return data;
  }
}