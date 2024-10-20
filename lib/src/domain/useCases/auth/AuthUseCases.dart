import 'package:shopy_file_gp2/src/domain/useCases/SaveUserSessionUseCase.dart';
import 'package:shopy_file_gp2/src/domain/useCases/auth/GetUserSessionUseCase.dart';
import 'package:shopy_file_gp2/src/domain/useCases/auth/LoginUseCase.dart';
import 'package:shopy_file_gp2/src/domain/useCases/auth/LogoutUseCase.dart';
import 'package:shopy_file_gp2/src/domain/useCases/auth/RegisterUseCase.dart';
import 'package:shopy_file_gp2/src/domain/useCases/reserva/ReservaUseCase.dart';

class AuthUseCases {
  LoginUseCase login;
  RegisterUseCase register;
  GetUserSessionUseCase getUserSession;
  SaveUserSessionUseCase saveUserSession;
  LogoutUseCase logout;
  ReservaUseCase reserva;

  AuthUseCases({
    required this.login,
    required this.register,
    required this.getUserSession,
    required this.saveUserSession,
    required this.logout,
    required this.reserva,
  });
}
