import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/core/helper/material_navigation.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/features/auth/presentation/view/screens/login_screen.dart';
import 'package:games_app/features/auth/presentation/view/screens/register_screen.dart';
import 'package:games_app/features/home/presentation/controller/companies_cubit/companies_cubit.dart';
import 'package:games_app/features/home/presentation/view/widgets/dealings_list_view.dart';
import 'package:games_app/features/home/presentation/view/widgets/image_carousal_widget.dart';
import 'package:games_app/features/home/presentation/view/widgets/text_slider_widget.dart';
import 'package:games_app/generated/assets.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';
import 'package:games_app/styles/widgets/custom_search_field.dart';
import 'package:games_app/styles/widgets/default_button.dart';

import '../../../../../core/constants/constants.dart';
import 'categories_list_view.dart';
import 'offers_grid_view.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if(UserDataFromStorage.userTokenFromStorage !='')
          Text(
            ' مساء الخير, ${UserDataFromStorage.fullNameFromStorage}',
            style: TextStyles.textStyle18Bold.copyWith(),
          ),
          if(UserDataFromStorage.userTokenFromStorage !='')
            const SizedBox(height: 5,),
          if(UserDataFromStorage.userTokenFromStorage !='')
            const SizedBox(height: 16,),
          if(UserDataFromStorage.userTokenFromStorage !='')
            const DealingsListView(),
          if(UserDataFromStorage.userTokenFromStorage !='')
            const SizedBox(height: 16,),
          if(UserDataFromStorage.userTokenFromStorage =='')
          Row(
            mainAxisAlignment:  MainAxisAlignment.center,
            children: [
              Expanded(
                child: DefaultButton(
                    onPressed: () {
                      customPushNavigator(context, const LoginScreen());
                    },
                    borderRadius: BorderRadius.circular(25),
                    backgroundColor: ColorManager.primary,
                    text: 'تسجيل دخول',
                ),
              ),
              const SizedBox( width: 16,),
              Expanded(
                child: DefaultButton(
                  onPressed: () {
                    customPushNavigator(context, const RegisterScreen());
                  },
                  foregroundColor: Colors.black,
                  borderRadius: BorderRadius.circular(25),
                  backgroundColor: Colors.grey[200],
                  text: 'انشاء حساب',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16,),
          const ImageCarousalWidget(),
          const SizedBox(
            height: 16,
          ),
          const TextSliderWidget(),

          // Center(
          //   child: Text(
          //     ' جميع العروض',
          //     style: TextStyles.textStyle24Bold,
          //   ),
          // ),
          const SizedBox(
            height: 16,
          ),
          BlocBuilder<CompaniesCubit, CompaniesState>(
            builder: (context, state) {
              return SizedBox(
                height: 40,
                child: CustomSearchField(
                  controller: searchController,
                  hintText: 'البحث...',
                  suffixIcon: Icons.search,
                  onClear: (){
                    if (searchController.text.isNotEmpty) {
                      searchController.clear();
                      context.read<CompaniesCubit>().getCompanies(query: searchController.text);
                    }
                  },
                  onSubmitted: (value) {
                    if (searchController.text.isNotEmpty) {
                      context.read<CompaniesCubit>()
                          .getCompanies(query: searchController.text);
                    }
                  },
                  onChanged: (value) {
                    context
                        .read<CompaniesCubit>()
                        .getCompanies(query: searchController.text);
                  },
                ),
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          const CategoriesListView(),
          const SizedBox(
            height: 60,
          ),
          const OffersGridView(),
        ],
      ),
    );
  }
}


