import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:extreme_store/app/failure/failure.dart';
import 'package:extreme_store/app/use_case/use_case.dart';
import 'package:extreme_store/data/models/orders.dart';

import '../repositories/base_repository.dart';

class GetOrdersUseCase implements UseCase<OrdersModel,GetOrdersParams>{
  final BaseRepository baseRepository;

  GetOrdersUseCase({required this.baseRepository});

  @override
  Future<Either<Failure, OrdersModel>> call(GetOrdersParams params) async {
    return await baseRepository.getOrders(
        params: params
    );
  }
}

class GetOrdersParams extends Equatable {
  final int offset;
  final int limit;
final String token;


  @override
  List<Object> get props => [offset, limit,token];

  const GetOrdersParams({
    required this.offset,
    required this.limit,
    required this.token,

  });

}