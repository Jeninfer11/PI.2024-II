import 'package:shopy_file_gp2/src/domain/repository/AuthRepository.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/home/bloc/ClientHomeEvent.dart';

class PagoUseCase {
  AuthRepository repository;

  PagoUseCase(this.repository);
  run(Pago pago) => repository.pago(pago);
}
