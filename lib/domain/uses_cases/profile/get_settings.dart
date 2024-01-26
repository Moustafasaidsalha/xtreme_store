import 'package:extreme_store/app/use_case/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:extreme_store/app/failure/failure.dart';
import 'package:extreme_store/data/models/setting.dart';

import '../../repositories/base_repository.dart';

class GetSettingsUseCase implements UseCase<SettingsModel,NoParams> {
  final BaseRepository baseRepository;

  GetSettingsUseCase({required this.baseRepository});

  @override
  Future<Either<Failure, SettingsModel>> call(NoParams noParams) async {
    return await baseRepository.getSettings(
    );
  }
}

