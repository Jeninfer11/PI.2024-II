import 'package:shopy_file_gp2/src/domain/repository/AuthRepository.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/home/bloc/ClientHomeEvent.dart';

class ServicioUseCase {
  AuthRepository repository;

  ServicioUseCase(this.repository);
  run(Servicio servicio) => repository.servicio(servicio);
}
