import 'package:extreme_store/app/use_case/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:extreme_store/app/failure/failure.dart';
import 'package:extreme_store/data/models/time_slot_models/blocked_dates_model.dart';

import '../../repositories/base_repository.dart';

class GetBlockDates implements UseCase<BlockDatesResponseModel, NoParams> {
  final BaseRepository baseRepository;

  GetBlockDates({
    required this.baseRepository,
  });

  @override
  Future<Either<Failure, BlockDatesResponseModel>> call(
    NoParams params,
  ) async {
    return await baseRepository.getBlockData();
  }
}
