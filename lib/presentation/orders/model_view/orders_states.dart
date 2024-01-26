import 'package:equatable/equatable.dart';
import 'package:extreme_store/data/models/orders.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_states.dart';

class OrdersStates extends Equatable {
  final RequestStates ordersState;
  final List<OrdersDataModel>? ordersDataModel;


  @override
  List<Object?> get props => [ordersState, ordersDataModel];
  OrdersStates copyWith({ RequestStates? ordersState,
   List<OrdersDataModel>? ordersDataModel,}){
    return OrdersStates(ordersDataModel: ordersDataModel??this.ordersDataModel,ordersState:ordersState??this.ordersState );
}
  const OrdersStates({
     this.ordersState=RequestStates.loading,
    this.ordersDataModel,
  });
}
