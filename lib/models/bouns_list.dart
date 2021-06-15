/*
class BounsListResponse {
  bool status;
  String errNum;
  String msg;
  List<Bouns> bouns;

  BounsListResponse({this.status, this.errNum, this.msg, this.bouns});

  BounsListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['bouns'] != null) {
      bouns = new List<Bouns>();
      json['bouns'].forEach((v) {
        bouns.add(new Bouns.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.bouns != null) {
      data['bouns'] = this.bouns.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Bouns {
  String title;
  int id;
  String date;
  String time;
  int payment;
  int taxPaid;
  List<Services> services;
  User user;

  Bouns(
      {this.title,
        this.id,
        this.date,
        this.time,
        this.payment,
        this.taxPaid,
        this.services,
        this.user});

  Bouns.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    id = json['id'];
    date = json['date'];
    time = json['time'];
    payment = json['payment'];
    taxPaid = json['tax_paid'];
    if (json['services'] != null) {
      services = new List<Services>();
      json['services'].forEach((v) {
        services.add(new Services.fromJson(v));
      });
    }
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['id'] = this.id;
    data['date'] = this.date;
    data['time'] = this.time;
    data['payment'] = this.payment;
    data['tax_paid'] = this.taxPaid;
    if (this.services != null) {
      data['services'] = this.services.map((v) => v.toJson()).toList();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

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

  User({this.id, this.name});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
*/


class BounsListResponse {
  bool status;
  String errNum;
  String msg;
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
  int appTotalRevenue;
  int hallsTotalRevenue;
  int appThisDayRevenue;
  int hallThisDayRevenue;
  int appThisMonthRevenue;
  int hallThisMonthRevenue;
  int ordersNumbers;
  int orderMonthlyNumber;
  int orderDailyNumber;
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
  int id;
  String title;
  String date;
  String time;
  int payment;
  int cost;
  int totalBonus;
  int totalCost;
  String orderPaid;
  int status;
  int hallId;
  int userId;
  String createdAt;
  String updatedAt;
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
      services = new List<Null>();
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
}