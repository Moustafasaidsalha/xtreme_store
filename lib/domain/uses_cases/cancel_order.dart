import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:extreme_store/app/failure/failure.dart';
import 'package:extreme_store/app/use_case/use_case.dart';
import 'package:extreme_store/data/models/response.dart';

import '../repositories/base_repository.dart';

class CancelOrdersByIdUseCase implements UseCase<ResponseModel,CancelOrdersByIdParams>{
  final BaseRepository baseRepository;

  CancelOrdersByIdUseCase({required this.baseRepository});

  @override
  Future<Either<Failure, ResponseModel>> call(CancelOrdersByIdParams params) async {
    return await baseRepository.cancelOrdersByID(
        params: params
    );
  }
}

class CancelOrdersByIdParams extends Equatable {
  final int id;



  @override
  List<Object> get props => [id];

  const CancelOrdersByIdParams({
    required this.id,

  });

}