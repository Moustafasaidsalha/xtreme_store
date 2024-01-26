import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/domain/repositories/base_repository.dart';
import 'package:extreme_store/presentation/static_pages/model_view/static_page_state.dart';

class StaticPageCubit extends Cubit<StaticPageStates> {
  final BaseRepository baseRepository;

  StaticPageCubit({required this.baseRepository}) : super(InitStaticPage());

  Future<void> getStaticPage({required String type}) async {
    emit(LoadingStaticPage());
    final res = await baseRepository.getStaticPAge(type: type);
    res.fold(
      (l) => emit(FailureStaticPage(message: l.message)),
      (r) {
        if (r.flag ?? false) {
          emit(SuccessStaticPage(data: r.data ?? []));
        } else {
          emit(FailureStaticPage(message: StringsConstants.someThingWrong));
        }
      },
    );
  }
}
