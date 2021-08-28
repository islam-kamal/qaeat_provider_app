


class BounsListResponse {
  var status;
  var errNum;
  var msg;
  Data data;

  BounsListResponse({this.status, this.errNum, this.msg, this.data});

  BounsListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  var appTotalRevenue;
  var hallsTotalRevenue;
  var appThisDayRevenue;
  var hallThisDayRevenue;
  var appThisMonthRevenue;
  var hallThisMonthRevenue;
  var ordersNumbers;
  var orderMonthlyNumber;
  var orderDailyNumber;
  List<Bouns> bouns;

  Data(
      {this.appTotalRevenue,
        this.hallsTotalRevenue,
        this.appThisDayRevenue,
        this.hallThisDayRevenue,
        this.appThisMonthRevenue,
        this.hallThisMonthRevenue,
        this.ordersNumbers,
        this.orderMonthlyNumber,
        this.orderDailyNumber,
        this.bouns});

  Data.fromJson(Map<String, dynamic> json) {
    appTotalRevenue = json['AppTotalRevenue'];
    hallsTotalRevenue = json['hallsTotalRevenue'];
    appThisDayRevenue = json['AppThisDayRevenue'];
    hallThisDayRevenue = json['hallThisDayRevenue'];
    appThisMonthRevenue = json['AppThisMonthRevenue'];
    hallThisMonthRevenue = json['hallThisMonthRevenue'];
    ordersNumbers = json['orders_numbers'];
    orderMonthlyNumber = json['orderMonthlyNumber'];
    orderDailyNumber = json['orderDailyNumber'];
    if (json['bouns'] != null) {
      bouns = new List<Bouns>();
      json['bouns'].forEach((v) {
        bouns.add(new Bouns.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AppTotalRevenue'] = this.appTotalRevenue;
    data['hallsTotalRevenue'] = this.hallsTotalRevenue;
    data['AppThisDayRevenue'] = this.appThisDayRevenue;
    data['hallThisDayRevenue'] = this.hallThisDayRevenue;
    data['AppThisMonthRevenue'] = this.appThisMonthRevenue;
    data['hallThisMonthRevenue'] = this.hallThisMonthRevenue;
    data['orders_numbers'] = this.ordersNumbers;
    data['orderMonthlyNumber'] = this.orderMonthlyNumber;
    data['orderDailyNumber'] = this.orderDailyNumber;
    if (this.bouns != null) {
      data['bouns'] = this.bouns.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Bouns {
  var id;
  var title;
  var date;
  var time;
  var payment;
  var cost;
  var totalBonus;
  var totalCost;
  var orderPaid;
  var status;
  var hallId;
  var userId;
  var createdAt;
  var updatedAt;
  List<Services> services;
  User user;

  Bouns(
      {this.id,
        this.title,
        this.date,
        this.time,
        this.payment,
        this.cost,
        this.totalBonus,
        this.totalCost,
        this.orderPaid,
        this.status,
        this.hallId,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.services,
        this.user});

  Bouns.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    date = json['date'];
    time = json['time'];
    payment = json['payment'];
    cost = json['cost'];
    totalBonus = json['total_bonus'];
    totalCost = json['total_cost'];
    orderPaid = json['order_paid'];
    status = json['status'];
    hallId = json['hall_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['services'] != null) {
      services = [];
      json['services'].forEach((v) {
        services.add(new Services.fromJson(v));
      });

    }

    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['date'] = this.date;
    data['time'] = this.time;
    data['payment'] = this.payment;
    data['cost'] = this.cost;
    data['total_bonus'] = this.totalBonus;
    data['total_cost'] = this.totalCost;
    data['order_paid'] = this.orderPaid;
    data['status'] = this.status;
    data['hall_id'] = this.hallId;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.services != null) {
      data['services'] = this.services.map((v) => v.toJson()).toList();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}
/*
class Services {
  int id;
  int price;
  String bonus;

  Services({this.id, this.price, this.bonus});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    bonus = json['bonus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['bonus'] = this.bonus;
    return data;
  }
}
class User {
  int id;
  String name;
  String email;
  Null emailVerifiedAt;
  String mobile;
  Null createdAt;
  Null updatedAt;

  User(
      {this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.mobile,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    mobile = json['mobile'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['mobile'] = this.mobile;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}*/

class Services {
  var id;
  var name;
  var details;
  var icon;
  var price;
  var discount;
  var payment;
  var hallId;
  var createdAt;
  var updatedAt;

  Services(
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

  Services.fromJson(Map<String, dynamic> json) {
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

class User {
  var id;
  var name;
  var email;
  var emailVerifiedAt;
  var mobile;
  var createdAt;
  var updatedAt;

  User(
      {this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.mobile,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    mobile = json['mobile'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['mobile'] = this.mobile;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}