import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/our_agent/presentation/cubit/our_agent_cubit.dart';
import 'package:games_app/features/our_agent/presentation/cubit/our_agent_state.dart';
import 'package:games_app/features/our_agent/presentation/view/widget/our_agent_widget.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';

class OurAgentScreen extends StatelessWidget {
  const OurAgentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.of(context).brightness == Brightness.light;
    return BlocConsumer<OurAgentCubit, OurAgentStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'وكلاؤنا',
              style: TextStyles.textStyle24Medium,
            ),
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: isLight ? ColorManager.black : ColorManager.white,
              ),
            ),
            centerTitle: true,
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.02, vertical: MediaQuery.of(context).size.height * 0.02),
              child:  GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.75,
                ),
                itemCount: 2,
                itemBuilder: (context, index) {
                  return AgentCard(
                    agentName: "الإدارة العامة",
                    agentImageUrl: "https://static.vecteezy.com/system/resources/thumbnails/000/439/863/small/Basic_Ui__28186_29.jpg",
                    onContactPressed: () {
                      OurAgentCubit.get(context).launchWhatsApp(
                        phoneNumber: "+905367247415",
                      );
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
