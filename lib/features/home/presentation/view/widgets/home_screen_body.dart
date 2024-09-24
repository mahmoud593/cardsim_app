import 'package:flutter/material.dart';
import 'package:games_app/features/home/presentation/view/widgets/dealings_list_view.dart';
import 'package:games_app/generated/assets.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';
import 'package:games_app/styles/widets/custom_search_field.dart';

import '../../../../../core/constants/constants.dart';
import 'offers_grid_view.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 8,
            ),
            const Text('مساء الخير, Mazen Gamal !'),
            const SizedBox(
              height: 16,
            ),
            const DealingsListView(),
            const SizedBox(
              height: 16,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(Constants.defaultRadius),
              child: Image.asset(
                Assets.imagesCardSim,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: ColorManager.primary,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Center(
              child: Text(
                ' جميع العروض',
                style: TextStyles.textStyle24Bold,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 40,
              child: CustomSearchField(
                controller: searchController,
                hintText: 'البحث...',
                suffixIcon: Icons.search,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            const OffersGridView(),
          ],
        ),
      ),
    );
  }
}


