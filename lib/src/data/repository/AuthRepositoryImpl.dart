import 'package:shopy_file_gp2/src/data/dataSource/local/SharePref.dart';
import 'package:shopy_file_gp2/src/data/dataSource/remote/services/AuthServices.dart';
import 'package:shopy_file_gp2/src/domain/models/AuthResponse.dart';
import 'package:shopy_file_gp2/src/domain/models/User.dart';
import 'package:shopy_file_gp2/src/domain/repository/AuthRepository.dart';
import 'package:shopy_file_gp2/src/domain/utils/Resource.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/home/bloc/ClientHomeEvent.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthServices authServices;
  SharedPrefe sharedPrefe;

  AuthRepositoryImpl(this.authServices, this.sharedPrefe);

  @override
  Future<AuthResponse?> getUserSession() async {
    final data = await sharedPrefe.read('user');
    if (data != null) {
      AuthResponse authResponse = AuthResponse.fromJson(data);
      return authResponse;
    }
  }

  @override
  Future<Resource<AuthResponse>> login(String email, String password) {
    return authServices.login(email, password);
  }

  @override
  Future<bool> logout() async {
    return await sharedPrefe.remove('user');
  }

  @override
  Future<Resource<AuthResponse>> register(User user) {
    return authServices.register(user);
  }

  @override
  Future<Resource<AuthResponse>> reserva(Reserva reserva) {
    return authServices.reserva(reserva);
  }

  @override
  Future<void> saveUserSession(AuthResponse authResponse) {
    // TODO: implement saveUserSession
    throw UnimplementedError();
  }
}
