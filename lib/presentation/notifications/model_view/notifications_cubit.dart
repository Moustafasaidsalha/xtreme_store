import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:extreme_store/presentation/notifications/model_view/notifications_states.dart';
class NotificationsCubit extends Cubit<NotificationsStates>{
  NotificationsCubit():super(InitialState());
  static NotificationsCubit get(context)=>BlocProvider.of(context);


}