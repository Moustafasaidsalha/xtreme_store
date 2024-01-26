import 'package:extreme_store/app/use_case/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:extreme_store/app/failure/failure.dart';

import '../../data/models/app_theme.dart';
import '../repositories/base_repository.dart';

class GetAppThemeUseCase implements UseCase<AppThemeModel,NoParams> {
  final BaseRepository baseRepository;

  GetAppThemeUseCase({
    required this.baseRepository,
  });

  @override
  Future<Either<Failure, AppThemeModel>> call(NoParams noParams

      ) async {
    return await baseRepository.getAppTheme(
          );
  }
}
