import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/failure/failure.dart';
import 'package:extreme_store/domain/repositories/user_preference_repo.dart';
import 'package:extreme_store/domain/uses_cases/cancel_order.dart';
import 'package:extreme_store/domain/uses_cases/get_orders_by_id.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_states.dart';
import 'package:extreme_store/presentation/track_order/model_view/track_order_states.dart';

import '../../../app/constants/colors_constants.dart';
import '../../common_widgets/dialogs/dialogs.dart';

class TrackOrderCubit extends Cubit<TrackOrdersStates>{
  TrackOrderCubit({required this.cancelOrdersByIdUseCase,required this.getOrdersByIdUseCase,required this.userPreferenceRepo}):super(const TrackOrdersStates());
  static TrackOrderCubit get(context)=>BlocProvider.of(context);
  GetOrdersByIdUseCase getOrdersByIdUseCase;
  CancelOrdersByIdUseCase cancelOrdersByIdUseCase;
  UserPreferenceRepo userPreferenceRepo;
  void getTrackOrder(int trackOrderId,BuildContext context)async{
    var token=userPreferenceRepo.getAccessToken();
    if(token.isEmpty){}else{
      var result=await getOrdersByIdUseCase(GetOrdersByIdParams( token: token, id: trackOrderId));
      result.fold((l) {
        ServerFailure(l.message);
        print("llllllllllllllllllllll${l.message}");
        showCustomSnackBar(context, l.message,color: ColorsConstants.red);
        emit(state.copyWith(trackOrderState: RequestStates.error));
      }, (r) =>       emit(state.copyWith(trackOrderState: RequestStates.success,trackOrderModel: r.ordersDataModel))
      );

    }
  }
  cancelOrder({required int orderId,required BuildContext context})async{
    var token=userPreferenceRepo.getAccessToken();
    if(token.isEmpty){

    }else{
    var result=await cancelOrdersByIdUseCase(CancelOrdersByIdParams(id: orderId));
    result.fold((l) {
      ServerFailure(l.message);
      emit(state.copyWith(trackOrderState: RequestStates.error));
    }, (r) {
      showCustomSnackBar(context,StringsConstants.orderIsCanceled.tr(),color: ColorsConstants.red);

      emit(state.copyWith(cancelOrderState:RequestStates.success));}
    );
  }}

}