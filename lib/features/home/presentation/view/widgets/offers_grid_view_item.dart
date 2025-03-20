import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/core/constants/constants.dart';
import 'package:games_app/core/helper/material_navigation.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/features/home/domain/entities/companies_entity.dart';
import 'package:games_app/features/home/presentation/controller/theme_cubit/theme_cubit.dart';
import 'package:games_app/features/home/presentation/view/widgets/request_order_screen.dart';
import 'package:games_app/styles/colors/color_manager.dart';

import '../../../../auth/presentation/view/screens/login_screen.dart';

class OffersGridViewItem extends StatelessWidget {
  const OffersGridViewItem({super.key, required this.companiesEntity});

  final CompaniesEntity companiesEntity;

  @override
  Widget build(BuildContext context) {
    final isInactive = companiesEntity.status == "inactive";

    return GestureDetector(
      onTap: isInactive
          ? null
          : () {
        if(UserDataFromStorage.userTokenFromStorage !=''){
          customPushNavigator(context, RequestOrderScreen(companiesEntity: companiesEntity,),);
        }else{
          showDialog(
              context: context,
              builder: (context) => BlocBuilder<ThemeCubit,ThemeState>(
                  builder: (context, state) {
                    return AlertDialog(
                        backgroundColor: UserDataFromStorage.themeIsDarkMode==false? ColorManager.white: ColorManager.darkThemeBackgroundLight,
                        title: Text('تنبيه',style: TextStyle(
                            color: UserDataFromStorage.themeIsDarkMode==false? ColorManager.textColor :
                            ColorManager.white
                        ),),
                        content: Text('تحتاج الي تسجيل الدخول لاستخدام التطبيق',style: TextStyle(
                            color: UserDataFromStorage.themeIsDarkMode==false? ColorManager.textColor :
                            ColorManager.white
                        ),),
                        actions: [
                          TextButton(
                            child:  const Text('تسجيل الدخول',style: TextStyle(
                                color:ColorManager.primary
                            ),),
                            onPressed: () {
                              Navigator.pop(context);
                              customPushNavigator(context, const LoginScreen());
                            },
                          ),
                          TextButton(
                            child: const Text('الغاء',style: TextStyle(color: Colors.red),),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ]
                    );
                  }
              )
          );
        }
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 120,
            width: 150,
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 30,
                  spreadRadius: -30,
                  offset: Offset(0, 5))
            ]),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Constants.defaultRadius),
              ),
              surfaceTintColor: Colors.white,
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          companiesEntity.name,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 25,
            left: 8.5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: ColorFiltered(colorFilter: isInactive
                  ? const ColorFilter.mode(
                Colors.grey, // Converts to grayscale
                BlendMode.saturation,
              )
                  : const ColorFilter.mode(
                Colors.transparent,
                BlendMode.multiply,
              ),
                child: CachedNetworkImage(
                  imageUrl: companiesEntity.image,
                  scale: 1.88,
                  errorWidget: (context, url, error) =>
                  const Icon(Icons.error),
                ),
              ),
            ),
          ),
          if(isInactive)
          Positioned(
            bottom: 40,
            left: 8.5,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: ColorManager.gray,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Constants.defaultRadius),
                  bottomRight: Radius.circular(Constants.defaultRadius),
                ),
              ),
              child: const Text(
                'غير متوفره',
                style: TextStyle(
                    fontSize: 12,
                    color: ColorManager.primary
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
