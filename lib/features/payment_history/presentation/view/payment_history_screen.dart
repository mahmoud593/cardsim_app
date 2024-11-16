import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/our_agent/presentation/cubit/our_agent_state.dart';
import 'package:games_app/features/payment_history/presentation/cubit/payment_history_cubit.dart';
import 'package:games_app/features/payment_history/presentation/cubit/payment_history_state.dart';
import 'package:games_app/features/payment_history/presentation/view/widget/payment_history_widget.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';
import 'package:games_app/styles/widgets/loading_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class PaymentHistoryScreen extends StatelessWidget {
  const PaymentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.of(context).brightness == Brightness.light;
    return BlocConsumer<PaymentHistoryCubit, PaymentHistoryStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is PaymentHistoryLoadingState ? true : false,
          progressIndicator: const LoadingAnimationWidget(),
          color: Colors.transparent,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'سجل العمليات',
                style: TextStyles.textStyle24Medium,
              ),
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: isLight == true ? ColorManager.black: ColorManager.white,
                ),
              ),
              centerTitle: true,
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.02, vertical: MediaQuery.of(context).size.height * 0.02),
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Expanded(
                      child: state is PaymentHistorySuccessState && PaymentHistoryCubit.get(context).transcationModel.data.isNotEmpty ? ListView.builder(
                        itemCount: PaymentHistoryCubit.get(context).transcationModel.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return PaymentHistoryCard(
                            transactionAmount: PaymentHistoryCubit.get(context).transcationModel.data[index].amount.toString(),
                            balanceBefore: PaymentHistoryCubit.get(context).transcationModel.data[index].prevBalance.toString(),
                            balanceAfter: PaymentHistoryCubit.get(context).transcationModel.data[index].newBalance.toString(),
                            transactionType: PaymentHistoryCubit.get(context).transcationModel.data[index].action,
                            transactionId: PaymentHistoryCubit.get(context).transcationModel.data[index].actionId,
                          );
                        },

                      ): Center(child: Text('لا يوجد عمليات', style: TextStyles.textStyle24Medium,),),
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
