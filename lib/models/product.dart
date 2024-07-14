class Product {
  List<Stages>? stages;
  String? code;
  String? description;
  String? name;
  int? status;
  List? applicationCreationCriteria;
  List<Conditions>? conditions;

  Product({this.stages, this.code, this.description, this.name, this.status, this.applicationCreationCriteria});

  Product.fromJson(Map<String, dynamic> json) {
    if (json['stages'] != null) {
      stages = <Stages>[];
      json['stages'].forEach((v) {
        stages!.add(new Stages.fromJson(v));
      });
    }
    code = json['code'];
    description = json['description'];
    name = json['name'];
    status = json['status'];
    applicationCreationCriteria = json['applicationCreationCriteria'];
    if (json['conditions'] != null) {
      conditions = <Conditions>[];
      json['conditions'].forEach((v) {
        conditions!.add(new Conditions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.stages != null) {
      data['stages'] = this.stages!.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    data['description'] = this.description;
    data['name'] = this.name;
    data['status'] = this.status;
    data['applicationCreationCriteria'] = this.applicationCreationCriteria;
    if (this.conditions != null) {
      data['conditions'] = this.conditions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stages {
  String? code;
  String? name;
  List<Fields>? fields;
  List<String>? fieldCodes;

  Stages({this.code, this.name, this.fields, this.fieldCodes});

  Stages.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    if (json['fields'] != null) {
      fields = <Fields>[];
      json['fields'].forEach((v) {
        fields!.add(new Fields.fromJson(v));
      });
    }
    if (json['fieldCodes'] != null) {
      fieldCodes = <String>[];
      json['fieldCodes'].forEach((v) {
        fieldCodes!.add(v.toString());
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    if (this.fields != null) {
      data['fields'] = this.fields!.map((v) => v.toJson()).toList();
    }
    if (this.fieldCodes != null) {
      data['fieldCodes'] = this.fieldCodes!.map((v) => v.toString()).toList();
    }
    return data;
  }
}

class Fields {
  String? id;
  String? header;
  String? code;
  String? group;
  bool? isRequired;
  bool? isReadOnly;
  int? priority;
  String? name;

  Fields(
      {this.id,
        this.header,
        this.code,
        this.group,
        this.isRequired,
        this.isReadOnly,
        this.priority,
        this.name});

  Fields.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    header = json['header'];
    code = json['code'];
    group = json['group'];
    isRequired = json['isRequired'];
    isReadOnly = json['isReadOnly'];
    priority = json['priority'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['header'] = this.header;
    data['code'] = this.code;
    data['group'] = this.group;
    data['isRequired'] = this.isRequired;
    data['isReadOnly'] = this.isReadOnly;
    data['priority'] = this.priority;
    data['name'] = this.name;
    return data;
  }
}

class Conditions {
  String? id;
  int? priority;
  String? name;
  String? code;
  String? description;
  List? stageCodes;
  Expression? expression;
  int? status;
  List<Outcomes>? outcomes;
  bool? validationStatus;

  Conditions(
      {this.id,
        this.priority,
        this.name,
        this.code,
        this.description,
        this.stageCodes,
        this.expression,
        this.status,
        this.outcomes,
        this.validationStatus,
      });

  Conditions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    priority = json['priority'];
    name = json['name'];
    code = json['code'];
    description = json['description'];
    stageCodes = json['stageCodes'];
    expression = json['expression'] != null
        ? new Expression.fromJson(json['expression'])
        : null;
    status = json['status'];
    if (json['outcomes'] != null) {
      outcomes = <Outcomes>[];
      json['outcomes'].forEach((v) {
        outcomes!.add(new Outcomes.fromJson(v));
      });
    }
    validationStatus = json['validationStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['priority'] = this.priority;
    data['name'] = this.name;
    data['code'] = this.code;
    data['description'] = this.description;
    data['stageCodes'] = this.stageCodes;
    if (this.expression != null) {
      data['expression'] = this.expression!.toJson();
    }
    data['status'] = this.status;
    if (this.outcomes != null) {
      data['outcomes'] = this.outcomes!.map((v) => v.toJson()).toList();
    }
    data['validationStatus'] = this.validationStatus;
    return data;
  }
}

class Expression {
  String? expressionTree;
  List<Representations>? representations;

  Expression({this.expressionTree, this.representations});

  Expression.fromJson(Map<String, dynamic> json) {
    expressionTree = json['expressionTree'];
    if (json['representations'] != null) {
      representations = <Representations>[];
      json['representations'].forEach((v) {
        representations!.add(new Representations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['expressionTree'] = this.expressionTree;
    if (this.representations != null) {
      data['representations'] =
          this.representations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Representations {
  String? representationValue;
  int? representationType;

  Representations({this.representationValue, this.representationType});

  Representations.fromJson(Map<String, dynamic> json) {
    representationValue = json['representationValue'];
    representationType = json['representationType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['representationValue'] = this.representationValue;
    data['representationType'] = this.representationType;
    return data;
  }
}

class Outcomes {
  String? id;
  String? code;
  int? type;
  String? group;
  String? header;
  bool? isReadOnly;
  bool? isRequired;
  bool? isHidden;
  int? priority;
  String? value;
  String? masterDataType;

  Outcomes(
      {this.id,
        this.code,
        this.type,
        this.group,
        this.header,
        this.isReadOnly,
        this.isRequired,
        this.isHidden,
        this.priority,
        this.value,
        this.masterDataType,
      });

  Outcomes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    type = json['type'];
    group = json['group'];
    header = json['header'];
    isReadOnly = json['isReadOnly'];
    isRequired = json['isRequired'];
    isHidden = json['isHidden'];
    priority = json['priority'];
    value = json['value'];
    masterDataType = json['masterDataType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['type'] = this.type;
    data['group'] = this.group;
    data['header'] = this.header;
    data['isReadOnly'] = this.isReadOnly;
    data['isRequired'] = this.isRequired;
    data['isHidden'] = this.isHidden;
    data['priority'] = this.priority;
    data['value'] = this.value;
    data['masterDataType'] = this.masterDataType;
    return data;
  }
}