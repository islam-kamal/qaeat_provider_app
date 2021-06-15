/*
class HomePageResponse {
  bool status;
  String errNum;
  String msg;
  List<Salon> salon;

  HomePageResponse({this.status, this.errNum, this.msg, this.salon});

  HomePageResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['salons'] != null) {
      salon = new List<Salon>();
      json['salons'].forEach((v) {
        salon.add(new Salon.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.salon != null) {
      data['salon'] = this.salon.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Salon {
  int id;
  String name;
  int appTotalRevenue;
  int salonTotalRevenue;
  List<Order> order;
  List<Rate> rate;
  List<Employees> employees;

  Salon(
      {this.id,
        this.name,
        this.appTotalRevenue,
        this.salonTotalRevenue,
        this.order,
        this.rate,
        this.employees});

  Salon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    appTotalRevenue = json['AppTotalRevenue'];
    salonTotalRevenue = json['SalonTotalRevenue'];
    if (json['order'] != null) {
      order = new List<Order>();
      json['order'].forEach((v) {
        order.add(new Order.fromJson(v));
      });
    }
    if (json['rate'] != null) {
      rate = new List<Rate>();
      json['rate'].forEach((v) {
        rate.add(new Rate.fromJson(v));
      });
    }
    if (json['employees'] != null) {
      employees = new List<Employees>();
      json['employees'].forEach((v) {
        employees.add(new Employees.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['AppTotalRevenue'] = this.appTotalRevenue;
    data['SalonTotalRevenue'] = this.salonTotalRevenue;
    if (this.order != null) {
      data['order'] = this.order.map((v) => v.toJson()).toList();
    }
    if (this.rate != null) {
      data['rate'] = this.rate.map((v) => v.toJson()).toList();
    }
    if (this.employees != null) {
      data['employees'] = this.employees.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Order {
  int id;
  int status;
  String date;
  String time;
  int userId;
  int salonId;
  User user;

  Order(
      {this.id,
        this.status,
        this.date,
        this.time,
        this.userId,
        this.salonId,
        this.user});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    date = json['date'];
    time = json['time'];
    userId = json['user_id'];
    salonId = json['salon_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['date'] = this.date;
    data['time'] = this.time;
    data['user_id'] = this.userId;
    data['salon_id'] = this.salonId;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
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

class Rate {
  int id;
  int value;
  String comment;
  int userId;
  int salonId;
  User user;

  Rate(
      {this.id,
        this.value,
        this.comment,
        this.userId,
        this.salonId,
        this.user});

  Rate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    comment = json['comment'];
    userId = json['user_id'];
    salonId = json['salon_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['value'] = this.value;
    data['comment'] = this.comment;
    data['user_id'] = this.userId;
    data['salon_id'] = this.salonId;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class Employees {
  int id;
  String name;
  int salonId;
  List<EmployeeRate> employeeRate;

  Employees({this.id, this.name, this.salonId, this.employeeRate});

  Employees.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    salonId = json['salon_id'];
    if (json['employee_rate'] != null) {
      employeeRate = new List<EmployeeRate>();
      json['employee_rate'].forEach((v) {
        employeeRate.add(new EmployeeRate.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['salon_id'] = this.salonId;
    if (this.employeeRate != null) {
      data['employee_rate'] = this.employeeRate.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EmployeeRate {
  int id;
  int value;
  String comment;
  int employeeId;
  int userId;
  User user;

  EmployeeRate(
      {this.id,
        this.value,
        this.comment,
        this.employeeId,
        this.userId,
        this.user});

  EmployeeRate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    comment = json['comment'];
    employeeId = json['employee_id'];
    userId = json['user_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['value'] = this.value;
    data['comment'] = this.comment;
    data['employee_id'] = this.employeeId;
    data['user_id'] = this.userId;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}
*/


class HomePageResponse {
  bool status;
  String errNum;
  String msg;
  List<Hall> hall;

  HomePageResponse({this.status, this.errNum, this.msg, this.hall});

  HomePageResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['hall'] != null) {
      hall = new List<Hall>();
      json['hall'].forEach((v) {
        hall.add(new Hall.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.hall != null) {
      data['hall'] = this.hall.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Hall {
  int id;
  String name;
  int appTotalRevenue;
  int hallTotalRevenue;
  List<Order> order;
  List<Rates> rates;

  Hall(
      {this.id,
        this.name,
        this.appTotalRevenue,
        this.hallTotalRevenue,
        this.order,
        this.rates});

  Hall.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    appTotalRevenue = json['AppTotalRevenue'];
    hallTotalRevenue = json['hallTotalRevenue'];
    if (json['order'] != null) {
      order = new List<Order>();
      json['order'].forEach((v) {
        order.add(new Order.fromJson(v));
      });
    }
    if (json['rates'] != null) {
      rates = new List<Rates>();
      json['rates'].forEach((v) {
        rates.add(new Rates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['AppTotalRevenue'] = this.appTotalRevenue;
    data['hallTotalRevenue'] = this.hallTotalRevenue;
    if (this.order != null) {
      data['order'] = this.order.map((v) => v.toJson()).toList();
    }
    if (this.rates != null) {
      data['rates'] = this.rates.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Order {
  int id;
  int status;
  String date;
  String time;
  int userId;
  int hallId;
  User user;

  Order(
      {this.id,
        this.status,
        this.date,
        this.time,
        this.userId,
        this.hallId,
        this.user});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    date = json['date'];
    time = json['time'];
    userId = json['user_id'];
    hallId = json['hall_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['date'] = this.date;
    data['time'] = this.time;
    data['user_id'] = this.userId;
    data['hall_id'] = this.hallId;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
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

class Rates {
  int id;
  int value;
  String comment;
  int userId;
  int hallId;
  User user;

  Rates(
      {this.id, this.value, this.comment, this.userId, this.hallId, this.user});

  Rates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    comment = json['comment'];
    userId = json['user_id'];
    hallId = json['hall_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['value'] = this.value;
    data['comment'] = this.comment;
    data['user_id'] = this.userId;
    data['hall_id'] = this.hallId;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}