import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:extreme_store/data/models/response.dart';
import 'package:extreme_store/data/models/users_model.dart';

import '../../../app/failure/failure.dart';
import '../../../app/use_case/use_case.dart';
import '../../repositories/base_repository.dart';

class EditProfileUseCase implements UseCase<ResponseModel, EditProfileParams> {
  final BaseRepository baseRepository;

  EditProfileUseCase({
    required this.baseRepository,
  });

  @override
  Future<Either<Failure, ResponseModel>> call(
    EditProfileParams params,
  ) async {
    return await baseRepository.editProfile(
 params: params,
    );
  }
}

class EditProfileParams extends Equatable {
  final String token;

  final EditProfileModel usersModel;

  const EditProfileParams({
    required this.token,

    required this.usersModel,
  });

  @override
  List<Object?> get props => [token,  usersModel];
}
