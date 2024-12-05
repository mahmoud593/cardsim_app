import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/home/domain/entities/settings_entity.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/image_slider_entity.dart';
import '../../../domain/entities/text_slider_entity.dart';
import '../../../domain/repos/home_repo.dart';

part 'image_sliders_state.dart';

class ImageSlidersCubit extends Cubit<ImageSlidersState> {
  ImageSlidersCubit(this.homeRepo) : super(ImageSlidersInitial());

  final HomeRepo homeRepo;


  Future<void> getImageSlider() async {
    emit(ImageSliderLoading());
    final result = await homeRepo.getImageSlider();
    result.fold(
      (l) => emit(ImageSlidersFailure(l.error)),
      (r) {
        emit(ImageSlidersSuccess(r));
      },
    );
  }


}
