import 'package:equatable/equatable.dart';
import 'package:extreme_store/app/use_case/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:extreme_store/app/failure/failure.dart';
import 'package:extreme_store/data/models/time_slot_models/interval_hours_model.dart';

import '../../repositories/base_repository.dart';

class GetIntervalHours implements UseCase<List<IntervalHoursModel>?, GetIntervalHoursParams> {
  final BaseRepository baseRepository;

  GetIntervalHours({
    required this.baseRepository,
  });

  @override
  Future<Either<Failure, List<IntervalHoursModel>?>> call(
    GetIntervalHoursParams params,
  ) async {
    final res = await baseRepository.getIntervalHours(params: params);
    return res.fold(
      (l) => Left(ServerFailure(l.message)),
      (r) => Right(r.intervalHoursDataModel ?? []),
    );
  }
}

class GetIntervalHoursParams extends Equatable {
  final String date;
  const GetIntervalHoursParams({
    required this.date,
  });

  @override
  List<Object?> get props => [date];
}
