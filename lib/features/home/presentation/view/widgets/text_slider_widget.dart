import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:marquee/marquee.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../styles/colors/color_manager.dart';
import '../../../../../styles/text_styles/text_styles.dart';
import '../../../domain/entities/text_slider_entity.dart';
import '../../controller/text_slider_cubit/text_slider_cubit.dart';

class TextSliderWidget extends StatelessWidget {
  const TextSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TextSliderCubit, TextSliderState>(
      builder: (context, state) {
        if (state is TextSliderLoading) {
          return SizedBox(
            height: 40,
            width: double.infinity,
            child: Shimmer.fromColors(
              baseColor: UserDataFromStorage.themeIsDarkMode? ColorManager.darkThemeBackground :Colors.grey.shade300,
              highlightColor: UserDataFromStorage.themeIsDarkMode?ColorManager.darkThemeBackgroundLight:Colors.grey.shade100,
              direction:  ShimmerDirection.rtl,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: UserDataFromStorage.themeIsDarkMode? ColorManager.darkThemeBackground :Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          );
        } else if (state is TextSlidersFailure) {
          return Center(child: Text("Error: ${state.error}"));
        } else if (state is TextSlidersSuccess) {
          final List<TextSliderEntity> texts = state.textsSlider;
          if (texts.isEmpty) {
            return const Center(child: Text("No texts available"));
          }

          final combinedText = texts.map((e) => e.content).join("   |   ");

          return Container(
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorManager.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Marquee(
                text: combinedText,
                style: TextStyles.textStyle18Medium.copyWith(color: Colors.white),
                scrollAxis: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.center,
                blankSpace: 50.0,
                velocity: 90.0,
                startPadding: 10.0,
              ),
            ),
          );
        } else {
          return const Center(child: Text("Unexpected state"));
        }
      },
    );
  }
}
