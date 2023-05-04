import 'dart:convert';

Cart cartFromJson(String str) => Cart.fromMap(json.decode(str));

String cartToJson(Cart data) => json.encode(data.toMap());

class Cart {
  Cart({
    required this.reference,
    required this.pinta,
    required this.pintaDescription,
    required this.price,
    required this.size,
    required this.amount,
    required this.photoURL,
    required this.cartItemCreateDate,
    required this.cartItemUpdateDate,
  });

  
  String? id; 
  String reference;
  String pinta;
  String pintaDescription;
  String price;
  String size;
  int amount;
  String photoURL;
  DateTime cartItemCreateDate;
  DateTime cartItemUpdateDate;

  factory Cart.fromMap(Map<String, dynamic> json) => Cart(
    reference: json['reference'],
    pinta: json['pinta'],
    pintaDescription: json['pintaDescription'],
    price: json['price'],
    size: json['size'],
    amount: json['amount'],
    photoURL: json['photoURL'],
    cartItemCreateDate: json['cartItemCreateDate'],
    cartItemUpdateDate: json['cartItemUpdateDate'],
  );
    
  Map<String, dynamic> toMap() => {
    'reference': reference,
    'pinta': pinta,
    'pintaDescription': pintaDescription,
    'price': price,
    'size': size,
    'amount': amount,
    'photoURL': photoURL,
    'cartItemCreateDate': cartItemCreateDate,
    'cartItemUpdateDate': cartItemUpdateDate,
  };
}
