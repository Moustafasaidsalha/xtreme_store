import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/enums/state_status.dart';
import 'package:extreme_store/app/routes/routes_constants.dart';
import 'package:extreme_store/presentation/authentication/widgets/custom_loader.dart';
import 'package:extreme_store/presentation/check_out/model_view/time_slot_cubit.dart';
import 'package:extreme_store/presentation/check_out/model_view/time_slot_state.dart';
import 'package:extreme_store/presentation/check_out/pages/payment_method_page.dart';
import 'package:extreme_store/presentation/check_out/widgets/interval_hour_widget.dart';
import 'package:extreme_store/presentation/common_widgets/buttons/reusable_elevated_button.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../app/constants/icon_constants.dart';
import '../../../domain/entity/cart_entity.dart';
import '../../common_widgets/empty_states/empty_state_without_button.dart';

class TimeSlotArgs {
  final int addressID;
  final int cartID;
  final CartEntity cartEntity;

  TimeSlotArgs({
    required this.addressID,
    required this.cartID,
    required this.cartEntity,
  });
}

class TimeSlotPage extends StatelessWidget {
  final TimeSlotArgs timeSlotArgs;
  const TimeSlotPage({super.key, required this.timeSlotArgs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          StringsConstants.checkOut.tr(),
        ),
      ),
      body: BlocBuilder<TimeSlotCubit, TimeSlotState>(
        builder: (context, state) {
          if (state.dayState == StateStatus.success) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: ColorsConstants.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(9),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.r, vertical: 12.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  StringsConstants.selectDate.tr(),
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                // ReusableOutlinedButton(
                                //   title: StringsConstants.clear,
                                //   backGroundColor: ColorsConstants.lighterGray,
                                //   foreGroundColor: ColorsConstants.darkerGray,
                                //   roundedCorner: 9.r,
                                //   onPressed: () {
                                //     print("clear");
                                //     context.read<TimeSlotCubit>().clearSelection();
                                //   },
                                // ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.r),
                              child: const Divider(),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.r),
                              child: SfDateRangePicker(
                                enablePastDates: false,
                                view: DateRangePickerView.month,
                                selectionMode: DateRangePickerSelectionMode.single,
                                selectionShape: DateRangePickerSelectionShape.rectangle,
                                selectionColor: Colors.amber,
                                monthViewSettings: DateRangePickerMonthViewSettings(
                                  blackoutDates: state.blackoutDates,
                                  weekendDays: state.weekends,
                                ),
                                toggleDaySelection: false,
                                selectableDayPredicate: (DateTime date) {
                                  if (state.weekends.contains(date.weekday)) {
                                    return false;
                                  }
                                  return true;
                                },
                                onSelectionChanged: (dateRangePickerSelectionChangedArgs) {
                                  context.read<TimeSlotCubit>().getIntervalHoursForDay(
                                        day: dateRangePickerSelectionChangedArgs.value,
                                      );
                                },
                                monthCellStyle: DateRangePickerMonthCellStyle(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15.sp,
                                    color: ColorsConstants.black,
                                  ),
                                  // todayCellDecoration: const BoxDecoration(),
                                  todayCellDecoration: BoxDecoration(
                                    border: Border.all(color: Colors.amber),
                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                    shape: BoxShape.rectangle,
                                  ),
                                  todayTextStyle: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  leadingDatesDecoration: BoxDecoration(
                                    color: const Color(0xFFDFDFDF),
                                    border: Border.all(
                                      color: const Color(0xFFB6B6B6),
                                      width: 1.r,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  disabledDatesTextStyle: const TextStyle(
                                    color: Color(0xFFB6B6B6),
                                  ),
                                  disabledDatesDecoration: BoxDecoration(
                                    color: const Color(0xFFDFDFDF).withOpacity(0.2),
                                    shape: BoxShape.rectangle,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  StringsConstants.selectDate.tr(),
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                const SizedBox(width: 5),
                                BlocSelector<TimeSlotCubit, TimeSlotState, StateStatus>(
                                  selector: (state) => state.timeState,
                                  builder: (context, state) {
                                    return state == StateStatus.loading
                                        ? const CupertinoActivityIndicator()
                                        : const SizedBox();
                                  },
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.r),
                              child: const Divider(),
                            ),
                            const Expanded(
                              child: IntervalsWidget(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  PlaceOrderButton(timeSlotArgs: timeSlotArgs),
                  SizedBox(height: 28.r),
                ],
              ),
            );
          } else if (state.dayState == StateStatus.failure) {
            return EmptyStateWithOutButton(
              icon: IconsConstants.notFoundPageIC,
              title: StringsConstants.pageNotFoundTitle.tr(),
              subTitle: StringsConstants.pageNotFoundTitle.tr(),
            );
          } else if (state.dayState == StateStatus.loading) {
            return const Center(child: CustomLoader());
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

class IntervalsWidget extends StatelessWidget {
  const IntervalsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimeSlotCubit, TimeSlotState>(
      builder: (context, state) {
        if (state.timeState == StateStatus.success) {
          return GridView.builder(
            itemCount: state.intervalHoursList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 22.r,
              crossAxisSpacing: 10.r,
              childAspectRatio: 1.7.r,
              crossAxisCount: 3,
            ),
            itemBuilder: (context, index) {
              bool isAvailable = context.read<TimeSlotCubit>().isTimeSlotIsAvailable(
                    selectedDay: state.selectedDay,
                    hoursModel: state.intervalHoursList[index],
                  );
              String from = context.read<TimeSlotCubit>().getFormattedTime(state.intervalHoursList[index].from ?? '');
              String to = context.read<TimeSlotCubit>().getFormattedTime(state.intervalHoursList[index].to ?? '');
              bool isSelected = state.selectedInterval.id == (state.intervalHoursList[index].id ?? 0);
              return GestureDetector(
                onTap:isAvailable? () {
                  context.read<TimeSlotCubit>().selectIntervalHour(
                        intervalHoursModel: state.intervalHoursList[index],
                      );
                }:null,
                child: IntervalHourWidget(
                  from: from,
                  to: to,
                  isSelected: isSelected,
                  isAvailable: isAvailable,
                ),
              );
            },
          );
        } else if (state.timeState == StateStatus.failure) {
          return Text(state.message);
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class PlaceOrderButton extends StatelessWidget {
  final TimeSlotArgs timeSlotArgs;
  const PlaceOrderButton({
    super.key,
    required this.timeSlotArgs,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimeSlotCubit, TimeSlotState>(
      buildWhen: (previous, current) {
        return previous.selectedInterval != current.selectedInterval;
      },
      builder: (context, state) {
        return ReusableElevatedButton(
          title: StringsConstants.placeOrder.tr(),
          onPressed: state.selectedInterval.id != null
              ? () {
                  Navigator.of(context).pushNamed(RoutesConstant.paymentMethod,
                      arguments: PaymentMethodArgs(
                        addressID: timeSlotArgs.addressID,
                        cartID: timeSlotArgs.cartID,
                        cartEntity: timeSlotArgs.cartEntity,
                        intervalHourID: state.selectedInterval.id ?? 0,
                        selectedDay: state.selectedDay,
                        isAllDigital: false
                      ));
                }
              : null,
        );
      },
    );
  }
}
