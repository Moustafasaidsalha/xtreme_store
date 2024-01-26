import 'package:equatable/equatable.dart';
import 'package:extreme_store/data/models/settings/static_page_response_model.dart';

enum StaticPageType { about, faqs, Privacy }

abstract class StaticPageStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitStaticPage extends StaticPageStates {}

class LoadingStaticPage extends StaticPageStates {}

class FailureStaticPage extends StaticPageStates {
  final String message;

  FailureStaticPage({required this.message});

  @override
  List<Object?> get props => [message];
}

class SuccessStaticPage extends StaticPageStates {
  final List<StaticPageModel> data;

  SuccessStaticPage({required this.data});

  @override
  List<Object?> get props => [data];
}
