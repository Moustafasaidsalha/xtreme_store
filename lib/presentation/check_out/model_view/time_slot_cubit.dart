import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/enums/state_status.dart';
import 'package:extreme_store/data/models/time_slot_models/interval_hours_model.dart';
import 'package:extreme_store/domain/uses_cases/time_slot/get_block_date.dart';
import 'package:extreme_store/domain/uses_cases/time_slot/get_interval_hours.dart';
import 'package:extreme_store/presentation/check_out/model_view/time_slot_state.dart';

import '../../../app/use_case/use_case.dart';

class TimeSlotCubit extends Cubit<TimeSlotState> {
  TimeSlotCubit({
    required this.getBlockDates,
    required this.getIntervalHours,
  }) : super(const TimeSlotState());

  final GetBlockDates getBlockDates;
  final GetIntervalHours getIntervalHours;

  Future<void> getBlackOutDates() async {
    if (state.dayState != StateStatus.initial) {
      emit(state.copyWith(dayState: StateStatus.loading));
    }
    final res = await getBlockDates(NoParams());
    return res.fold(
      (l) {
        emit(state.copyWith(dayState: StateStatus.failure, message: l.message));
      },
      (r) {
        if (r.flag ?? false) {
          final List<DateTime> dates = r.blockDateDataModel?.blockDates?.map((d) {
                return DateTime.parse(d.date ?? '');
              }).toList() ??
              [];
          final List<int> weekends = r.blockDateDataModel?.daysOff?.map((d) {
                int x = d.id ?? -1;
                if (x - 1 <= 0) {
                  return 1;
                } else {
                  return x - 1;
                }
              }).toList() ??
              [];
          emit(state.copyWith(
            dayState: StateStatus.success,
            blackoutDates: dates,
            weekends: weekends,
          ));
        } else {
          emit(state.copyWith(
            dayState: StateStatus.failure,
            message: StringsConstants.someThingWrong,
            weekends: [],
            blackoutDates: [],
            intervalHoursList: [],
          ));
        }
      },
    );
  }

  Future<void> getIntervalHoursForDay({required DateTime day}) async {
    emit(state.copyWith(timeState: StateStatus.loading));

    final res = await getIntervalHours(GetIntervalHoursParams(date: day.toIso8601String()));
    return res.fold(
      (l) {
        emit(state.copyWith(
          timeState: StateStatus.failure,
          message: l.message,
          intervalHoursList: [],
          selectedInterval:  const IntervalHoursModel(),
        ));
      },
      (r) {
        emit(state.copyWith(
          timeState: StateStatus.success,
          intervalHoursList: r,
          selectedDay: day.toIso8601String(),
          selectedInterval: const IntervalHoursModel(),
        ));
      },
    );
  }

  Future<void> selectIntervalHour({required IntervalHoursModel intervalHoursModel}) async {
    emit(state.copyWith(selectedInterval: intervalHoursModel));
  }

  String getFormattedTime(String value) {
    if (value.length > 3) {
      return value.substring(0, value.length - 3);
    } else {
      return value;
    }
  }

  bool isTimeSlotInThePast({required String selectedDay, required String selectedTime}) {
    DateTime selectedDate = DateTime.parse(selectedDay);
    int h = int.parse(selectedTime.substring(0, 2));
    int m = int.parse(selectedTime.substring(3, 5));
    DateTime selectedDateWithSelectHour = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, h, m);
    bool isInThePast = selectedDateWithSelectHour.isBefore(DateTime.now());
    return isInThePast ? true : false;
  }

  // bool isTimeSlotHaveCapacity({required IntervalHoursModel hoursModel}) {
  //   return ((hoursModel.count ?? 0) > 0) ? true : false;
  // }

  bool isTimeSlotIsAvailable({
    required String selectedDay,
    required IntervalHoursModel hoursModel,
  }) {
    bool isInThePast = isTimeSlotInThePast(
      selectedDay: selectedDay,
      selectedTime: hoursModel.from ?? "00:00:00",
    );
    // bool haveCapacity = isTimeSlotHaveCapacity(hoursModel: hoursModel);
    // log("isInThePast $isInThePast haveCapacity $haveCapacity");
    return !isInThePast && !(hoursModel.isComplete ?? true);
  }
}
