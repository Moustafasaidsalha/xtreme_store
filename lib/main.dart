import 'package:config/config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:extreme_store/app/di/injection_container.dart';
import 'package:extreme_store/app/helper/observer.dart';
import 'package:extreme_store/app/routes/routes_manager.dart';
import 'package:extreme_store/app/services/notification_services.dart';
import 'package:extreme_store/app/theme/theme_manager.dart';
import 'package:extreme_store/domain/repositories/base_repository.dart';
import 'package:extreme_store/domain/repositories/user_preference_repo.dart';
import 'package:extreme_store/domain/uses_cases/address/get_addresses.dart';
import 'package:extreme_store/domain/uses_cases/address/get_area.dart';
import 'package:extreme_store/domain/uses_cases/cart/add_to_cart.dart';
import 'package:extreme_store/domain/uses_cases/get_products.dart';
import 'package:extreme_store/firebase_options.dart';
import 'package:extreme_store/presentation/ad_screen/model_view/ad_screen_cubit.dart';
import 'package:extreme_store/presentation/ad_screen/page/ad_screen.dart';
import 'package:extreme_store/presentation/addresses/model_view/add_new_address_bloc/add_new_address_bloc.dart';
import 'package:extreme_store/presentation/addresses/model_view/address_selection_cubit/address_selection_cubit.dart';
import 'package:extreme_store/presentation/addresses/model_view/map_cubit/map_cubit.dart';
import 'package:extreme_store/presentation/authentication/model_view/bloc/login_bloc.dart';
import 'package:extreme_store/presentation/authentication/pages/login_page.dart';
import 'package:extreme_store/presentation/best_seller/model_view/best_seller_cubit.dart';
import 'package:extreme_store/presentation/best_seller/pages/best_seller_page.dart';
import 'package:extreme_store/presentation/category/model_view/category_home_cubit/category_home_cubit.dart';
import 'package:extreme_store/presentation/category/pages/category.dart';
import 'package:extreme_store/presentation/category/pages/category_home.dart';
import 'package:extreme_store/presentation/home/model_view/home_bloc.dart';
import 'package:extreme_store/presentation/home/pages/home_page.dart';
import 'package:extreme_store/presentation/layout/layout_screen/layout.dart';
import 'package:extreme_store/presentation/layout/model_view/layout_cubit.dart';
import 'package:extreme_store/presentation/my_account/model_view/account_cubit.dart';
import 'package:extreme_store/presentation/my_account/pages/account_landing_page.dart';
import 'package:extreme_store/presentation/offers/model_view/offers_cubit.dart';
import 'package:extreme_store/presentation/on_boarding/pages/select_country.dart';
import 'package:extreme_store/presentation/order_lookup/model_view/order_lookup_cubit.dart';
import 'package:extreme_store/presentation/order_lookup/pages/order_lookup.dart';
import 'package:extreme_store/presentation/orders/model_view/orders_cubit.dart';
import 'package:extreme_store/presentation/orders/pages/orders.dart';
import 'package:extreme_store/presentation/profile/model_view/profile_cubit.dart';
import 'package:extreme_store/presentation/profile/pages/profile.dart';
import 'package:extreme_store/presentation/search/model_view/search_cubit.dart';
import 'package:extreme_store/presentation/search/pages/search_page.dart';
import 'package:extreme_store/presentation/track_order/model_view/track_order_cubit.dart';
import 'package:extreme_store/presentation/wishlist/model_view/wish_list_cubit.dart';
import 'app/di/injection_container.dart' as di;
import 'domain/repositories/auth_repo.dart';
import 'presentation/category/model_view/category_cubit/category_cubit.dart';
import 'data/data_source/local/user_preference_source.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'presentation/product_details/model_view/product_details_bloc.dart';

void setPermissions() async {
  await Geolocator.requestPermission();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  final userPreferenceBox = await Hive.openBox(
    UserPreferenceConstants.boxName,
  );
  await di.init(userPreferenceBox: userPreferenceBox);
  setPermissions();
  Bloc.observer = MyBlocObserver();
  await sl<HomeBloc>().getAppTheme();

  ///Notification
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationServices notificationServices = NotificationServices(messaging);
  notificationServices.init();
  FirebaseMessaging.onBackgroundMessage(
    NotificationServices.firebaseMessagingBackgroundHandler,
  );

  runApp(
    EasyLocalization(
      startLocale: const Locale("en", "US"),
      supportedLocales: const [Locale("ar", "EG"), Locale("en", "US")],
      path: "assets/translations",
      child: MyApp(userPreferenceRepo: sl<UserPreferenceRepo>()),
    ),
  );
}

