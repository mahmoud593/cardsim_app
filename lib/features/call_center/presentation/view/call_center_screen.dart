import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:games_app/features/our_agent/presentation/cubit/our_agent_cubit.dart';
import 'package:games_app/features/our_agent/presentation/cubit/our_agent_state.dart';
import 'package:games_app/features/our_agent/presentation/view/widget/our_agent_widget.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';

import '../../../../core/helper/app_size_config.dart';

class CallCenterScreen extends StatelessWidget {
  const CallCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OurAgentCubit, OurAgentStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'الدعم الفني',
              style: TextStyles.textStyle24Medium,
            ),
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: ColorManager.black,
              ),
            ),
            centerTitle: true,
          ),
          body: Container(
            height: SizeConfig.height,
            width: SizeConfig.width,
            color: ColorManager.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.height * 0.02),
              child:  Column(
                children: [


                  Image.asset(
                    'assets/images/call_center.jpg',
                    width: SizeConfig.width,
                    height: SizeConfig.height * 0.4,
                  ),


                  SizedBox(height: SizeConfig.height * 0.01),


                  Text(
                    'إذا كان لديك أي تساؤلات او إستفسارات او تريد تقديم إقتراحات للموقع يمكنك مراسلة فريق الدعم',
                    style: TextStyles.textStyle18Medium,
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: SizeConfig.height * 0.05),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // whatsapp
                      ElevatedButton.icon(
                        onPressed: () {
                          OurAgentCubit.get(context).launchWhatsApp(phoneNumber: "+905367247415");
                        },
                        icon: FaIcon(FontAwesomeIcons.whatsapp, color: ColorManager.white, size: SizeConfig.height * 0.025),
                        label: Text(
                          'عن طريق واتساب',
                          style: TextStyles.textStyle14Medium.copyWith(color: ColorManager.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.success,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(SizeConfig.height * 0.01),
                          ),
                        ),
                      ),

                      // telegram
                      ElevatedButton.icon(
                        onPressed: () {
                          OurAgentCubit.get(context).launchTelegram(phoneNumber:  "+905367247415");
                        },
                        icon: FaIcon(FontAwesomeIcons.telegram, color: ColorManager.white, size: SizeConfig.height * 0.025),
                        label: Text(
                          'عن طريق تيلجرام',
                          style: TextStyles.textStyle14Medium.copyWith(color: ColorManager.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(SizeConfig.height * 0.01),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
