/*
class SalonResponse {
  bool status;
  var errNum;
  var msg;
  Salon salon;

  SalonResponse({this.status, this.errNum, this.msg, this.salon});

  SalonResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    salon = json['salon'] != null ? new Salon.fromJson(json['salon']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.salon != null) {
      data['salon'] = this.salon.toJson();
    }
    return data;
  }
}

class Salon {
  var id;
  var name;
  var username;
  var email;
  var homeService;
  var payment;
  var latitude;
  var longitude;
  var booking;
  var logo;
  var tax;
  var address;
  var cityId;
  var createdAt;
  var updatedAt;
  City city;
  List<Categories> categories;
  List<Services> services;
  List<Employees> employees;
  TotalRate totalRate;
  List<Rate> rate;
  List<Gallery> gallery;

  Salon(
      {this.id,
        this.name,
        this.username,
        this.email,
        this.homeService,
        this.payment,
        this.latitude,
        this.longitude,
        this.booking,
        this.logo,
        this.tax,
        this.address,
        this.cityId,
        this.createdAt,
        this.updatedAt,
        this.city,
        this.categories,
        this.services,
        this.employees,
        this.totalRate,
        this.rate,
        this.gallery});

  Salon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    homeService = json['home_service'];
    payment = json['payment'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    booking = json['booking'];
    logo = json['logo'];
    tax = json['tax'];
    address = json['address'];
    cityId = json['city_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    if (json['categories'] != null) {
      categories = new List<Categories>();
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
    if (json['services'] != null) {
      services = new List<Services>();
      json['services'].forEach((v) {
        services.add(new Services.fromJson(v));
      });
    }
    if (json['employees'] != null) {
      employees = new List<Employees>();
      json['employees'].forEach((v) {
        employees.add(new Employees.fromJson(v));
      });
    }
    totalRate = json['total_rate'] != null
        ? new TotalRate.fromJson(json['total_rate'])
        : null;
    if (json['rate'] != null) {
      rate = new List<Rate>();
      json['rate'].forEach((v) {
        rate.add(new Rate.fromJson(v));
      });
    }
    if (json['gallery'] != null) {
      gallery = new List<Gallery>();
      json['gallery'].forEach((v) {
        gallery.add(new Gallery.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['home_service'] = this.homeService;
    data['payment'] = this.payment;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['booking'] = this.booking;
    data['logo'] = this.logo;
    data['tax'] = this.tax;
    data['address'] = this.address;
    data['city_id'] = this.cityId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.city != null) {
      data['city'] = this.city.toJson();
    }
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    if (this.services != null) {
      data['services'] = this.services.map((v) => v.toJson()).toList();
    }
    if (this.employees != null) {
      data['employees'] = this.employees.map((v) => v.toJson()).toList();
    }
    if (this.totalRate != null) {
      data['total_rate'] = this.totalRate.toJson();
    }
    if (this.rate != null) {
      data['rate'] = this.rate.map((v) => v.toJson()).toList();
    }
    if (this.gallery != null) {
      data['gallery'] = this.gallery.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class City {
  int id;
  String name;

  City({this.id, this.name});

  City.fromJson(Map<String, dynamic> json) {
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

class Categories {
  int id;
  String name;
  String icon;
  String details;
  String createdAt;
  String updatedAt;
  Pivot pivot;

  Categories(
      {this.id,
        this.name,
        this.icon,
        this.details,
        this.createdAt,
        this.updatedAt,
        this.pivot});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    details = json['details'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['details'] = this.details;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot.toJson();
    }
    return data;
  }
}

class Pivot {
  int salonId;
  int categoryId;

  Pivot({this.salonId, this.categoryId});

  Pivot.fromJson(Map<String, dynamic> json) {
    salonId = json['salon_id'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['salon_id'] = this.salonId;
    data['category_id'] = this.categoryId;
    return data;
  }
}

class Services {
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
  String createdAt;
  String updatedAt;

  Services(
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

  Services.fromJson(Map<String, dynamic> json) {
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

class Employees {
  int id;
  String name;
  String nationality;
  String mobile;
  String timeFrom;
  String timeTo;
  int salonId;
  int serviceId;
  Null createdAt;
  String updatedAt;

  Employees(
      {this.id,
        this.name,
        this.nationality,
        this.mobile,
        this.timeFrom,
        this.timeTo,
        this.salonId,
        this.serviceId,
        this.createdAt,
        this.updatedAt});

  Employees.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nationality = json['nationality'];
    mobile = json['mobile'];
    timeFrom = json['time_from'];
    timeTo = json['time_to'];
    salonId = json['salon_id'];
    serviceId = json['service_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class TotalRate {
  int id;
  int value;
  int salonId;
  String createdAt;
  String updatedAt;

  TotalRate(
      {this.id, this.value, this.salonId, this.createdAt, this.updatedAt});

  TotalRate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    salonId = json['salon_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['value'] = this.value;
    data['salon_id'] = this.salonId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Rate {
  int id;
  int value;
  String comment;
  int salonId;
  int userId;
  String createdAt;
  String updatedAt;
  User user;

  Rate(
      {this.id,
        this.value,
        this.comment,
        this.salonId,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.user});

  Rate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    comment = json['comment'];
    salonId = json['salon_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['value'] = this.value;
    data['comment'] = this.comment;
    data['salon_id'] = this.salonId;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  int id;
  String name;
  String email;
  Null emailVerifiedAt;
  String mobile;
  String createdAt;
  String updatedAt;

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

class Gallery {
  int id;
  int salonId;
  String photo;
  String createdAt;
  String updatedAt;

  Gallery({this.id, this.salonId, this.photo, this.createdAt, this.updatedAt});

  Gallery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    salonId = json['salon_id'];
    photo = json['photo'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['salon_id'] = this.salonId;
    data['photo'] = this.photo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
*/


