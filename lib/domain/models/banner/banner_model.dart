import 'dart:convert';

Banner bannerFromJson(String str) => Banner.fromMap(json.decode(str));

String bannerToJson(Banner data) => json.encode(data.toMap());

class Banner {
  Banner({
    required this.dni,
    required this.email,
    required this.dateCreate,
    required this.dateUpdate,
    this.photoPath,
    this.photoURL,
  });
  String? id;
  final String dni;
	final String email;
	final DateTime dateCreate;
	final DateTime dateUpdate;
	final String? photoPath;
	final String? photoURL;

  factory Banner.fromMap(Map<String, dynamic> json) => Banner(
    dni: json['dni'],
    email: json['email'],
    dateCreate: json['dateCreate'],
    dateUpdate: json['dateUpdate'],
    photoPath: json['photoPath'],
    photoURL: json['photoURL'],
  );
  Map<String, dynamic> toMap() => {
    'dni':dni ,
    'email':email ,
    'dateCreate':dateCreate ,
    'dateUpdate':dateUpdate ,
    'photoPath': photoPath ,
    'photoURL': photoURL 
  };
}
