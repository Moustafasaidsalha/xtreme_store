import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/domain/repositories/user_preference_repo.dart';
import 'package:extreme_store/presentation/my_account/pages/unregistered_account_page.dart';
import 'package:extreme_store/presentation/my_account/pages/registered_account_page.dart';

import '../../../app/di/injection_container.dart';
import '../model_view/account_cubit.dart';

class AccountLandingPage extends StatefulWidget {
  final UserPreferenceRepo userPreferenceRepo;
  const AccountLandingPage({super.key, required this.userPreferenceRepo});

  @override
  State<AccountLandingPage> createState() => _AccountLandingPageState();
}

class _AccountLandingPageState extends State<AccountLandingPage> {
  bool isUserFounded = false;
  String userName = '';
  @override
  void initState() {
    super.initState();
    // AccountCubit.get(context).getSettings();
    String accessToken = widget.userPreferenceRepo.getAccessToken();
    userName = widget.userPreferenceRepo.getUserName();
    if (accessToken.isNotEmpty) {
      isUserFounded = true;
    } else {
      isUserFounded = false;
    }
  }

  @override
  Widget build(BuildContext context) {


    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AccountCubit>()..getSettings(),
        ),
      ],
      child: Scaffold(
appBar: AppBar(


  toolbarHeight: 0,
  backgroundColor: ColorsConstants.black,


),
        body: isUserFounded
            ? RegisteredAccountPage(
          userName: userName,
        )
            : UnRegisteredAccountPage(
          userName: userName,
        ),
      ),
    );
  }
}
