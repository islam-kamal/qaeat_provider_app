class DaysResponse {
  bool status;
  String errNum;
  String msg;
  List<Days> days;
  List<WorkDays> workDayes;

  DaysResponse({this.status, this.errNum, this.msg, this.days});

  DaysResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['days'] != null) {
      days = new List<Days>();
      json['days'].forEach((v) {
        days.add(new Days.fromJson(v));
      });
    }
    if (json['days'] != null) {
      workDayes = new List<WorkDays>();
      json['days'].forEach((v) {
        workDayes.add(new WorkDays.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.days != null) {
      data['days'] = this.days.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Days {
  int id;
  String name;
  bool isSellected;

  Days({this.id, this.name ,this.isSellected});

  Days.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isSellected=false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
class WorkDays {
  int id;
  String name;
  bool isSellected;

  WorkDays({this.id, this.name ,this.isSellected});

  WorkDays.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isSellected=false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
