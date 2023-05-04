import 'dart:convert';

User userFromJson(String str) => User.fromMap(json.decode(str));

String userToJson(User data) => json.encode(data.toMap());

class User {
  User({
    required this.dni,
    required this.name,
    required this.lastname,
    required this.dataTreatment,
    required this.landline,
    required this.phone,
    required this.email,
    required this.department,
    required this.city,
    required this.address,
    required this.rol,
    required this.state,
    required this.dateCreate,
    required this.dateUpdate,
    required this.photoPath,
    required this.photoURL,
  });
  String? id;
  String dni;
  String name;
	String lastname;
	bool dataTreatment;
	String landline;
	String phone;
	String email;
	String department;
	String city;
	String address;
	String rol;
	String state;
	String dateCreate;
	String dateUpdate;
	String photoPath;
	String photoURL;

  factory User.fromMap(Map<String, dynamic> json) => User(
    dni: json['dni'],
    name: json['name'],
    lastname: json['lastname'],
    dataTreatment: json['dataTreatment'],
    landline: json['landline'],
    phone: json['phone'],
    email: json['email'],
    department: json['department'],
    city: json['city'],
    address: json['address'],
    rol: json['rol'],
    state: json['state'],
    dateCreate: json['dateCreate'],
    dateUpdate: json['dateUpdate'],
    photoPath: json['photoPath'],
    photoURL: json['photoURL'],
  );
  Map<String, dynamic> toMap() => {
    'dni':dni ,
    'name':name ,
    'lastname':lastname ,
    'dataTreatment':dataTreatment ,
    'landline':landline ,
    'phone':phone ,
    'email':email ,
    'department':department ,
    'city':city ,
    'address':address ,
    'rol':rol,
    'state':state ,
    'dateCreate':dateCreate ,
    'dateUpdate':dateUpdate ,
    'photoPath': photoPath ,
    'photoURL': photoURL 
  };
}
