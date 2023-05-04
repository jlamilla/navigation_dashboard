import 'dart:convert';

Product productFromJson(String str) => Product.fromMap(json.decode(str));

String productToJson(Product data) => json.encode(data.toMap());

class Product{
  Product({
    required this.reference,
    required this.pinta,
    required this.pintaDescription,
    required this.name,
    required this.description,
    required this.site,
    required this.state,
    required this.price,
    required this.photoPath,
    required this.photoURL,
    required this.productCreateDate,
    required this.productUpdateDate,
  });

  String? id; // reference - pinta
  String reference;
  String pinta;
  String pintaDescription;
  String name;
  String description;
  String site;
  String state;
  String price;
  String photoPath;
  String photoURL;
  String productCreateDate;
  String productUpdateDate;

  factory Product.fromMap(Map<String, dynamic> json) => Product(
    reference: json["reference"],
    pinta: json["pinta"],
    pintaDescription: json["pintaDescription"],
    name: json["name"],
    description: json["description"],
    site: json["site"],
    state: json["state"],
    price: json["price"],
    photoPath: json["photoPath"],
    photoURL: json["photoURL"],
    productCreateDate: json["productCreateDate"],
    productUpdateDate: json["productUpdateDate"],
  );
  Map<String, dynamic> toMap() => {
    "reference": reference,
    "pinta": pinta,
    "pintaDescription": pintaDescription,
    "name": name,
    "description": description,
    "site": site,
    "state": state,
    "price": price,
    "photoPath": photoPath,
    "photoURL": photoURL,
    "productCreateDate": productCreateDate,
    "productUpdateDate": productUpdateDate,
    };
}

ProductSize productSizeFromJson(String str) => ProductSize.fromMap(json.decode(str));

String productSizeToJson(ProductSize data) => json.encode(data.toMap());

class ProductSize{
  ProductSize({
    required this.size,
    required this.amount,
    required this.state,
    required this.quantityUpdateDate,
  });

  String size;
  int amount;
  String state;
  String quantityUpdateDate;

  factory ProductSize.fromMap(Map<String, dynamic> json) => ProductSize(
    size: json["size"],
    amount: json["amount"],
    state: json["state"],
    quantityUpdateDate: json["quantityUpdateDate"],
  );

  Map<String, dynamic> toMap() => {
    "size": size,
    "amount": amount,
    "state": state,
    "quantityUpdateDate": quantityUpdateDate,
  };
}