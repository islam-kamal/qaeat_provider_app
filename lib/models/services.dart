/*
class ServicesResponse {
  bool status;
  String errNum;
  String msg;
  List<SalonServices> salonServices;

  ServicesResponse({this.status, this.errNum, this.msg, this.salonServices});

  ServicesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['salon-services'] != null) {
      salonServices = new List<SalonServices>();
      json['salon-services'].forEach((v) {
        salonServices.add(new SalonServices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.salonServices != null) {
      data['salon-services'] =
          this.salonServices.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SalonServices {
  Service service;

  SalonServices({this.service});

  SalonServices.fromJson(Map<String, dynamic> json) {
    service =
    json['service'] != null ? new Service.fromJson(json['service']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
  CategoryName categoryName;

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
        this.categoryName});

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
    categoryName = json['category_name'] != null
        ? new CategoryName.fromJson(json['category_name'])
        : null;
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
    if (this.categoryName != null) {
      data['category_name'] = this.categoryName.toJson();
    }
    return data;
  }
}

class CategoryName {
  String name;

  CategoryName({this.name});

  CategoryName.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
*/

class ServicesResponse {
  bool status;
  String errNum;
  String msg;
  List<SalonServices> salonServices;

  ServicesResponse({this.status, this.errNum, this.msg, this.salonServices});

  ServicesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['salon-services'] != null) {
      salonServices = new List<SalonServices>();
      json['salon-services'].forEach((v) {
        salonServices.add(new SalonServices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.salonServices != null) {
      data['salon-services'] =
          this.salonServices.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SalonServices {
  int id;
  String name;
  String details;
  String icon;
  int price;
  String discount;
  int payment;
  int hallId;
  String createdAt;
  String updatedAt;

  SalonServices(
      {this.id,
        this.name,
        this.details,
        this.icon,
        this.price,
        this.discount,
        this.payment,
        this.hallId,
        this.createdAt,
        this.updatedAt});

  SalonServices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    details = json['details'];
    icon = json['icon'];
    price = json['price'];
    discount = json['discount'];
    payment = json['payment'];
    hallId = json['hall_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['details'] = this.details;
    data['icon'] = this.icon;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['payment'] = this.payment;
    data['hall_id'] = this.hallId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}