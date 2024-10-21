import 'package:injectable/injectable.dart';
import 'package:shopy_file_gp2/src/data/dataSource/local/SharePref.dart';
import 'package:shopy_file_gp2/src/data/dataSource/remote/services/AuthServices.dart';
import 'package:shopy_file_gp2/src/data/repository/AuthRepositoryImpl.dart';
import 'package:shopy_file_gp2/src/domain/repository/AuthRepository.dart';
import 'package:shopy_file_gp2/src/domain/useCases/SaveUserSessionUseCase.dart';
import 'package:shopy_file_gp2/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:shopy_file_gp2/src/domain/useCases/auth/GetUserSessionUseCase.dart';
import 'package:shopy_file_gp2/src/domain/useCases/auth/LoginUseCase.dart';
import 'package:shopy_file_gp2/src/domain/useCases/auth/LogoutUseCase.dart';
import 'package:shopy_file_gp2/src/domain/useCases/auth/RegisterUseCase.dart';
import 'package:shopy_file_gp2/src/domain/useCases/reserva/ReservaUseCase.dart';
import 'package:shopy_file_gp2/src/domain/useCases/servicio/ServicioUseCase.dart';

@module
abstract class AppModule {
  @injectable
  SharedPrefe get sharedPrefe => SharedPrefe();
//services
  @injectable
  AuthServices get authServices => AuthServices();

//repository
  @injectable
  AuthRepository get authRepository =>
      AuthRepositoryImpl(authServices, sharedPrefe);

//Use Cases
  @injectable
  AuthUseCases get authUseCases => AuthUseCases(
        login: LoginUseCase(authRepository),
        register: RegisterUseCase(authRepository),
        getUserSession: GetUserSessionUseCase(authRepository),
        saveUserSession: SaveUserSessionUseCase(authRepository),
        logout: LogoutUseCase(authRepository),
        reserva: ReservaUseCase(authRepository),
        servicio: ServicioUseCase(authRepository),
      );
}
