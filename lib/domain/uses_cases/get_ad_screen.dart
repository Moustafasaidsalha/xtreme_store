import 'package:equatable/equatable.dart';
import 'package:extreme_store/app/use_case/use_case.dart';
import 'package:extreme_store/data/models/ad_screen.dart';
import 'package:dartz/dartz.dart';
import 'package:extreme_store/app/failure/failure.dart';

import '../repositories/base_repository.dart';

class GetAdScreenUseCase implements UseCase<AdScreensModel,GetAddScreenParams> {
  final BaseRepository baseRepository;

  GetAdScreenUseCase({
    required this.baseRepository,
  });

  @override
  Future<Either<Failure, AdScreensModel>> call(GetAddScreenParams params

      ) async {
    return await baseRepository.getAdScreen(
        params: params   );
  }
}
class GetAddScreenParams extends Equatable{
  final  int offset;
  final int limit;
  const GetAddScreenParams({
    required this.offset,
    required this.limit,
  });

  @override
  List<Object?> get props => [offset,limit];


}