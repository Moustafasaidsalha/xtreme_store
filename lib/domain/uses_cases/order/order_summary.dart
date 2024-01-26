import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../app/failure/failure.dart';
import '../../../app/use_case/use_case.dart';
import '../../../data/models/order/order_summary.dart';
import '../../repositories/base_repository.dart';

class OrderSummary implements UseCase<OrderSummaryModel, OrderSummaryParams> {
  final BaseRepository baseRepository;

  OrderSummary({required this.baseRepository});

  @override
  Future<Either<Failure, OrderSummaryModel>> call(OrderSummaryParams params) async {
    final res = await baseRepository.getOrderSummary(
      cartId: params.cartID,
      paymentMethod: params.paymentMethod,
      isDigital: params.isDigital,
      userAddressId: params.addressID,
    );
    return res.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}

class OrderSummaryParams extends Equatable {
  final String paymentMethod;
  final int cartID;
  final int? addressID;
  final bool? isDigital;

  const OrderSummaryParams({
    required this.paymentMethod,
    required this.cartID,
    this.addressID,
    this.isDigital,
  });

  @override
  List<Object?> get props => [cartID, paymentMethod, addressID, isDigital];
}
