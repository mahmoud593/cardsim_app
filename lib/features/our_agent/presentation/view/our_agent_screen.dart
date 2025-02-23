import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/core/helper/material_navigation.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_cubit.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/view/widget/more_screen.dart';
import 'package:games_app/features/our_agent/presentation/cubit/our_agent_cubit.dart';
import 'package:games_app/features/our_agent/presentation/cubit/our_agent_state.dart';
import 'package:games_app/features/our_agent/presentation/view/widget/our_agent_widget.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';
import 'package:games_app/styles/widgets/loading_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class OurAgentScreen extends StatelessWidget {
  const OurAgentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.of(context).brightness == Brightness.light;
    return BlocConsumer<OurAgentCubit, OurAgentStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is GetAgentLoadingState ? true : false,
          progressIndicator: const LoadingAnimationWidget(),
          color: Colors.transparent,
          child: Scaffold(
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
              actions: [
                InkWell(
                  onTap: () {
                    BottomNavCubit.get(context).selectMoreValue("كيف تصبح وكيلا");
                    customPushNavigator(context, const MoreScreen(flag: 'order-dist',));
                  },
                  child: Text(
                    'كيف تصبح وكيلا',
                    style: TextStyles.textStyle14Bold.copyWith(color: ColorManager.primary),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.03,),
              ],
              centerTitle: true,
            ),
            body: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: state is !GetAgentLoadingState && OurAgentCubit.get(context).agentModel.data.isNotEmpty ? Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.02, vertical: MediaQuery.of(context).size.height * 0.02),
                child:  GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: OurAgentCubit.get(context).agentModel.data.length,
                  itemBuilder: (context, index) {
                    return AgentCard(
                      agentName: OurAgentCubit.get(context).agentModel.data[index].name,
                      agentImageUrl: OurAgentCubit.get(context).agentModel.data[index].image,
                      onContactPressed: () {
                        OurAgentCubit.get(context).launchWhatsAppLink(link: OurAgentCubit.get(context).agentModel.data[index].whatsapp);
                      },
                    );
                  },
                ),
              ): Center(child: Text('لا يوجد وكلاء', style: TextStyles.textStyle24Medium,),),
            ),
          ),
        );
      },
    );
  }
}
