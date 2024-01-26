import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:extreme_store/app/failure/failure.dart';
import 'package:extreme_store/app/use_case/use_case.dart';
import 'package:extreme_store/data/models/response.dart';
import 'package:extreme_store/data/models/wishlist.dart';
import 'package:extreme_store/domain/repositories/base_repository.dart';

class NotifyMeUseCase
    implements UseCase<ResponseModel, NotifyMeParams> {
  final BaseRepository baseRepository;

  NotifyMeUseCase({
    required this.baseRepository,
  });

  @override
  Future<Either<Failure, ResponseModel>> call(NotifyMeParams params) async {
    return await baseRepository.notifyMe(
        params: params);
  }
}

class NotifyMeParams extends Equatable {
  final ProductIdModel productID;
  final String token;

  @override
  List<Object?> get props => [id, token];

  const NotifyMeParams({
    required this.productID,
    required this.token,
  });
}