import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/core/helper/app_size_config.dart';
import 'package:games_app/core/helper/material_navigation.dart';
import 'package:games_app/features/clients/presentation/cubit/client_cubit.dart';
import 'package:games_app/features/clients/presentation/cubit/client_state.dart';
import 'package:games_app/features/clients/presentation/view/create_client.dart';
import 'package:games_app/features/clients/presentation/view/widgets/clients_card_widget.dart';
import 'package:games_app/features/clients/presentation/view/widgets/clients_carousel_view.dart';
import 'package:games_app/features/coupons/presentation/view/create_coupon.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';
import 'package:games_app/styles/widgets/custom_search_field.dart';
import 'package:games_app/styles/widgets/default_button.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ClientCubit.get(context).getAllClients();

  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClientCubit, ClientState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit=ClientCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'العملاء',
              style: TextStyles.textStyle24Medium,
            ),
            centerTitle: true,
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            //color: ColorManager.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.02),
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: SizeConfig.height * 0.01,),

                   CustomSearchField(
                     controller:  searchController,
                    onClear:  (){
                      cubit.searchInAllClients(searchValue: '');
                      searchController.clear();
                    },
                    onChanged: (value){
                      cubit.searchInAllClients(searchValue: value);
                    },
                    hintText: "البحث...",
                    suffixIcon: Icons.search,
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.02,),

                  const ClientsCarouselView(),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.02,),

                  DefaultButton(
                    onPressed: (){
                      cubit.nameController.text='';
                      cubit.emailController.text='';
                      cubit.phoneController.text='';
                      cubit.passwordController.text='';
                      cubit.earningController.text='';
                      cubit.addressController.text='';
                      customPushNavigator(context,  CreateClient());
                    },
                    borderRadius: BorderRadius.circular(SizeConfig.height*0.01),
                    text: "انشاء عميل",
                    backgroundColor: ColorManager.success,
                    haveIcon: true,
                    icon: Icons.card_membership,
                    textStyle: TextStyles.textStyle14Medium.copyWith(
                        color: ColorManager.white
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.02,),

                  state is GetAllClientsLoadingState?
                  const Center(child: CupertinoActivityIndicator()):
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: ()async{
                        cubit.getAllClients();
                      },
                      child: ListView.separated(
                          itemBuilder: (context, index) => ClientsCardWidget(
                            username: cubit.clientsList[index].name!,
                            phone: cubit.clientsList[index].phone!,
                            email: cubit.clientsList[index].email!,
                            balance: cubit.clientsList[index].balance!,
                            createdAt: cubit.clientsList[index].createdAt!,
                            rate: cubit.clientsList[index].distEarningRate!,
                          ),
                          separatorBuilder: (context, index) => SizedBox(height: SizeConfig.height * 0.02),
                          itemCount: cubit.clientsList.length
                      ),
                    )
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
