import 'package:flutter/material.dart';
import 'package:extreme_store/app/constants/icon_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:extreme_store/domain/repositories/user_preference_repo.dart';
import 'package:extreme_store/domain/uses_cases/cart/delete_from_cart.dart';
import 'package:extreme_store/domain/uses_cases/cart/get_cart_products.dart';
import 'package:extreme_store/presentation/cart/model_view/cart_cubit.dart';
import 'package:extreme_store/presentation/cart/pages/cart_page.dart';
import 'package:extreme_store/presentation/home/pages/home_page.dart';
import 'package:extreme_store/presentation/layout/model_view/layout_states.dart';
import 'package:extreme_store/presentation/my_account/pages/account_landing_page.dart';

import '../../../app/di/injection_container.dart';
import '../../../domain/uses_cases/cart/add_promo_code.dart';
import '../../../domain/uses_cases/cart/change_product_cart_amount.dart';
import '../../../domain/uses_cases/cart/remove_promo_code.dart';
import '../../category/pages/category_home.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(InitialState());
  static LayoutCubit get(context) => BlocProvider.of(context);
  int bottomNavIndex = 0;
bool isNotEmpty=false;
  Map<String, String> item = {
    StringsConstants.home: IconsConstants.homeIC,
    StringsConstants.categories: IconsConstants.categoriesIC,
    StringsConstants.cart: IconsConstants.cartIC,
    StringsConstants.myAccount: IconsConstants.profileIC,
  };
  List<Widget> screens = [
    const HomePage(),
    const CategoryHomeScreen(),
    BlocProvider(
      create: (context) => CartCubit(
        getCartProducts: sl<GetCartProducts>(),
        deleteFromCart: sl<DeleteFromCart>(),
        changeProductCartAmount: sl<ChangeProductCartAmount>(),
        addPromoCode:  sl<AddPromoCode>(),
        removePromoCode: sl<RemovePromoCode>(),
          userPreferenceRepo: sl<UserPreferenceRepo>()
      )..getCartItems(),
      child: const CartPage(),
    ),
    AccountLandingPage(userPreferenceRepo: sl<UserPreferenceRepo>()),
  ];
  Widget currentScreen = const HomePage();
  changeBottomNav({required int value, required BuildContext context}) {
    bottomNavIndex = value;
    currentScreen = screens[value];

    emit(ChangeBottomNavState());
  }
}
