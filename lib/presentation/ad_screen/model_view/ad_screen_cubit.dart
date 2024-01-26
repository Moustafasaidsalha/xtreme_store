

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:extreme_store/app/failure/failure.dart';
import 'package:extreme_store/app/routes/routes_constants.dart';
import 'package:extreme_store/domain/uses_cases/get_ad_screen.dart';
import 'package:extreme_store/presentation/ad_screen/model_view/ad_screen_states.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_states.dart';

class AdScreenCubit extends Cubit<AdScreenStates>{
  AdScreenCubit(this.getAdScreenUseCase):super(const AdScreenStates());
  static AdScreenCubit get(context)=>BlocProvider.of(context);
  GetAdScreenUseCase getAdScreenUseCase;
  getAdScreen(BuildContext context)async{
  var result=await getAdScreenUseCase(const GetAddScreenParams(offset: 0, limit: 10));
  result.fold((l) {
    ServerFailure(l.message);
emit(state.copyWith(getAddScreenState: RequestStates.error));

  }, (r) {
    if(r.adScreenMetaModel?.totalLength==0){
      Navigator.of(context).pushReplacementNamed(RoutesConstant.homeLanding);
      // emit(state.copyWith(getAddScreenState: RequestStates.success,adScreensModel: r));

    }else{

        emit(state.copyWith(getAddScreenState: RequestStates.success,adScreensModel: r));
    }


  });
}
}