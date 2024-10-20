import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shopy_file_gp2/src/domain/models/User.dart';
import 'package:shopy_file_gp2/src/domain/utils/Resource.dart';
import 'package:shopy_file_gp2/src/presentation/utils/BlocFormItem.dart';

class RegisterState extends Equatable {
  final BlocFormItem name;
  final BlocFormItem lastname;
  final BlocFormItem email;
  final BlocFormItem dni;
  final BlocFormItem phone;
  final BlocFormItem password;
  final BlocFormItem confirmpassword;
  final Resource? response;

  final GlobalKey<FormState>? formKey;

  const RegisterState(
      {this.name = const BlocFormItem(error: 'Ingrese su name'),
      this.lastname = const BlocFormItem(error: 'Ingrese su lastname'),
      this.email = const BlocFormItem(error: 'Ingrese su  email'),
      this.dni = const BlocFormItem(error: 'Ingrese dni'),
      this.phone = const BlocFormItem(error: 'Ingrese telefono'),
      this.password = const BlocFormItem(error: 'Ingrese su password'),
      this.confirmpassword =
          const BlocFormItem(error: 'Ingrese la confirmacion password'),
      this.formKey,
      this.response});

  toUser() => User(
      name: name.value,
      lastname: lastname.value,
      email: email.value,
      dni: dni.value,
      phone: phone.value,
      password: password.value);

  RegisterState copyWith(
      {BlocFormItem? name,
      lastname,
      email,
      dni,
      phone,
      password,
      confirmpasword,
      Resource? response,
      GlobalKey<FormState>? formKey}) {
    return RegisterState(
        name: name ?? this.name,
        lastname: lastname ?? this.lastname,
        email: email ?? this.email,
        dni: dni ?? this.dni,
        phone: phone ?? this.phone,
        password: password ?? this.password,
        confirmpassword: confirmpasword ?? this.confirmpassword,
        formKey: formKey,
        response: response);
  }

  @override
  List<Object?> get props => [name,
        lastname,
        email,
        dni,
        phone,
        password,
        confirmpassword,
        response,];
}
