class OrdersResponse {
  bool status;
  var errNum;
  String msg;
  List<Orders> orders;

  OrdersResponse({this.status, this.errNum, this.msg, this.orders});

  OrdersResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['orders'] != null) {
      orders = new List<Orders>();
      json['orders'].forEach((v) {
        orders.add(new Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.orders != null) {
      data['orders'] = this.orders.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orders {
  int id;
  String title;
  String date;
  String time;
  String address;
  int type;
  int taxPaid;
  int status;
  int userId;
  int categoryId;
  Employee employee;

  Orders(
      {this.id,
        this.title,
        this.date,
        this.time,
        this.address,
        this.type,
        this.taxPaid,
        this.status,
        this.userId,
        this.categoryId,
        this.employee});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    date = json['date'];
    time = json['time'];
    address = json['address'];
    type = json['type'];
    taxPaid = json['tax_paid'];
    status = json['status'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    employee = json['employee'] != null
        ? new Employee.fromJson(json['employee'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['date'] = this.date;
    data['time'] = this.time;
    data['address'] = this.address;
    data['type'] = this.type;
    data['tax_paid'] = this.taxPaid;
    data['status'] = this.status;
    data['user_id'] = this.userId;
    data['category_id'] = this.categoryId;
    if (this.employee != null) {
      data['employee'] = this.employee.toJson();
    }
    return data;
  }
}

class Employee {
  int id;
  String name;

  Employee({this.id, this.name});

  Employee.fromJson(Map<String, dynamic> json) {
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
