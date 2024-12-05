import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/text_slider_entity.dart';
import '../../../domain/repos/home_repo.dart';



part 'text_slider_state.dart';

class TextSliderCubit extends Cubit<TextSliderState> {
  TextSliderCubit(this.homeRepo) : super(TextSliderInitial());

  final HomeRepo homeRepo;
  Future<void> getTextSlider() async {
    emit(TextSliderLoading());
    final result = await homeRepo.getTextSlider();
    result.fold(
          (l) => emit(TextSlidersFailure(l.error)),
          (r) {
            print(r);
        emit(TextSlidersSuccess(r));
      },
    );
  }
}
