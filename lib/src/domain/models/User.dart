import 'package:shopy_file_gp2/src/domain/models/Role.dart';

class User {
  int? id;
  String? name;
  String lastname;
  String? email;
  String dni;
  String phone;
  String? password;
  String? image;
  String? notificationToken;
  List<Role>? roles;

  User({
    this.id,
    this.name,
    required this.lastname,
    this.email,
    required this.dni,
    required this.phone,
    this.password,
    this.image,
    this.notificationToken,
    this.roles,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"] ?? 0,
      name: json["name"] ?? '',
      lastname: json["lastname"] ?? 'Sin apellido',
      email: json["email"],
      dni: json["dni"] ?? '00000000',
      phone: json["phone"] ?? '000-000-0000',
      password: json["password"] ?? '',
      image: json["image"],
      notificationToken: json["notification_token"] ?? '',
      roles: json["roles"] != null
          ? List<Role>.from(json["roles"].map((x) => Role.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lastname": lastname,
        "email": email,
        "dni": dni,
        "phone": phone,
        "password": password,
        "image": image,
        "notification_token": notificationToken,
        "roles": roles != null
            ? List<dynamic>.from(roles!.map((x) => x.toJson()))
            : [],
      };
}
