import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:extreme_store/presentation/order_lookup/model_view/order_lookup_states.dart';

class OrderLookupCubit extends Cubit<OrderLookupStates>{
  OrderLookupCubit():super(InitialState());
  static OrderLookupCubit get(context)=>BlocProvider.of(context);
TextEditingController controller=TextEditingController();


}




