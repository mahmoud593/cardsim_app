
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/core/helper/app_size_config.dart';
import 'package:games_app/core/helper/material_navigation.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/features/balance/presentation/cubit/balance_cubit.dart';
import 'package:games_app/features/balance/presentation/cubit/balance_state.dart';
import 'package:games_app/features/balance/presentation/view/balance_card_widget.dart';
import 'package:games_app/features/balance/presentation/view/create_new_balance_widget.dart';
import 'package:games_app/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:games_app/features/orders/presentation/cubit/orders_state.dart';
import 'package:games_app/styles/assets/asset_manager.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';
import 'package:games_app/styles/widgets/custom_search_field.dart';
import 'package:games_app/styles/widgets/default_button.dart';
import 'package:games_app/styles/widgets/default_text_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BalanceCubit.get(context).getAllTransactions();
    BalanceCubit.get(context).getPaymentMethods();
    BalanceCubit.get(context).getCurrency();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BalanceCubit, BalanceStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BalanceCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'إضافة دفعات',
              style: TextStyles.textStyle24Medium,
            ),
            centerTitle: true,
          ),
          body: cubit.allTransactionModel ==null?
          const Center(child: CupertinoActivityIndicator()):
          ModalProgressHUD(
            inAsyncCall: state is CreateCustomCodeLoadingState ,
            progressIndicator: const CupertinoActivityIndicator(),
            child: Container(
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
                       controller: searchController,
                      onClear: (){
                         searchController.text='';
                         cubit.getAllTransactions();
                      },
                      onChanged: (value){
                        cubit.searchInAllTransactions(searchValue: value);
                      },
                      hintText: "ابحث ب رقم العمليه ...",
                      suffixIcon: Icons.search,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DefaultButton(
                          onPressed: ()=>customPushNavigator(context, CreateNewBalanceWidget()),
                          borderRadius: BorderRadius.circular(SizeConfig.height*0.01),
                          text: "شحن الرصيد",
                          backgroundColor: ColorManager.success,
                          haveIcon: true,
                          icon: Icons.attach_money,
                          textStyle: TextStyles.textStyle14Medium.copyWith(
                            color: ColorManager.white
                          ),
                        ),
                        DefaultButton(
                          onPressed: ()=>cubit.showCustomCodeDialog(context),
                          borderRadius: BorderRadius.circular(SizeConfig.height*0.01),
                          text: "الشحن بقسيمة",
                          haveIcon: true,
                          icon: Icons.wallet,
                          textStyle: TextStyles.textStyle14Medium.copyWith(
                            color: ColorManager.white
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.02,),

                    state is GetTransactionsLoadingState?
                    const Center(child: CupertinoActivityIndicator()):
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh:()async{
                          BalanceCubit.get(context).getAllTransactions();
                        } ,
                        child: ListView.separated(
                            itemBuilder: (context, index) => BalanceCard(
                              proofOfPayment: cubit.allTransactionModel!.data![index].image!,
                              transactionId: cubit.allTransactionModel!.data![index].tracking!,
                              paymentMethod: cubit.allTransactionModel!.data![index].payment!,
                              amount: '${cubit.allTransactionModel!.data![index].amount!}',
                              status: cubit.allTransactionModel!.data![index].status!,
                              transactionDate: cubit.allTransactionModel!.data![index].createdAt!,
                            ),
                            separatorBuilder: (context, index) => SizedBox(height: SizeConfig.height * 0.02,),
                            itemCount: cubit.allTransactionModel!.data!.length
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}




