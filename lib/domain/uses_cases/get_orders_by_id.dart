import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:extreme_store/app/failure/failure.dart';
import 'package:extreme_store/app/use_case/use_case.dart';
import 'package:extreme_store/data/models/orders.dart';

import '../repositories/base_repository.dart';

class GetOrdersByIdUseCase implements UseCase<OrdersByIdModel,GetOrdersByIdParams>{
  final BaseRepository baseRepository;

  GetOrdersByIdUseCase({required this.baseRepository});

  @override
  Future<Either<Failure, OrdersByIdModel>> call(GetOrdersByIdParams params) async {
    return await baseRepository.getOrdersByID(
        params: params
    );
  }
}

class GetOrdersByIdParams extends Equatable {
  final String token;
  final int id;



  @override
  List<Object> get props => [id, token];

  const GetOrdersByIdParams({
    required this.token,
    required this.id,

  });

}