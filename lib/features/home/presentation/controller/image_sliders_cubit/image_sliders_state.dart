part of 'image_sliders_cubit.dart';

@immutable
sealed class ImageSlidersState {}

final class ImageSlidersInitial extends ImageSlidersState {}

final class ImageSliderLoading extends ImageSlidersState {}

final class ImageSlidersSuccess extends ImageSlidersState {
  final List<ImageSliderEntity> imagesSlider;
  ImageSlidersSuccess(this.imagesSlider);
}

final class ImageSlidersFailure extends ImageSlidersState {
  final String error;
  ImageSlidersFailure(this.error);
}
