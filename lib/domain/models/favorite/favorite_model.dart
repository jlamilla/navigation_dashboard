import 'dart:convert';

Favorite favoriteFromJson(String str) => Favorite.fromMap(json.decode(str));

String favoriteToJson(Favorite data) => json.encode(data.toMap());

class Favorite{

  Favorite({
    required this.reference,
    required this.pinta,
    required this.name,
    required this.price,
    required this.dateCreate,
    required this.photoURL,
  });
  
  String? id;
  final String reference;
  final String pinta;
  final String name;
  final String price;
  final DateTime dateCreate;
  final String? photoURL;

  factory Favorite.fromMap(Map<String, dynamic> json) => Favorite(
        reference: json['reference'],
        name: json['name'],
        pinta: json['pinta'],
        price: json['price'],
        dateCreate: json['dateCreate'],
        photoURL: json['photoURL'],
      );
  Map<String, dynamic> toMap() => {
        'reference':reference ,
        'name':name ,
        'pinta':pinta ,
        'price':price ,
        'dateCreate':dateCreate ,
        'photoURL': photoURL 
      };
    
}