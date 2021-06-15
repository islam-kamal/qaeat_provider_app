class EmplyeeResponse {
  bool status;
  String errNum;
  String msg;
  List<Employees> employees;

  EmplyeeResponse({this.status, this.errNum, this.msg, this.employees});

  EmplyeeResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['employees'] != null) {
      employees = new List<Employees>();
      json['employees'].forEach((v) {
        employees.add(new Employees.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.employees != null) {
      data['employees'] = this.employees.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Employees {
  int id;
  String name;
  String nationality;
  String mobile;
  String timeFrom;
  String timeTo;
  int salonId;
  int serviceId;
  Service service;

  Employees(
      {this.id,
        this.name,
        this.nationality,
        this.mobile,
        this.timeFrom,
        this.timeTo,
        this.salonId,
        this.serviceId,

        this.service});

  Employees.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nationality = json['nationality'];
    mobile = json['mobile'];
    timeFrom = json['time_from'];
    timeTo = json['time_to'];
    salonId = json['salon_id'];
    serviceId = json['service_id'];
    service =
    json['service'] != null ? new Service.fromJson(json['service']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['nationality'] = this.nationality;
    data['mobile'] = this.mobile;
    data['time_from'] = this.timeFrom;
    data['time_to'] = this.timeTo;
    data['salon_id'] = this.salonId;
    data['service_id'] = this.serviceId;
    if (this.service != null) {
      data['service'] = this.service.toJson();
    }
    return data;
  }
}

class Service {
  int id;
  String name;
  String details;
  String icon;
  int bookingBefore;
  int homeService;
  int price;
  String bonus;
  String estimatedTime;
  int payment;
  int categoryId;
  Null createdAt;
  String updatedAt;

  Service(
      {this.id,
        this.name,
        this.details,
        this.icon,
        this.bookingBefore,
        this.homeService,
        this.price,
        this.bonus,
        this.estimatedTime,
        this.payment,
        this.categoryId,
        this.createdAt,
        this.updatedAt});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    details = json['details'];
    icon = json['icon'];
    bookingBefore = json['booking_before'];
    homeService = json['home_service'];
    price = json['price'];
    bonus = json['bonus'];
    estimatedTime = json['estimated_time'];
    payment = json['payment'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['details'] = this.details;
    data['icon'] = this.icon;
    data['booking_before'] = this.bookingBefore;
    data['home_service'] = this.homeService;
    data['price'] = this.price;
    data['bonus'] = this.bonus;
    data['estimated_time'] = this.estimatedTime;
    data['payment'] = this.payment;
    data['category_id'] = this.categoryId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