class SalonResponse {
  var status;
  var errNum;
  var msg;
  Salon salon;

  SalonResponse({this.status, this.errNum, this.msg, this.salon});

  SalonResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    salon = json['salon'] != null ? new Salon.fromJson(json['salon']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.salon != null) {
      data['salon'] = this.salon.toJson();
    }
    return data;
  }
}

class Salon {
  var id;
  var name;
  var username;
  var email;
  var payment;
  var latitude;
  var longitude;
  var logo;
  var tax;
  var appCommission;
  var address;
  var cityId;
  var categoryId;
  var hallMaxNumber;
  var createdAt;
  var updatedAt;
  City city;
  List<Services> services;
  TotalRate totalRate;
  List<Rates> rates;
  List<Gallery> gallery;

  Salon(
      {this.id,
        this.name,
        this.username,
        this.email,
        this.payment,
        this.latitude,
        this.longitude,
        this.logo,
        this.tax,
        this.appCommission,
        this.address,
        this.cityId,
        this.categoryId,
        this.hallMaxNumber,
        this.createdAt,
        this.updatedAt,
        this.city,
        this.services,
        this.totalRate,
        this.rates,
        this.gallery});

  Salon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    payment = json['payment'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    logo = json['logo'];
    tax = json['tax'];
    appCommission = json['app_commission'];
    address = json['address'];
    cityId = json['city_id'];
    categoryId = json['category_id'];
    hallMaxNumber = json['hall_max_number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    if (json['services'] != null) {
      services = new List<Services>();
      json['services'].forEach((v) {
        services.add(new Services.fromJson(v));
      });
    }
    totalRate = json['total_rate'] != null
        ? new TotalRate.fromJson(json['total_rate'])
        : null;
    if (json['rates'] != null) {
      rates = new List<Rates>();
      json['rates'].forEach((v) {
        rates.add(new Rates.fromJson(v));
      });
    }
    if (json['gallery'] != null) {
      gallery = new List<Gallery>();
      json['gallery'].forEach((v) {
        gallery.add(new Gallery.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['payment'] = this.payment;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['logo'] = this.logo;
    data['tax'] = this.tax;
    data['app_commission'] = this.appCommission;
    data['address'] = this.address;
    data['city_id'] = this.cityId;
    data['category_id'] = this.categoryId;
    data['hall_max_number'] = this.hallMaxNumber;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.city != null) {
      data['city'] = this.city.toJson();
    }
    if (this.services != null) {
      data['services'] = this.services.map((v) => v.toJson()).toList();
    }
    if (this.totalRate != null) {
      data['total_rate'] = this.totalRate.toJson();
    }
    if (this.rates != null) {
      data['rates'] = this.rates.map((v) => v.toJson()).toList();
    }
    if (this.gallery != null) {
      data['gallery'] = this.gallery.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class City {
  var id;
  var name;

  City({this.id, this.name});

  City.fromJson(Map<String, dynamic> json) {
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

class TotalRate {
  var id;
  var value;
  var hallId;
  var createdAt;
  var updatedAt;

  TotalRate({this.id, this.value, this.hallId, this.createdAt, this.updatedAt});

  TotalRate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    hallId = json['hall_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['value'] = this.value;
    data['hall_id'] = this.hallId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Rates {
  var id;
  var value;
  var comment;
  var hallId;
  var userId;
  var createdAt;
  var updatedAt;
  User user;

  Rates(
      {this.id,
        this.value,
        this.comment,
        this.hallId,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.user});

  Rates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    comment = json['comment'];
    hallId = json['hall_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['value'] = this.value;
    data['comment'] = this.comment;
    data['hall_id'] = this.hallId;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
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

class Gallery {
  var id;
  var hallId;
  var photo;
  var createdAt;
  var updatedAt;

  Gallery({this.id, this.hallId, this.photo, this.createdAt, this.updatedAt});

  Gallery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hallId = json['hall_id'];
    photo = json['photo'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hall_id'] = this.hallId;
    data['photo'] = this.photo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}