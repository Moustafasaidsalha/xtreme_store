import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:extreme_store/app/di/injection_container.dart';
import 'package:extreme_store/app/services/notification_services.dart';
import 'package:extreme_store/domain/repositories/user_preference_repo.dart';
import 'package:extreme_store/domain/uses_cases/cart/add_promo_code.dart';
import 'package:extreme_store/domain/uses_cases/cart/change_product_cart_amount.dart';
import 'package:extreme_store/domain/uses_cases/cart/delete_from_cart.dart';
import 'package:extreme_store/domain/uses_cases/cart/get_cart_products.dart';
import 'package:extreme_store/domain/uses_cases/cart/remove_promo_code.dart';
import 'package:extreme_store/presentation/cart/model_view/cart_cubit.dart';
import 'package:extreme_store/presentation/cart/pages/cart_page.dart';
import 'package:extreme_store/presentation/layout/widgets/layout_widgets.dart';
import 'package:extreme_store/presentation/my_account/pages/account_landing_page.dart';

import '../../category/pages/category_home.dart';
import '../../home/pages/home_page.dart';
import '../model_view/layout_cubit.dart';
import '../model_view/layout_states.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  @override
  void initState() {
    super.initState();
    NotificationServices.setupInteractedMessage(context);
    NotificationServices.handelNotificationForeground(context);
    NotificationServices.initLocal(context);
  }

  ///TODO
  ///you need to access state instead of cubit
  ///
  // @override
  // Widget build(BuildContext context) {
  //   var cubit = LayoutCubit.get(context);
  //   return BlocBuilder<LayoutCubit, LayoutStates>(
  //     builder: (context, state) {
  //       return Scaffold(
  //         body: cubit.currentScreen,
  //         bottomNavigationBar: bottomNavigationBarWidget(context: context),
  //
  //       );
  //     },
  //   );
  // }
  //
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutStates>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: LayoutCubit.get(context).bottomNavIndex,
            children: [
              const HomePage(),
              const CategoryHomeScreen(),
              BlocProvider(
                create: (context) => CartCubit(
                    getCartProducts: sl<GetCartProducts>(),
                    deleteFromCart: sl<DeleteFromCart>(),
                    changeProductCartAmount: sl<ChangeProductCartAmount>(),
                    addPromoCode: sl<AddPromoCode>(),
                    removePromoCode: sl<RemovePromoCode>(),
                    userPreferenceRepo: sl<UserPreferenceRepo>())
                  ..getCartItems(),
                child: const CartPage(),
              ),
              AccountLandingPage(userPreferenceRepo: sl<UserPreferenceRepo>()),
            ],
          ),
          bottomNavigationBar: Localizations.override(
              context: context,
              locale: context.locale,
              child: bottomNavigationBarWidget(context: context)),
        );
      },
    );
  }
}
