
import 'package:equatable/equatable.dart';

sealed class OffersEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class OffersFetched extends OffersEvent {}