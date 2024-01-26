import 'package:equatable/equatable.dart';
import 'package:extreme_store/app/use_case/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:extreme_store/app/failure/failure.dart';
import 'package:extreme_store/data/models/profile.dart';

import '../../repositories/base_repository.dart';

class GetProfileUseCase implements UseCase<ProfilesModel,GetProfileParams> {
  final BaseRepository baseRepository;

  GetProfileUseCase({required this.baseRepository});

  @override
  Future<Either<Failure, ProfilesModel>> call(GetProfileParams params) async {
    return await baseRepository.getProfile(params:params
    );

  }
}

class GetProfileParams extends Equatable {
  final String token;

  const GetProfileParams({
    required this.token,
  });

  @override
  List<Object> get props => [token];
}