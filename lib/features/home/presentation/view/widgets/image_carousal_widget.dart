import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:shimmer/shimmer.dart'; // Import shimmer package
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/constants/constants.dart';
import '../../../domain/entities/image_slider_entity.dart';
import '../../controller/image_sliders_cubit/image_sliders_cubit.dart';

class ImageCarousalWidget extends StatelessWidget {
  const ImageCarousalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageSlidersCubit, ImageSlidersState>(
      builder: (context, state) {
        if (state is ImageSliderLoading) {
          // Show shimmer skeleton loader while loading
          return SizedBox(
            height: 180,
            child: Shimmer.fromColors(
              baseColor:UserDataFromStorage.themeIsDarkMode? ColorManager.darkThemeBackground :Colors.grey.shade300,
              highlightColor: UserDataFromStorage.themeIsDarkMode?ColorManager.darkThemeBackgroundLight:Colors.grey.shade100,
              direction: ShimmerDirection.rtl,
              child: Skeletonizer(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3, // Show placeholder for 3 items
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(Constants.defaultRadius),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          color: UserDataFromStorage.themeIsDarkMode? ColorManager.darkThemeBackground :Colors.grey.shade300,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        } else if (state is ImageSlidersFailure) {
          return Center(child: Text("Error: ${state.error}"));
        } else if (state is ImageSlidersSuccess) {
          final List<ImageSliderEntity> images = state.imagesSlider;
          if (images.isEmpty) {
            return const Center(child: Text("No images available"));
          }

          return CarouselSlider(
            items: images.map((image) {
              return Builder(
                builder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(Constants.defaultRadius),
                      child: Image.network(
                        image.imageUrl,
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.error, size: 50);
                        },
                      ),
                    ),
                  );
                },
              );
            }).toList(),
            options: CarouselOptions(
              autoPlay: true,
              height: 180,
              enableInfiniteScroll: false,
              aspectRatio: 16 / 9,
              viewportFraction: 1,
            ),
          );
        } else {
          return const Center(child: Text("Unexpected state"));
        }
      },
    );
  }
}
