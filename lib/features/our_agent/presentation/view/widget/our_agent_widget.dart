import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:games_app/core/helper/app_size_config.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';


class AgentCard extends StatelessWidget {
  final String agentName;
  final String agentImageUrl;
  final VoidCallback onContactPressed;

  const AgentCard({
    super.key,
    required this.agentName,
    required this.agentImageUrl,
    required this.onContactPressed,
  });

  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.of(context).brightness == Brightness.light;
    return Card(
      elevation: 4.0,
      color: isLight? ColorManager.darkWhite: ColorManager.darkThemeBackgroundLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: SizeConfig.height * 0.05,
              backgroundImage: NetworkImage(agentImageUrl),
            ),
            SizedBox(height: SizeConfig.height * 0.01),

            Text(
              agentName,
              style: TextStyles.textStyle18Bold,
            ),

           SizedBox(height: SizeConfig.height * 0.01),


            ElevatedButton.icon(
              onPressed: onContactPressed,
              icon: FaIcon(FontAwesomeIcons.whatsapp, color: ColorManager.white, size: SizeConfig.height * 0.025),
              label: Text(
                'تواصل معه',
                style: TextStyles.textStyle14Medium.copyWith(color: ColorManager.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.success,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(SizeConfig.height * 0.01),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}