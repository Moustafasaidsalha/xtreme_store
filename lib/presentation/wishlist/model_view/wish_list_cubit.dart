import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:extreme_store/app/failure/failure.dart';
import 'package:extreme_store/data/models/wishlist.dart';
import 'package:extreme_store/domain/repositories/user_preference_repo.dart';
import 'package:extreme_store/domain/uses_cases/delete_wishlist_item.dart';
import 'package:extreme_store/domain/uses_cases/get_wishlists.dart';
import 'package:extreme_store/domain/uses_cases/set_wishlist_item.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_states.dart';
import 'package:extreme_store/presentation/wishlist/model_view/wish_list_states.dart';

import '../../../app/constants/colors_constants.dart';
import '../../../app/constants/strings_constants.dart';
import '../../../app/di/injection_container.dart';
import '../../common_widgets/dialogs/dialogs.dart';

class WishlistCubit extends Cubit<WishlistStates> {
  int dataLength=0;
  WishlistCubit(this.getWishlistsUseCase,this.deleteWishlistItemUseCase,this.setWishlistItemUseCase,this.userPreferenceRepo) : super(const WishlistStates());
  static WishlistCubit get(context) => BlocProvider.of(context);
  GetWishlistsUseCase getWishlistsUseCase;
  SetWishlistItemUseCase setWishlistItemUseCase;
  DeleteWishlistItemUseCase deleteWishlistItemUseCase;
  UserPreferenceRepo userPreferenceRepo;
  // var token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTQsInJvbGUiOiJ1c2VyIiwiaWF0IjoxNjkyNTY4MTYzfQ.QJaluvvMH6nHQMSd4Zqk-TdVu2Al67tzWbk5rf80eL4";

  Future<void> getWishlists()async{
    var token=userPreferenceRepo.getAccessToken();
    // var token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTQsInJvbGUiOiJ1c2VyIiwiaWF0IjoxNjkyNTY4MTYzfQ.QJaluvvMH6nHQMSd4Zqk-TdVu2Al67tzWbk5rf80eL4";

    if(token.isEmpty){

  }else{
    dataLength=0;


    var result=await getWishlistsUseCase( GetWishlistsParams(offset: 0, limit: 10,token:token ));
    result.fold((l) {ServerFailure(l.message);
    emit(state.copyWith(getWishListState: RequestStates.error));

    } , (r) {
      dataLength=r.wishlistMetaModel?.totalLength??0;
      emit(state.copyWith(getWishListState: RequestStates.success,wishlistsModel: r));

    });
  }
  }
//   Future<void> setWishlist(int productID)async{
//     // var token=userPreferenceRepo.getAccessToken();
//     // var token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTQsInJvbGUiOiJ1c2VyIiwiaWF0IjoxNjkyNTY4MTYzfQ.QJaluvvMH6nHQMSd4Zqk-TdVu2Al67tzWbk5rf80eL4";
// if(token.isEmpty){}else{
//
//   var result=await setWishlistItemUseCase(SetWishlistItemParams(productID: ProductIdModel(productID), token: token));
//   result.fold((l) {ServerFailure(l.message);
//   emit(state.copyWith(setWishListState: RequestStates.error));
//
//   } , (r) {
//     emit(state.copyWith(setWishListState: RequestStates.success));
//   });
//   }
//
//
//
//
//
//   }
  Future<void> deleteWishlist(int productID)async{


    var result=await deleteWishlistItemUseCase(DeleteWishlistItemParams(productID: ProductIdModel(productID), token: userPreferenceRepo.getAccessToken()));
    result.fold((l) {ServerFailure(l.message);
    emit(state.copyWith(deleteWishListState:RequestStates.error ));

    } , (r) {
      emit(state.copyWith(deleteWishListState: RequestStates.success));

      getWishlists();



    });
  }
  Future<void> setWishlist(int productID,BuildContext context)async {
    var token = sl<UserPreferenceRepo>().getAccessToken();
    // var token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTQsInJvbGUiOiJ1c2VyIiwiaWF0IjoxNjkyNTY4MTYzfQ.QJaluvvMH6nHQMSd4Zqk-TdVu2Al67tzWbk5rf80eL4";
    if (token.isEmpty) {
      showCustomSnackBar(context, StringsConstants.notRegisterYet.tr(),
          color: ColorsConstants.red);
    } else {
      var result = await setWishlistItemUseCase(SetWishlistItemParams(
          productID: ProductIdModel(productID), token: token));
      result.fold((l) {
        ServerFailure(l.message);
        showCustomSnackBar(context, l.message, color: ColorsConstants.red);

        emit(state.copyWith(setWishListState: RequestStates.error));
      }, (r) {
        emit(state.copyWith(setWishListState: RequestStates.success));
        showCustomSnackBar(
            context, r.message ?? StringsConstants.addedToWishlist.tr(),
            color: ColorsConstants.green);

        getWishlists();
      });
    }
  }

}
