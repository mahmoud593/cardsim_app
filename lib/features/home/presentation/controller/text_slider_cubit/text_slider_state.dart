part of 'text_slider_cubit.dart';

@immutable
sealed class TextSliderState {}

final class TextSliderInitial extends TextSliderState {}


final class TextSliderLoading extends TextSliderState {}

final class TextSlidersSuccess extends TextSliderState {
  final List<TextSliderEntity> textsSlider;
  TextSlidersSuccess(this.textsSlider);
}

final class TextSlidersFailure extends TextSliderState {
  final String error;
  TextSlidersFailure(this.error);
}