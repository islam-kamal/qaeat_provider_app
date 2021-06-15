class CustomerServicesModel{
  final int id;
  final String username;
  final String email;
  final String address;
  final String mobile;
  final String details;
  final int ticket_num;
  final int status;
  final int user_id;
  CustomerServicesModel({this.id, this.username, this.email, this.address, this.mobile, this.details,
    this.ticket_num, this.status,this.user_id});

  factory CustomerServicesModel.fromJson(Map<String,dynamic>json){
    return CustomerServicesModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      address: json['address'],
      mobile: json['mobile'],
      details: json['details'],
      ticket_num: json['ticket_num'],
      status: json['status'],
      user_id: json['user_id'],
    );
  }
}