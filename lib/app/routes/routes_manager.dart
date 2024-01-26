import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:extreme_store/app/di/injection_container.dart';
import 'package:extreme_store/app/routes/routes_constants.dart';
import 'package:extreme_store/domain/repositories/auth_repo.dart';
import 'package:extreme_store/domain/repositories/base_repository.dart';
import 'package:extreme_store/domain/repositories/user_preference_repo.dart';
import 'package:extreme_store/domain/uses_cases/cart/add_promo_code.dart';
import 'package:extreme_store/domain/uses_cases/cart/add_to_cart.dart';
import 'package:extreme_store/domain/uses_cases/cart/delete_from_cart.dart';
import 'package:extreme_store/domain/uses_cases/cart/get_cart_products.dart';
import 'package:extreme_store/domain/uses_cases/cart/migrate_local_cart_t_online.dart';
import 'package:extreme_store/domain/uses_cases/cart/remove_promo_code.dart';
import 'package:extreme_store/domain/uses_cases/get_products.dart';
import 'package:extreme_store/domain/uses_cases/order/order_summary.dart';
import 'package:extreme_store/domain/uses_cases/time_slot/get_block_date.dart';
import 'package:extreme_store/domain/uses_cases/time_slot/get_interval_hours.dart';
import 'package:extreme_store/presentation/ad_screen/page/ad_screen.dart';
import 'package:extreme_store/presentation/addresses/model_view/map_cubit/map_cubit.dart';
import 'package:extreme_store/presentation/addresses/pages/map_page.dart';
import 'package:extreme_store/presentation/addresses/pages/add_new_address_page.dart';
import 'package:extreme_store/presentation/addresses/pages/addresses_pages.dart';
import 'package:extreme_store/presentation/authentication/model_view/bloc/add_new_password_bloc.dart';
import 'package:extreme_store/presentation/authentication/model_view/bloc/change_pin_bloc.dart';
import 'package:extreme_store/presentation/authentication/model_view/bloc/login_bloc.dart';
import 'package:extreme_store/presentation/authentication/model_view/bloc/login_with_pin_bloc.dart';
import 'package:extreme_store/presentation/authentication/model_view/bloc/phone_sign_up_bloc.dart';
import 'package:extreme_store/presentation/authentication/model_view/bloc/register_bloc.dart';
import 'package:extreme_store/presentation/authentication/model_view/bloc/reset_password_bloc.dart';
import 'package:extreme_store/presentation/authentication/model_view/bloc/reset_password_check_code_bloc.dart';
import 'package:extreme_store/presentation/authentication/model_view/bloc/sign_up_with_pin_bloc.dart';
import 'package:extreme_store/presentation/authentication/model_view/bloc/verify_user_bloc.dart';
import 'package:extreme_store/presentation/authentication/pages/change_pin_page.dart';
import 'package:extreme_store/presentation/authentication/pages/login_with_pin_page.dart';
import 'package:extreme_store/presentation/authentication/pages/phone_sign_up_page.dart';
import 'package:extreme_store/presentation/authentication/pages/reset_password_page.dart';
import 'package:extreme_store/presentation/authentication/pages/login_page.dart';
import 'package:extreme_store/presentation/authentication/pages/add_new_password_page.dart';
import 'package:extreme_store/presentation/authentication/pages/sign_up_page.dart';
import 'package:extreme_store/presentation/authentication/pages/verify_code_page.dart';
import 'package:extreme_store/presentation/authentication/pages/verify_successful_page.dart';
import 'package:extreme_store/presentation/authentication/pages/verify_user_page.dart';
import 'package:extreme_store/presentation/best_seller/pages/best_seller_page.dart';
import 'package:extreme_store/presentation/cart/model_view/cart_cubit.dart';
import 'package:extreme_store/presentation/cart/pages/cart_page.dart';
import 'package:extreme_store/presentation/category/pages/category.dart';
import 'package:extreme_store/presentation/category/pages/category_home.dart';
import 'package:extreme_store/presentation/check_out/model_view/payment_method_cubit.dart';
import 'package:extreme_store/presentation/check_out/model_view/time_slot_cubit.dart';
import 'package:extreme_store/presentation/check_out/pages/payment_page.dart';
import 'package:extreme_store/presentation/check_out/pages/time_slot_page.dart';
import 'package:extreme_store/presentation/check_out/pages/payment_method_page.dart';
import 'package:extreme_store/presentation/static_pages/pages/faqs.dart';
import 'package:extreme_store/presentation/home/model_view/home_bloc.dart';
import 'package:extreme_store/presentation/home/pages/home_page.dart';
import 'package:extreme_store/presentation/layout/layout_screen/layout.dart';
import 'package:extreme_store/presentation/layout/model_view/layout_cubit.dart';
import 'package:extreme_store/presentation/new_in/model_view/new_in_cubit.dart';
import 'package:extreme_store/presentation/new_in/pages/new_in_page.dart';
import 'package:extreme_store/presentation/notifications/pages/notifications.dart';
import 'package:extreme_store/presentation/offers/pages/offers_page.dart';
import 'package:extreme_store/presentation/on_boarding/pages/select_country.dart';
import 'package:extreme_store/presentation/order_lookup/pages/order_lookup.dart';
import 'package:extreme_store/presentation/orders/pages/orders.dart';
import 'package:extreme_store/presentation/static_pages/pages/privacy_policy.dart';
import 'package:extreme_store/presentation/product_details/pages/product_details.dart';
import 'package:extreme_store/presentation/profile/pages/profile.dart';
import 'package:extreme_store/presentation/search/model_view/search_cubit.dart';
import 'package:extreme_store/presentation/search/pages/search_page.dart';
import 'package:extreme_store/presentation/track_order/pages/track_order_page.dart';
import 'package:extreme_store/presentation/wishlist/pages/wishlist_page.dart';

