import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/fonts_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/routes/routes_constants.dart';
import 'package:extreme_store/data/models/users_model.dart';
import 'package:extreme_store/presentation/category/pages/category_home.dart';
import 'package:extreme_store/presentation/common_widgets/app_bars/app_bar_with_action_button.dart';
import 'package:extreme_store/presentation/common_widgets/buttons/reusable_outlined_button.dart';
import 'package:extreme_store/presentation/common_widgets/dialogs/dialogs.dart';
import 'package:extreme_store/presentation/common_widgets/text_fields/rounded_text_field.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_states.dart';
import 'package:extreme_store/presentation/profile/model_view/profile_cubit.dart';
import 'package:extreme_store/presentation/profile/model_view/profile_states.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    ProfileCubit.get(context).getProfile();
  }
@override
  void dispose() {
  ProfileCubit.get(context).firstNameController.clear();
  ProfileCubit.get(context).emailController.clear();
  ProfileCubit.get(context).lastNameController.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarWithActionButton(title: StringsConstants.profile.tr()),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: BlocConsumer<ProfileCubit, ProfileStates>(
          listenWhen: (previous, current) {
            return previous.editProfileState != current.editProfileState;
          },
          listener: (context, state) {
            if (state.editProfileState == RequestStates.error) {
              showCustomSnackBar(context, state.message);
            } else if (state.editProfileState == RequestStates.success) {
              showCustomSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            switch (state.getProfileState) {
              case RequestStates.loading:
                return const ShimmerLoader();

              case RequestStates.success:
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.h),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: Text(
                        StringsConstants.phoneNumber.tr(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    RoundedTextField(
                      isEnabled: false,
                      hintText: state.profilesModel?.userProfile?.phones?[0].phone ??
                          StringsConstants.noPhoneRegistered.tr(),
                    ),
                    SizedBox(height: 24.h),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: Text(
                        StringsConstants.email.tr(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    RoundedTextField(
                      textEditingController: ProfileCubit.get(context).emailController,
                      isEnabled: true,
                      hintText: state.profilesModel?.userProfile?.email ?? StringsConstants.noEmailRegistered.tr(),
                    ),
                    SizedBox(height: 24.h),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: Text(
                        StringsConstants.firstName.tr(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    RoundedTextField(
                      textEditingController: ProfileCubit.get(context).firstNameController,
                      isEnabled: true,
                      hintText: state.profilesModel?.userProfile?.firstName ?? StringsConstants.noFirstname.tr(),
                    ),
                    SizedBox(height: 24.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        StringsConstants.lastName.tr(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    RoundedTextField(
                      textEditingController: ProfileCubit.get(context).lastNameController,
                      isEnabled: true,
                      hintText: state.profilesModel?.userProfile?.lastName ??  StringsConstants.lastName.tr(),
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      children: [
                        Expanded(
                            child: ReusableOutlinedButton(
                          title: "Change your pin",
                          onPressed: (){
                            Navigator.of(context).pushNamed(RoutesConstant.changePin);
                          },
                          backGroundColor: ColorsConstants.white,
                          foreGroundColor: ColorsConstants.black,
                        )),
                      ],
                    ),
                    const Expanded(child: SizedBox()),
                    MainButton(
                        margin: 10.w,
                        height: 58.h,
                        radius: 10.r,
                        onPressed: () {
                          ProfileCubit.get(context).editProfile(EditProfileModel(
                              ProfileCubit.get(context).emailController.text.isEmpty
                                  ? state.profilesModel?.userProfile?.email
                                  : ProfileCubit.get(context).emailController.text,
                              ProfileCubit.get(context).firstNameController.text.isEmpty
                                  ? state.profilesModel?.userProfile?.firstName
                                  : ProfileCubit.get(context).firstNameController.text,
                              ProfileCubit.get(context).lastNameController.text.isEmpty
                                  ? state.profilesModel?.userProfile?.lastName
                                  : ProfileCubit.get(context).lastNameController.text));
                        },
                        color: ColorsConstants.black,
                        text: StringsConstants.confirm.tr(),
                        textStyle: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: FontSize.s16, color: ColorsConstants.white)),
                    const SizedBox(height: 28)
                  ],
                );
              case RequestStates.error:
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 47.h),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: Text(
                        StringsConstants.phoneNumber.tr(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    RoundedTextField(
                      isEnabled: false,
                      hintText: state.profilesModel?.userProfile?.phones?[0].phone ??
                          StringsConstants.noPhoneRegistered.tr(),
                    ),
                    SizedBox(height: 24.h),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: Text(
                        StringsConstants.email.tr(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    RoundedTextField(
                      textEditingController: ProfileCubit.get(context).emailController,
                      isEnabled: true,
                      hintText: state.profilesModel?.userProfile?.email ??  StringsConstants.noEmailRegistered.tr(),
                    ),
                    SizedBox(height: 24.h),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: Text(
                        StringsConstants.firstName.tr(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    RoundedTextField(
                      textEditingController: ProfileCubit.get(context).firstNameController,
                      isEnabled: true,
                      hintText: state.profilesModel?.userProfile?.firstName ?? StringsConstants.noFirstname.tr(),
                    ),
                    SizedBox(height: 24.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        StringsConstants.lastName.tr(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    RoundedTextField(
                      textEditingController: ProfileCubit.get(context).lastNameController,
                      isEnabled: true,
                      hintText: state.profilesModel?.userProfile?.lastName ??  StringsConstants.noLastname.tr(),
                    ),
                    SizedBox(height: 220.h),
                    MainButton(
                        margin: 10.w,
                        height: 58.h,
                        radius: 10.r,
                        onPressed: () {
// ProfileCubit.get(context).editProfile(token, id, userModel)
                          ProfileCubit.get(context).editProfile(EditProfileModel(
                              ProfileCubit.get(context).emailController.text.isEmpty
                                  ? state.profilesModel?.userProfile?.email
                                  : ProfileCubit.get(context).emailController.text,
                              ProfileCubit.get(context).firstNameController.text.isEmpty
                                  ? state.profilesModel?.userProfile?.firstName
                                  : ProfileCubit.get(context).firstNameController.text,
                              ProfileCubit.get(context).lastNameController.text.isEmpty
                                  ? state.profilesModel?.userProfile?.lastName
                                  : ProfileCubit.get(context).lastNameController.text,
                            ));
                        },
                        color: ColorsConstants.black,
                        text: StringsConstants.confirm.tr(),
                        textStyle: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: FontSize.s16, color: ColorsConstants.white))
                  ],
                );
            }
          },
        ),
      ),
    );
  }
}
