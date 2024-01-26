import 'package:equatable/equatable.dart';
import 'package:extreme_store/data/models/ad_screen.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_states.dart';

class AdScreenStates extends Equatable {
  final RequestStates getAddScreenState;
  final AdScreensModel? adScreensModel;

  @override
  List<Object?> get props => [getAddScreenState, adScreensModel];
  AdScreenStates copyWith({

     RequestStates? getAddScreenState,
     AdScreensModel? adScreensModel,

}){
    return AdScreenStates(adScreensModel: adScreensModel??this.adScreensModel,getAddScreenState: getAddScreenState??this.getAddScreenState);
}
  const AdScreenStates({
    this.getAddScreenState = RequestStates.loading,
    this.adScreensModel,
  });
}