import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:extreme_store/app/failure/failure.dart';
import 'package:extreme_store/domain/repositories/user_preference_repo.dart';
import 'package:extreme_store/domain/uses_cases/get_orders.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_states.dart';

import 'orders_states.dart';
class OrdersCubit extends Cubit<OrdersStates>{
  OrdersCubit({required this.getOrdersUseCase,required this.userPreferenceRepo}):super(const OrdersStates());
  static OrdersCubit get(context)=>BlocProvider.of(context);
GetOrdersUseCase getOrdersUseCase;
UserPreferenceRepo userPreferenceRepo;
void getOrders()async{
  var token=userPreferenceRepo.getAccessToken();
  print(token);
  if(token.isEmpty){}else{
    var result=await getOrdersUseCase(GetOrdersParams(offset: 1, limit: 10, token: token));
    result.fold((l) {
      ServerFailure(l.message);
      emit(state.copyWith(ordersState: RequestStates.error));
    }, (r) {
      print(r.ordersMetaModel?.ordersDataModel);

      emit(state.copyWith(ordersState: RequestStates.success,ordersDataModel: r.ordersMetaModel?.ordersDataModel));}
    );

  }
}
}