import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:extreme_store/app/failure/failure.dart';
import 'package:extreme_store/app/use_case/use_case.dart';
import 'package:extreme_store/data/models/area_model.dart';

import '../../repositories/base_repository.dart';

class GetArea implements UseCase<List<AreaModel>, GetAreaParams> {
  final BaseRepository baseRepository;

  GetArea({
    required this.baseRepository,
  });

  @override
  Future<Either<Failure, List<AreaModel>>> call(GetAreaParams params) async {
    return await baseRepository.getArea(countryID: params.countryID);
  }
}

class GetAreaParams extends Equatable {
  final int countryID;

  const GetAreaParams({required this.countryID});

  @override
  List<Object?> get props => [countryID];
}
