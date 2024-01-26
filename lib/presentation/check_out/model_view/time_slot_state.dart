import 'package:equatable/equatable.dart';
import 'package:extreme_store/app/enums/state_status.dart';
import 'package:extreme_store/data/models/time_slot_models/interval_hours_model.dart';

class TimeSlotState extends Equatable {
  final StateStatus dayState;
  final StateStatus timeState;
  final String message;
  final List<DateTime> blackoutDates;
  final List<int> weekends;
  final List<IntervalHoursModel> intervalHoursList;
  final IntervalHoursModel selectedInterval;
  final String selectedDay;

  const TimeSlotState({
    this.dayState = StateStatus.initial,
    this.timeState = StateStatus.initial,
    this.message = '',
    this.blackoutDates = const [],
    this.weekends = const [],
    this.intervalHoursList = const [],
    this.selectedInterval = const IntervalHoursModel(),
    this.selectedDay = '',
  });

  TimeSlotState copyWith({
    StateStatus? dayState,
    StateStatus? timeState,
    String? message,
    List<DateTime>? blackoutDates,
    List<int>? weekends,
    List<IntervalHoursModel>? intervalHoursList,
    IntervalHoursModel? selectedInterval,
    String? selectedDay,
  }) {
    return TimeSlotState(
      dayState: dayState ?? this.dayState,
      timeState: timeState ?? this.timeState,
      message: message ?? this.message,
      blackoutDates: blackoutDates ?? this.blackoutDates,
      intervalHoursList: intervalHoursList ?? this.intervalHoursList,
      weekends: weekends ?? this.weekends,
      selectedInterval: selectedInterval ?? this.selectedInterval,
      selectedDay: selectedDay ?? this.selectedDay,
    );
  }

  @override
  List<Object?> get props => [
        dayState,
        timeState,
        message,
        blackoutDates,
        intervalHoursList,
        weekends,
        selectedInterval,
        selectedDay,
      ];
}
