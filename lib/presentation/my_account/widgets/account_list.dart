import 'package:config/config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:extreme_store/app/di/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:extreme_store/app/routes/routes_constants.dart';
import 'package:extreme_store/app/utilities/country_utility.dart';
import 'package:extreme_store/data/models/setting.dart';
import 'package:extreme_store/domain/repositories/user_preference_repo.dart';
import 'package:extreme_store/presentation/my_account/model_view/account_state.dart';
import 'package:extreme_store/presentation/my_account/widgets/account_list_item.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/constants/colors_constants.dart';
import '../../../app/constants/fonts_constants.dart';
import '../../../app/constants/icon_constants.dart';
import '../../../app/constants/strings_constants.dart';
import '../../../app/constants/values_manager.dart';
import '../model_view/account_cubit.dart';
import 'delete_user_account.dart';

class AccountList extends StatefulWidget {
  const AccountList({
    super.key,
    required this.registeredUser,
    required this.userPreferenceRepo,
  });
  final bool registeredUser;
  final UserPreferenceRepo userPreferenceRepo;

  @override
  State<AccountList> createState() => _AccountListState();
}

class _AccountListState extends State<AccountList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(PaddingValues.p16),
      child: Column(
        children: [
          SizedBox(
            height: 40.h,
          ),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              widget.registeredUser
                  ? AccountListItem(
                      items: StringsConstants.profile.tr(),
                      onTap: () {
                        Navigator.of(context).pushNamed(RoutesConstant.profile);
                      })
                  : const SizedBox(),
              SizedBox(height: AppSize.s24.h),
              AccountListItem(
                items: StringsConstants.notifications.tr(),
                onTap: () {
                  Navigator.of(context).pushNamed(RoutesConstant.notifications);
                },
              ),
              isGCCApp ? SizedBox(height: AppSize.s24.h) : const SizedBox(),
              isGCCApp
                  ? AccountListItem(
                      items: StringsConstants.country.tr(),
                      onTap: () async {
                        await AccountCubit.get(context)
                            .chooseCountry(context)
                            .then((value) {
                          setState(() {});
                        });
                      },
                      postfixWidget: SizedBox(
                        height: 26.h,
                        width: 38.w,
                        child: SvgPicture.asset(CountryUtility.countriesDataList
                            .firstWhere((element) =>
                                element.id ==
                                sl<UserPreferenceRepo>().getSelectedCountryID())
                            .iconPath),
                      ),
                    )
                  : const SizedBox(),
              SizedBox(height: AppSize.s24.h),
              AccountListItem(
                items: StringsConstants.language.tr(),
                onTap: () {
                  AccountCubit.get(context).chooseLanguage(context);
                },
                postfixWidget: Text(StringsConstants.arabic.tr(),
                    style: Theme.of(context).textTheme.titleMedium!),
              ),
              SizedBox(height: AppSize.s24.h),
              AccountListItem(
                  items: StringsConstants.faqs.tr(),
                  onTap: () {
                    Navigator.of(context).pushNamed(RoutesConstant.faqs);
                  }),
              SizedBox(height: AppSize.s24.h),
              AccountListItem(
                  items: StringsConstants.privacy.tr(),
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(RoutesConstant.privacyPolicy);
                  }),
              SizedBox(height: AppSize.s24.h),
              AccountListItem(
                  items: StringsConstants.aboutApp.tr(),
                  onTap: () {
                    Navigator.of(context).pushNamed(RoutesConstant.aboutApp);
                  }),
              widget.registeredUser
                  ? SizedBox(height: AppSize.s24.h)
                  : const SizedBox(),
              widget.registeredUser
                  ? AccountListItem(
                      items: StringsConstants.signOut.tr(),
                      onTap: () {
                        AccountCubit.get(context).logOut(context);
                      },
                      itemColor: ColorsConstants.red,
                    )
                  : const SizedBox(),
              widget.registeredUser
                  ? SizedBox(height: AppSize.s16.h)
                  : const SizedBox(),
              widget.registeredUser
                  ? AccountListItem(
                      items: StringsConstants.deleteAccount.tr(),
                      itemColor: ColorsConstants.red,
                      onTap: () async {
                        await showDialog(
                          context: context,
                          builder: (context) => const DeleteUserDialog(),
                        );
                      },
                    )
                  : const SizedBox(),
            ],
          ),
          SizedBox(height: AppSize.s60.h),
          BlocBuilder<AccountCubit, AccountStates>(
            buildWhen: (previous, current) =>
                current is GetSettingsSuccessState,
            builder: (context, state) {
              return state is GetSettingsSuccessState
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 88.0.w),
                      child:
                          WidgetListFromJson(settingModel: state.settingModel),
                    )
                  : Container();
            },
          ),
          SizedBox(
            height: AppSize.s22.h,
          ),
          Text(
            StringsConstants.version.tr(),
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: FontSize.s12.sp,
                ),
          )
        ],
      ),
    );
  }
}

class WidgetListFromJson extends StatelessWidget {
  final Map<String, String> icons = {
    "snapchat": IconsConstants.snapchatIC,
    "facebook": IconsConstants.facebookIC,
    "instagram": IconsConstants.instagramIC,
    "whatsapp": IconsConstants.whatsappIC,
    "twitter": IconsConstants.twitterIC,
    "tiktok": IconsConstants.tiktokIC,
  };
  SettingModel? settingModel;

  WidgetListFromJson({required this.settingModel, super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];

    // final jsonMap = AccountCubit.get(context).settingModel?.toJson();
    final jsonMap = settingModel?.toJson();
    jsonMap?.forEach((key, value) {
      if (value != null) {
        widgetList.add(GestureDetector(
          onTap: () async {
            if (await canLaunchUrl(Uri.parse(value))) {
              await launchUrl(Uri.parse(value));
            } else {
              // throw "Could not launch ";
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Container(
                height: 22.h,
                width: 27.w,
                child: SvgPicture.asset(icons[key]!,
                    colorFilter: ColorFilter.mode(
                        ColorsConstants.iconsColor, BlendMode.srcIn))),
          ),
        ));
      }
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widgetList,
    );
  }
}
