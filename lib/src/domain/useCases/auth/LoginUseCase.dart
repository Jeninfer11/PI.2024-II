import 'package:shopy_file_gp2/src/domain/repository/AuthRepository.dart';

class LoginUseCase {
  AuthRepository repository;
  
  LoginUseCase(this.repository);

  run(String email, String password) => repository.login(email, password);

}