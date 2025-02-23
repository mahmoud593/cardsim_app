import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:games_app/core/helper/app_size_config.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_cubit.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_state.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';
import 'package:games_app/styles/widgets/loading_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class MoreScreen extends StatefulWidget {
  final String flag;
  const MoreScreen({super.key, required this.flag});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {

  @override
  void initState() {
    // TODO: implement initState
    BottomNavCubit.get(context).getMoreData(key: widget.flag);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.of(context).brightness == Brightness.light;
    return BlocBuilder<BottomNavCubit, BottomNavStates>(
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is GetMoreDataLoadingState? true : false,
          progressIndicator: const LoadingAnimationWidget(),
          color: Colors.transparent,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
              ),
              title: Text(
                'صفحات هامة',
                style: TextStyles.textStyle18Bold,
              ),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.height * 0.02,),

                  /// more screen filter
                  SizedBox(
                    height: SizeConfig.height * 0.04,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: SizeConfig.height * 0.01),
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final cubit = BottomNavCubit.get(context);
                            return ChoiceChip(
                              padding: EdgeInsets.zero,
                              label: Text(cubit.moreScreenList[index]),
                              labelStyle: TextStyle(
                                fontSize: SizeConfig.height * 0.012,
                                color: cubit.moreScreenSelected ==
                                        cubit.moreScreenList[index]
                                    ? Colors.white
                                    : isLight
                                        ? ColorManager.black
                                        : ColorManager.white,
                              ),
                              showCheckmark: false,
                              selected: cubit.moreScreenSelected ==
                                  cubit.moreScreenList[index],
                              selectedColor: ColorManager.primary,
                              checkmarkColor: ColorManager.white,
                              backgroundColor: isLight
                                  ? ColorManager.white
                                  : ColorManager.darkThemeBackgroundLight,
                              onSelected: (bool selected) {
                                cubit.selectMoreValue(cubit.moreScreenList[index]);
                                switch (cubit.moreScreenSelected) {
                                  case "سياسة الخصوصية" :{
                                    BottomNavCubit.get(context).getMoreData(key: 'privacy-policy');
                                    break;
                                  }
                                  case "الشروط والاحكام" :{
                                    BottomNavCubit.get(context).getMoreData(key: 'terms-conditions');
                                    break;
                                  }
                                  case "اتصل بنا" :{
                                    BottomNavCubit.get(context).getMoreData(key: 'call-us');
                                    break;
                                  }
                                  case "كيف تصبح وكيلا" :{
                                    BottomNavCubit.get(context).getMoreData(key: 'order-dist');
                                    break;
                                  }
                                }
                              },
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            width: SizeConfig.height * 0.005,
                          ),
                          itemCount: BottomNavCubit.get(context).moreScreenList.length,
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(SizeConfig.height * 0.02,),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isLight
                            ? ColorManager.white
                            : ColorManager.darkThemeBackgroundLight,
                        borderRadius: BorderRadius.circular(SizeConfig.height * 0.01),
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Html(data: BottomNavCubit.get(context).moreModel.data.description),
                      ),
                    ),
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
