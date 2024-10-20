import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopy_file_gp2/src/presentation/pages/auth/login/bloc/LoginBloc.dart';
import 'package:shopy_file_gp2/src/presentation/pages/auth/login/bloc/LoginEvent.dart';
import 'package:shopy_file_gp2/src/presentation/pages/auth/login/bloc/LoginState.dart';
import 'package:shopy_file_gp2/src/presentation/utils/BlocFormItem.dart';
import 'package:shopy_file_gp2/src/presentation/widget/DefaultTextField.dart';

class LoginContent extends StatelessWidget {
  LoginBloc? bloc;
  LoginState state;

  LoginContent(this.bloc, this.state);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: state.formKey,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _imageBackground(context),
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            height: MediaQuery.of(context).size.height * 0.80,
            decoration: BoxDecoration(
              color: Color.fromRGBO(232, 214, 183, 0.294),
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
            child: Column(
              children: [
                _iconPerson(),
                _textLogin(),
                _TextFieldEmail(),
                _TextFieldPassword(),
                _buttonLogin(context),
                _buttonRegister(context),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _imageBackground(BuildContext context) {
    return Image.asset(
      'assets/img/Purma Wasi Tambo1.png',
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      fit: BoxFit.cover,
      color: const Color.fromARGB(133, 241, 229, 187),
      colorBlendMode: BlendMode.darken,
    );
  }

  Widget _iconPerson() {
    return Icon(
      Icons.person,
      color: const Color.fromARGB(255, 242, 242, 238),
      size: 125,
    );
  }

  Widget _textLogin() {
    return Text(
      'LOGIN',
      style: TextStyle(
          color: const Color.fromARGB(255, 239, 234, 234), fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

Widget _TextFieldEmail() {
  return Container(
    margin: EdgeInsets.only(left: 25, right: 25),
    child: DefaultTextField(
      label: 'email',
      icon: Icons.email,
      iconColor: Colors.black, // Asegúrate de que esta propiedad esté implementada
       labelStyle: TextStyle(color: Colors.black), // Cambiar el color del texto a negro
      onChange: (text) {
        bloc?.add(EmailChanged(email: BlocFormItem(value: text)));
      },
      validator: (value) {
        return state.password.error;
      },
    ),
  );
}


 Widget _TextFieldPassword() {
  return Container(
    margin: EdgeInsets.only(left: 25, right: 25),
    child: DefaultTextField(
      label: 'Password',
      icon: Icons.lock,
      iconColor: Colors.black, // Cambiar el color del ícono a negro
      labelStyle: TextStyle(color: Colors.black), // Cambiar el color del texto a negro
      obscureText: true, // Ocultar el texto para contraseñas
      onChange: (text) {
        bloc?.add(PasswordChanged(password: BlocFormItem(value: text)));
      },
      validator: (value) {
        return state.password.error;
      },
    ),
  );
}


  Widget _buttonLogin(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 15),
      child: ElevatedButton(
          onPressed: () {
            if (state.formKey!.currentState!.validate()) {
              bloc?.add(LoginSubmit());
            } else {
              Fluttertoast.showToast(
                  msg: 'El formulario no es valido',
                  toastLength: Toast.LENGTH_LONG);
            }
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 181, 95, 24)),
          child: Text(
            'Iniciar Sesion',
            style: TextStyle(color: Colors.white),
          )),
    );
  }

  Widget _buttonRegister(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 15),
      child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, 'register');
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 181, 95, 24)),
          child: Text(
            'Registrese',
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}
