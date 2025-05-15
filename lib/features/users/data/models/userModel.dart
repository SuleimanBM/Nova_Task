// data/models/user_model.dart
import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({required String name, required String email, required String password})
      : super(name: name, email: email, password: password);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['id'],
      email: json['email'],
      password: json['password']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
