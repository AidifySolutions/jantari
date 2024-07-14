class Meeting {
  String? odataEtag;
  String? id;
  Start? start;
  Start? end;
  List<Attendees>? attendees;
  Organizer? organizer;

  Meeting(
      {this.odataEtag,
        this.id,
        this.start,
        this.end,
        this.attendees,
        this.organizer});

  Meeting.fromJson(Map<String, dynamic> json) {
    odataEtag = json['@odata.etag'];
    id = json['id'];
    start = json['start'] != null ? new Start.fromJson(json['start']) : null;
    end = json['end'] != null ? new Start.fromJson(json['end']) : null;
    if (json['attendees'] != null) {
      attendees = <Attendees>[];
      json['attendees'].forEach((v) {
        attendees!.add(new Attendees.fromJson(v));
      });
    }
    organizer = json['organizer'] != null
        ? new Organizer.fromJson(json['organizer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@odata.etag'] = this.odataEtag;
    data['id'] = this.id;
    if (this.start != null) {
      data['start'] = this.start!.toJson();
    }
    if (this.end != null) {
      data['end'] = this.end!.toJson();
    }
    if (this.attendees != null) {
      data['attendees'] = this.attendees!.map((v) => v.toJson()).toList();
    }
    if (this.organizer != null) {
      data['organizer'] = this.organizer!.toJson();
    }
    return data;
  }
}

class Start {
  String? dateTime;
  String? timeZone;

  Start({this.dateTime, this.timeZone});

  Start.fromJson(Map<String, dynamic> json) {
    dateTime = json['dateTime'];
    timeZone = json['timeZone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dateTime'] = this.dateTime;
    data['timeZone'] = this.timeZone;
    return data;
  }
}

class Attendees {
  String? type;
  Status? status;
  EmailAddress? emailAddress;

  Attendees({this.type, this.status, this.emailAddress});

  Attendees.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
    emailAddress = json['emailAddress'] != null
        ? new EmailAddress.fromJson(json['emailAddress'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    if (this.emailAddress != null) {
      data['emailAddress'] = this.emailAddress!.toJson();
    }
    return data;
  }
}

class Status {
  String? response;
  String? time;

  Status({this.response, this.time});

  Status.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response'] = this.response;
    data['time'] = this.time;
    return data;
  }
}

class EmailAddress {
  String? name;
  String? address;

  EmailAddress({this.name, this.address});

  EmailAddress.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address'] = this.address;
    return data;
  }
}

class Organizer {
  EmailAddress? emailAddress;

  Organizer({this.emailAddress});

  Organizer.fromJson(Map<String, dynamic> json) {
    emailAddress = json['emailAddress'] != null
        ? new EmailAddress.fromJson(json['emailAddress'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.emailAddress != null) {
      data['emailAddress'] = this.emailAddress!.toJson();
    }
    return data;
  }
}
