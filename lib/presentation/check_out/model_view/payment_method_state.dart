import 'package:equatable/equatable.dart';
import 'package:extreme_store/app/enums/state_status.dart';
import 'package:extreme_store/data/models/order/order_summary.dart';

enum PaymentMethods { visa, cash }

class PaymentMethodStates extends Equatable {
  final PaymentMethods paymentMethod;
  final StateStatus placeOrderStatus;
  final StateStatus orderSummaryStatus;
  final OrderSummaryDataModel orderSummaryDataModel;
  final String message;
  final String url;

  const PaymentMethodStates({
    this.orderSummaryStatus = StateStatus.initial,
    this.paymentMethod = PaymentMethods.visa,
    this.placeOrderStatus = StateStatus.initial,
    this.message = '',
    this.url = '',
    this.orderSummaryDataModel = const OrderSummaryDataModel(),
  });

  PaymentMethodStates copyWith({
    PaymentMethods? paymentMethod,
    StateStatus? placeOrderStatus,
    StateStatus? orderSummaryStatus,
    String? message,
    String? url,
    OrderSummaryDataModel? orderSummaryDataModel,
  }) {
    return PaymentMethodStates(
      paymentMethod: paymentMethod ?? this.paymentMethod,
      placeOrderStatus: placeOrderStatus ?? this.placeOrderStatus,
      message: message ?? this.message,
      url: url ?? this.url,
      orderSummaryStatus: orderSummaryStatus ?? this.orderSummaryStatus,
      orderSummaryDataModel: orderSummaryDataModel ?? this.orderSummaryDataModel,
    );
  }

  @override
  List<Object?> get props => [
        paymentMethod,
        placeOrderStatus,
        message,
        url,
        orderSummaryStatus,
        orderSummaryDataModel,
      ];
}
