import 'dart:convert';

OrderDetails orderDetailsFromJson(String str) => OrderDetails.fromMap(json.decode(str));

String orderDetailsToJson(OrderDetails data) => json.encode(data.toMap());

class OrderDetails {
  OrderDetails({
    required this.reference,
    required this.pinta,
    required this.pintaDescription,
    required this.size,
    required this.amount,
    required this.price,
    required this.photoUrl,
  });

  String? id;
  String reference;
  String pinta;
  String pintaDescription;
  String size;
  int amount;
  String price;
  String photoUrl;

  factory OrderDetails.fromMap(Map<String, dynamic> json) => OrderDetails(
    reference: json['reference'],
    pinta: json['pinta'],
    pintaDescription: json['pintaDescription'],
    size: json['size'],
    amount: json['amount'],
    price: json['price'],
    photoUrl: json['photoUrl'],
  );

  Map<String, dynamic> toMap() => {
    'reference': reference,
    'pinta': pinta,
		'pintaDescription': pintaDescription,
    'size': size,
		'amount': amount,
		'price': price,
		'photoUrl': photoUrl,
  };
}
