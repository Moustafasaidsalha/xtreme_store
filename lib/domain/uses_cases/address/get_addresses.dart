import 'package:dartz/dartz.dart';
import 'package:extreme_store/app/failure/failure.dart';
import 'package:extreme_store/app/use_case/use_case.dart';
import 'package:extreme_store/data/models/addresses_response_model.dart';

import '../../repositories/base_repository.dart';

class GetAddressesUseCase implements UseCase<List<AddressModel>, NoParams> {
  final BaseRepository baseRepository;

  GetAddressesUseCase({
    required this.baseRepository,
  });

  @override
  Future<Either<Failure, List<AddressModel>>> call(NoParams noParams) async {
    return await baseRepository.getAddresses();
  }
}