import '../../domain/uses_cases/cart/change_product_cart_amount.dart';
import '../../presentation/authentication/pages/sign_up_with_pin_page.dart';
import '../../presentation/static_pages/model_view/static_page_cubit.dart';
import '../../presentation/static_pages/model_view/static_page_state.dart';
import '../../presentation/static_pages/pages/about_app.dart';

class RouteManager {
  static Route<dynamic> getRoute(RouteSettings settings) {
    late Widget page;
    if (settings.name?.contains("products/productdetails") ?? false) {
      var s = settings.name!.split("/");
      page = ProductDetailsScreen(
        id: int.tryParse(s.last) ?? 0,
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) {
          return page;
        },
        settings: settings,
      );
    }
    switch (settings.name) {
      case RoutesConstant.selectCountry:
        page = SelectCountry(
          userPreferenceRepo: sl<UserPreferenceRepo>(),
        );
        break;

      case RoutesConstant.login:
        page = BlocProvider(
            create: (context) => LoginBloc(
                  authRepo: sl<AuthRepo>(),
                  userPreferenceRepo: sl<UserPreferenceRepo>(),
                ),
            child: const LoginPage());
        break;
      case RoutesConstant.loginWithPin:
        page = BlocProvider(
            create: (context) => LoginWithPinBloc(
                  authRepo: sl<AuthRepo>(),
                  userPreferenceRepo: sl<UserPreferenceRepo>(),
                  migrateLocalCartToOnline: sl<MigrateLocalCartToOnline>(),
                ),
            child: const LoginWithPinPage());
        break;

      case RoutesConstant.signUp:
        page = BlocProvider(
            create: (context) => RegisterBloc(
                  authRepo: sl<AuthRepo>(),
                ),
            child: const SignUpPage());
        break;
      case RoutesConstant.phoneSignUp:
        page = BlocProvider(
            create: (context) => PhoneSignUpBloc(
                  authRepo: sl<AuthRepo>(),
                ),
            child: const PhoneSignUpPage());
        break;
      case RoutesConstant.signUpWithPin:
        page = BlocProvider(
            create: (context) => SignUpWithPinBloc(
                  authRepo: sl<AuthRepo>(),
                  userPreferenceRepo: sl<UserPreferenceRepo>(),
                  migrateLocalCartToOnline: sl<MigrateLocalCartToOnline>(),
                ),
            child: const SignUpWithPinPage());
        break;

      case RoutesConstant.verifyUser:
        VerifyUserArgs args = settings.arguments as VerifyUserArgs;
        page = BlocProvider(
          create: (context) => VerifyUserBloc(
              phoneNumber: args.phoneNumber,
              countryCode: args.countryCode,
              type: args.type,
              authRepo: sl<AuthRepo>(),
              userPreferenceRepo: sl<UserPreferenceRepo>(),
              migrateLocalCartToOnline: sl<MigrateLocalCartToOnline>()),
          child: const VerifyUserPage(),
        );
        break;
      case RoutesConstant.resetPassword:
        page = BlocProvider(
            create: (context) => ResetPasswordBloc(
                  authRepo: sl<AuthRepo>(),
                ),
            child: const ResetPasswordPage());
        break;
      case RoutesConstant.changePin:
        page = BlocProvider(
            create: (context) => ChangePinBloc(
                  authRepo: sl<AuthRepo>(),
                ),
            child: const ChangePinPage());
        break;
      case RoutesConstant.verifyResetPasswordCode:
        VerifyResetPasswordCodeArgs args =
            settings.arguments as VerifyResetPasswordCodeArgs;
        page = BlocProvider(
          create: (context) => ResetPasswordCheckCodeBloc(
            authRepo: sl<AuthRepo>(),
            email: args.email,
          ),
          child: VerifyCodePage(email: args.email),
        );
        break;

      case RoutesConstant.addNewPassword:
        // AddNewPasswordArgs args = settings.arguments as AddNewPasswordArgs;
        page = BlocProvider(
          create: (context) => AddNewPasswordBloc(
            authRepo: sl<AuthRepo>(),
            email: 'args.email',
            code: 'args.code',
          ),
          child: const AddNewPasswordPage(),
        );
        break;
      case RoutesConstant.verifySuccessful:
        VerifySuccessfulArgs args = settings.arguments as VerifySuccessfulArgs;
        page = VerifySuccessfulPage(
          message: args.message,
          onTapDone: args.onTapDone,
        );
        break;

      case RoutesConstant.home:
        page = const HomePage();
        break;
      case RoutesConstant.categories:
        List<int?> ids = settings.arguments as List<int?>;

        page = CategoryScreen(
          categoryId: ids[0],
          subCategoryId: ids[1],
          brandId: ids[2],
        );
        break;

      case RoutesConstant.bestSeller:
        page = const BestSellerPage();
        break;
      case RoutesConstant.newIn:
        page = BlocProvider(
            create: (context) => NewInCubit(
                  getProductsUseCase: sl<GetProductsUseCase>(),
                  addToCart: sl<AddToCart>(),
                ),
            child: const NewInPage());
        break;
      case RoutesConstant.offers:
        page = const OffersPage();
        break;
      case RoutesConstant.search:
        page = BlocProvider(
          create: (context) => sl<SearchCubit>(),
          child: const SearchScreen(),
        );
        break;
      case RoutesConstant.adScreenPage:
        page = const AdScreenPage();

        break;
      case RoutesConstant.profile:
        page = const ProfileScreen();
        break;
      case RoutesConstant.orders:
        page = const OrdersScreen();
        break;
      case RoutesConstant.wishlist:
        page = WishlistPage(
          userPreferenceRepo: sl<UserPreferenceRepo>(),
        );
        break;
      case RoutesConstant.notifications:
        page = const NotificationsScreen();
        break;
      case RoutesConstant.aboutApp:
        page = BlocProvider(
          create: (context) => StaticPageCubit(
            baseRepository: sl<BaseRepository>(),
          )..getStaticPage(type: StaticPageType.about.name),
          child: const AboutAppScreen(),
        );
        break;
      case RoutesConstant.privacyPolicy:
        page = BlocProvider(
          create: (context) => StaticPageCubit(
            baseRepository: sl<BaseRepository>(),
          )..getStaticPage(type: StaticPageType.Privacy.name),
          child: const PrivacyPolicyScreen(),
        );
        break;
      case RoutesConstant.faqs:
        page = BlocProvider(
          create: (context) => StaticPageCubit(
            baseRepository: sl<BaseRepository>(),
          )..getStaticPage(type: StaticPageType.faqs.name),
          child: const FaqsScreen(),
        );
        break;
      case RoutesConstant.cart:
        page = BlocProvider(
          create: (context) => CartCubit(
              getCartProducts: sl<GetCartProducts>(),
              deleteFromCart: sl<DeleteFromCart>(),
              changeProductCartAmount: sl<ChangeProductCartAmount>(),
              addPromoCode: sl<AddPromoCode>(),
              removePromoCode: sl<RemovePromoCode>(),
              userPreferenceRepo: sl<UserPreferenceRepo>())
            ..getCartItems(),
          child: const CartPage(),
        );
        break;
      case RoutesConstant.cartFromDetails:
        page = BlocProvider(
          create: (context) => CartCubit(
              getCartProducts: sl<GetCartProducts>(),
              deleteFromCart: sl<DeleteFromCart>(),
              changeProductCartAmount: sl<ChangeProductCartAmount>(),
              addPromoCode: sl<AddPromoCode>(),
              removePromoCode: sl<RemovePromoCode>(),
              userPreferenceRepo: sl<UserPreferenceRepo>())
            ..getCartItems(),
          child: const LayoutScreen(),
        );
        break;

      case RoutesConstant.mapPage:
        page = BlocProvider(
          create: (context) =>
              MapCubit(userPreferenceRepo: sl<UserPreferenceRepo>()),
          child: const MapPage(),
        );
        break;
      case RoutesConstant.addresses:
        page = const AddressesPage();
        break;
      case RoutesConstant.addNewAddress:
        LatLng userLatLon = settings.arguments as LatLng;
        page = AddNewAddressPage(currentLatLng: userLatLon);
        break;

      case RoutesConstant.productDetails:
        List<int?> ids = settings.arguments as List<int?>;
        page = ProductDetailsScreen(
          id: ids[0] ?? 1,
          categoryId: ids[1],
        );
        break;

      case RoutesConstant.timeSlot:
        TimeSlotArgs args = settings.arguments as TimeSlotArgs;
        page = BlocProvider(
          create: (context) => TimeSlotCubit(
            getBlockDates: sl<GetBlockDates>(),
            getIntervalHours: sl<GetIntervalHours>(),
          )..getBlackOutDates(),
          child: TimeSlotPage(timeSlotArgs: args),
        );
        break;
      case RoutesConstant.paymentMethod:
        PaymentMethodArgs args = settings.arguments as PaymentMethodArgs;
        page = BlocProvider(
          create: (context) => PaymentMethodCubit(
            baseRepository: sl<BaseRepository>(),
            orderSummary: sl<OrderSummary>(),
            paymentMethodArgs: args,
          ),
          child: PaymentMethodPage(paymentMethodArgs: args),
        );
        break;

      case RoutesConstant.orderLookupPage:
        page = const OrderLookupPage();
        break;
      case RoutesConstant.trackOrder:
        int trackOrder = settings.arguments as int;
        page = TrackOrderPage(
          trackOrderId: trackOrder,
        );
        break;
      case RoutesConstant.categoryHome:
        page = const CategoryHomeScreen();
        break;

      case RoutesConstant.homeLanding:
        page = MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => LayoutCubit(),
              child: const LayoutScreen(),
            ),
            BlocProvider(
              create: (context) => sl<HomeBloc>(),
              lazy: false,
              child: const HomePage(),
            ),
          ],
          child: const LayoutScreen(),
        );
        break;

      case RoutesConstant.paymentPage:
        String url = settings.arguments as String;
        page = PaymentPage(url: url);
        break;
      default:
        throw Exception('Unknown route: ${settings.name}');
    }

    return MaterialPageRoute<dynamic>(
      builder: (context) {
        return page;
      },
      settings: settings,
    );
  }
}
