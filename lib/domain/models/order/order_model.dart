import 'dart:convert';

Order orderFromJson(String str) => Order.fromMap(json.decode(str));

String orderToJson(Order data) => json.encode(data.toMap());

class Order {
  Order({
    required this.dni,
    required this.fullname,
    required this.address,
    required this.numberPhone,
    required this.email,
    required this.total,
    required this.state,
    required this.dateCreate,
    required this.dateUpdate,
    required this.amountProduct,
  });

  String? id;
  String dni;
  String fullname;
  String address;
  String numberPhone;
  String email;
  String total;
  String state;
  String dateCreate;
  String dateUpdate;
  int amountProduct;

  factory Order.fromMap(Map<String, dynamic> json) => Order(
    dni: json['dni'],
    fullname: json['fullname'],
    address: json['address'],
    numberPhone: json['numberPhone'],
    email: json['email'],
    total: json['total'],
    state: json['state'],
    dateCreate: json['dateCreate'],
    dateUpdate: json['dateUpdate'],
    amountProduct: json['amountProduct'],
  );

  Map<String, dynamic> toMap() => {
    'dni': dni,
    'fullname': fullname,
    'address': address,
    'numberPhone': numberPhone,
    'email': email,
		'total': total,
		'state': state,
		'dateCreate': dateCreate,
		'dateUpdate': dateUpdate,
		'amountProduct': amountProduct,
  };
}
