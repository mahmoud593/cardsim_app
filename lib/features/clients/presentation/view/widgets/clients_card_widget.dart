import 'package:flutter/material.dart';
import 'package:games_app/core/helper/app_size_config.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';


class ClientsCardWidget extends StatelessWidget {
  final String createdAt;
  final String email;
  final String username;
  final num balance;
  final int rate;
  final String phone;

  const ClientsCardWidget({
    super.key,
    required this.email,
    required this.username,
    required this.balance,
    required this.rate,
    required this.createdAt,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.of(context).brightness == Brightness.light;
    return Card(
      elevation: 4.0,
      color: isLight? ColorManager.primary: ColorManager.darkThemeBackgroundLight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SizeConfig.height * 0.01)),
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.height * 0.015),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'الرصيد: \$ $balance',
                  style: TextStyles.textStyle14Medium.copyWith(
                    color:  ColorManager.white
                  ),
                ),

                Text(
                  'نسبه الربح: \$ $rate',
                  style: TextStyles.textStyle14Medium.copyWith(
                      color:UserDataFromStorage.themeIsDarkMode? ColorManager.success:  ColorManager.secondPrimary
                  ),
                ),
              ],
            ),



            const Divider(),

            // Payment method and amount
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'الاسم: $username',
                  style: TextStyles.textStyle14Medium.copyWith(
                      color:  ColorManager.white
                  ),
                ),
              ],
            ),

            SizedBox(height: SizeConfig.height * 0.01),


            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment:  CrossAxisAlignment.start,
              children: [
                Text(
                  'الايميل: $email',
                  style: TextStyles.textStyle14Medium.copyWith(
                      color:  ColorManager.white
                  ),
                ),

                SizedBox(height: SizeConfig.height * 0.01),

                Text(
                  'الهاتف : $phone',
                  style: TextStyles.textStyle14Medium.copyWith(
                      color:  ColorManager.white
                  ),
                ),

                SizedBox(height: SizeConfig.height * 0.01),

                Text(
                  'تاريخ الإنشاء: $createdAt',
                  style: TextStyles.textStyle14Medium.copyWith(
                      color: UserDataFromStorage.themeIsDarkMode? ColorManager.lightGrey :  ColorManager.darkGrey
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }



}
