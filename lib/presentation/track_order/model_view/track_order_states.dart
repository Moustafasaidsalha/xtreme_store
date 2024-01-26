import 'package:equatable/equatable.dart';
import 'package:extreme_store/data/models/orders.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_states.dart';

class TrackOrdersStates extends Equatable {
  final RequestStates trackOrderState;
  final RequestStates cancelOrderState;
  final OrdersDataModel? trackOrderModel;

  @override
  List<Object?> get props => [trackOrderState, trackOrderModel];

  TrackOrdersStates copyWith({
    RequestStates? trackOrderState,
    RequestStates? cancelOrderState,
    OrdersDataModel? trackOrderModel,
  }) {
    return TrackOrdersStates(
        trackOrderModel: trackOrderModel ?? this.trackOrderModel,
        trackOrderState: trackOrderState ?? this.trackOrderState,
      cancelOrderState: cancelOrderState ?? this.cancelOrderState,
    );
  }

  const TrackOrdersStates({
    this.trackOrderState = RequestStates.loading,
    this.cancelOrderState = RequestStates.loading,
    this.trackOrderModel,
  });
}
