import 'package:shopy_file_gp2/src/domain/repository/AuthRepository.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/home/bloc/ClientHomeEvent.dart';

class ReservaUseCase {
  AuthRepository repository;

  ReservaUseCase(this.repository);
  run(Reserva reserva) => repository.reserva(reserva);
}
