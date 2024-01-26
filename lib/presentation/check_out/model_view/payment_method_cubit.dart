import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:extreme_store/app/enums/state_status.dart';
import 'package:extreme_store/app/failure/failure.dart';
import 'package:extreme_store/data/models/order/add_order_body.dart';
import 'package:extreme_store/data/models/order/order_response_model.dart';
import 'package:extreme_store/presentation/check_out/model_view/payment_method_state.dart';

import '../../../domain/repositories/base_repository.dart';
import '../../../domain/uses_cases/order/order_summary.dart';
import '../pages/payment_method_page.dart';

class PaymentMethodCubit extends Cubit<PaymentMethodStates> {
  final BaseRepository baseRepository;
  final OrderSummary orderSummary;
  final PaymentMethodArgs paymentMethodArgs;

  PaymentMethodCubit({
    required this.baseRepository,
    required this.orderSummary,
    required this.paymentMethodArgs,
  }) : super(const PaymentMethodStates()) {
    getOrderSummary(
        orderSummaryParams: OrderSummaryParams(
      paymentMethod: state.paymentMethod.name,
      cartID: paymentMethodArgs.cartID,
      isDigital: paymentMethodArgs.isAllDigital,
      addressID: paymentMethodArgs.addressID,
    ));
  }

  void changeMethod({
    required PaymentMethods method,
  }) async {
    emit(state.copyWith(paymentMethod: method));
    await getOrderSummary(
        orderSummaryParams: OrderSummaryParams(
      paymentMethod: method.name,
      cartID: paymentMethodArgs.cartID,
      addressID: paymentMethodArgs.addressID,
      isDigital: paymentMethodArgs.isAllDigital,
    ));
  }

  Future<void> addOrder({required AddOrderBody orderBody, required bool isAllDigital}) async {
    emit(state.copyWith(placeOrderStatus: StateStatus.loading));
    late final Either<Failure, OrderResponseModel> res;

    if (isAllDigital) {
      res = await baseRepository.addDigitalOrder(cartID: orderBody.cartID ?? 0);
    } else {
      res = await baseRepository.addOrder(orderBody: orderBody);
    }

    res.fold(
      (l) {
        emit(state.copyWith(placeOrderStatus: StateStatus.failure, message: l.message));
      },
      (r) {
        emit(state.copyWith(placeOrderStatus: StateStatus.success, message: r.message, url: r.data));
      },
    );
  }

  Future<void> getOrderSummary({required OrderSummaryParams orderSummaryParams}) async {
    emit(state.copyWith(orderSummaryStatus: StateStatus.loading));
    final res = await orderSummary(orderSummaryParams);
    res.fold(
      (l) {
        emit(state.copyWith(placeOrderStatus: StateStatus.failure, message: l.message));
      },
      (r) {
        emit(state.copyWith(
          orderSummaryStatus: StateStatus.success,
          orderSummaryDataModel: r.orderSummaryDataModel,
        ));
      },
    );
  }

  void changeAddress({required int addressID}) async {
    log("Address Changed $addressID");
    await getOrderSummary(
        orderSummaryParams: OrderSummaryParams(
      paymentMethod: state.paymentMethod.name,
      cartID: paymentMethodArgs.cartID,
      addressID: addressID,
      isDigital: paymentMethodArgs.isAllDigital,
    ));
  }
}
