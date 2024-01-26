// import 'package:equatable/equatable.dart';
// import 'package:extreme_store/data/models/wishlist.dart';
//
// abstract class WishlistStates extends Equatable {
//   @override
//   List<Object> get props => [];
// }
//
// class InitialState extends WishlistStates {}
//
// class GetWishListSuccessState extends WishlistStates {
//
//   final WishlistsModel? wishlistsModel;
//
//    GetWishListSuccessState({
// required    this.wishlistsModel,
//   });
// }
// class GetWishListErrorState extends WishlistStates {}
// class GetWishListLoadingState extends WishlistStates {}
//
// class SetWishListSuccessState extends WishlistStates {}
// class SetWishListErrorState extends WishlistStates {}
// class SetWishListLoadingState extends WishlistStates {}
// class DeleteWishListErrorState extends WishlistStates {}
// class DeleteWishListSuccessState extends WishlistStates {}
// class DeleteWishListLoadingState extends WishlistStates {}
import 'package:equatable/equatable.dart';
import 'package:extreme_store/data/models/wishlist.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_states.dart';

class WishlistStates extends Equatable {
  final RequestStates getWishListState;
  final WishlistsModel? wishlistsModel;
  final RequestStates deleteWishListState;

  WishlistStates copyWith({   RequestStates? getWishListState,
   RequestStates? setWishListState,
   RequestStates? deleteWishListState,
   WishlistsModel? wishlistsModel,}){
    return WishlistStates(getWishListState: getWishListState??this.getWishListState,wishlistsModel:wishlistsModel??this.wishlistsModel,deleteWishListState: deleteWishListState??this.deleteWishListState );
}
  @override
  List<Object?> get props =>
      [getWishListState,  wishlistsModel,deleteWishListState];

  const WishlistStates({
     this.getWishListState=RequestStates.loading,
     this.deleteWishListState=RequestStates.loading,
    this.wishlistsModel,
  });
}