class MyApp extends StatefulWidget {
  final UserPreferenceRepo userPreferenceRepo;
  const MyApp({super.key, required this.userPreferenceRepo});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String isLogged = '';
  bool showONBoarding = false;

  @override
  void initState() {
    isLogged = widget.userPreferenceRepo.getAccessToken();
    showONBoarding = widget.userPreferenceRepo.getHideOnBoarding();
    if (kDebugMode) {
      print(showONBoarding);
      print(isGCCApp);
      print(isLogged);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        // sl<HomeBloc>().getAppTheme();

        return BlocProvider(
          create: (context) => AddNewAddressBloc(
            baseRepository: sl<BaseRepository>(),
            getArea: sl<GetArea>(),
            userPreferenceRepo: sl<UserPreferenceRepo>(),
          ),
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => LayoutCubit(),
                child: const LayoutScreen(),
              ),
              BlocProvider(
                create: (context) => sl<SearchCubit>(),
                child: const SearchScreen(),
              ),
              BlocProvider(
                create: (context) => LayoutCubit(),
                child: const LayoutScreen(),
              ),
              BlocProvider(
                create: (context) => sl<HomeBloc>(),
                child: const HomePage(),
              ),
              BlocProvider(
                create: (context) => sl<AccountCubit>(),
                child: AccountLandingPage(userPreferenceRepo: sl()),
              ),

              BlocProvider(
                create: (context) => sl<ProductDetailsBloc>(),
              ),
              BlocProvider(
                create: (context) => sl<ProfileCubit>(),
                child: const ProfileScreen(),
              ),
              BlocProvider(
                create: (context) => sl<CategoryCubit>(),
                child: const CategoryScreen(),
              ),
              // BlocProvider(
              //   create: (context) => sl<NewInCubit>(),
              //   // child: const NewInPage(),
              // ),
              BlocProvider(
                create: (context) =>
                    BestSellerCubit(sl<GetProductsUseCase>(), sl<AddToCart>()),
                child: const BestSellerPage(),
              ),
              BlocProvider(
                create: (context) => OffersBloc(
                  getProductsUseCase: sl<GetProductsUseCase>(),
                  addToCart: sl<AddToCart>(),
                ),
                // child: const OffersPage(),
              ),
              BlocProvider(
                create: (context) => sl<CategoryHomeCubit>(),
                child: const CategoryHomeScreen(),
              ),
              BlocProvider(
                create: (context) => sl<OrderLookupCubit>(),
                child: const OrderLookupPage(),
              ),
              BlocProvider(
                create: (context) => sl<OrdersCubit>(),
                child: const OrdersScreen(),
              ),
              BlocProvider(
                create: (context) => sl<TrackOrderCubit>(),
              ),
              BlocProvider(
                create: (context) => MapCubit(
                  userPreferenceRepo: sl<UserPreferenceRepo>(),
                ),
              ),

              BlocProvider(
                create: (context) => sl<AdScreenCubit>(),
              ),
              BlocProvider(
                create: (context) => AddressSelectionCubit(
                  userPreferenceRepo: sl<UserPreferenceRepo>(),
                  getAddressesUseCase: sl<GetAddressesUseCase>(),
                  baseRepository: sl<BaseRepository>(),
                  addNewAddressBloc: context.read<AddNewAddressBloc>(),
                )..getAddresses(),
              ),
              BlocProvider(
                create: (context) => LoginBloc(
                  authRepo: sl<AuthRepo>(),
                  userPreferenceRepo: sl<UserPreferenceRepo>(),
                ),
              ),
              BlocProvider(create: (context) => sl<WishlistCubit>()),
            ],
            child: MaterialApp(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: ThemeManager.lightTheme,
              onGenerateRoute: RouteManager.getRoute,
              home: isGCCApp
                  ? !showONBoarding
                      ? SelectCountry(
                          userPreferenceRepo: sl<UserPreferenceRepo>(),
                        )
                      : const AdScreenPage()
                  : isGCCApp
                      ? !showONBoarding
                          ? SelectCountry(
                              userPreferenceRepo: sl<UserPreferenceRepo>(),
                            )
                          : const LoginPage()
                      : const AdScreenPage(),
            ),
          ),
        );
      },
    );
  }
}
/*
InkWell(
                onTap: () async {
                  if (context.locale == const Locale("en", "US")) {
                    context.setLocale(const Locale("ar", "EG"));
                  } else {
                    context.setLocale(const Locale("en", "US"));
                  }
                },
                child: Text(context.locale == const Locale("ar", "EG") ? "العربية" : "English",
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.normal, color: Colors.deepPurple)))
 */
