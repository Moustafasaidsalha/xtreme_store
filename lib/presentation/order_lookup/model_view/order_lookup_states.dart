import 'package:equatable/equatable.dart';

abstract class OrderLookupStates extends Equatable {}

class InitialState extends OrderLookupStates {
  @override
  List<Object> get props => [];
}