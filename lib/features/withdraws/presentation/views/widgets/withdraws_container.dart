import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/features/withdraws/presentation/controller/withdraws_cubit/withdraws_cubit.dart';
import 'package:games_app/features/withdraws/presentation/views/widgets/withdraws_list_view.dart';
import 'package:games_app/generated/assets.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/widgets/default_button.dart';
import 'package:games_app/styles/widgets/toast.dart';
import 'package:svg_flutter/svg.dart';

class WithdrawsContainer extends StatelessWidget {
  const WithdrawsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WithdrawsCubit, WithdrawsState>(
      builder: (context, state) {
        final withdrawController = TextEditingController();
        final notesController = TextEditingController();
        final withdrawFormKey = GlobalKey<FormState>(); // Moved outside dialog
        withdrawController.text = '5';
        var cubit = context.read<WithdrawsCubit>();

        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Card(
            color: UserDataFromStorage.themeIsDarkMode? ColorManager.white : ColorManager.white,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SvgPicture.asset(
                            color: UserDataFromStorage.themeIsDarkMode? ColorManager.black : ColorManager.darkGrey,
                            Assets.imagesDollarSquare,
                            width: 30,
                            height: 30,
                          ),
                          const SizedBox(width: 8),
                           Text(
                            'الأرباح',
                            style: TextStyle(
                              fontSize: 20,
                              color:UserDataFromStorage.themeIsDarkMode? ColorManager.black : ColorManager.darkGrey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("سحب الأرباح"),
                              content: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxHeight:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.6,
                                ),
                                child: Form(
                                  key: withdrawFormKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      const Text(
                                          "المبلغ (أدنى مبلغ للسحب: 5\$) *",style: TextStyle(),),
                                      const SizedBox(height: 6),
                                      TextFormField(
                                        controller: withdrawController,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.grey.shade200,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                8.0),
                                            borderSide: const BorderSide(
                                              color: ColorManager.lightGrey2,
                                              width: 1,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                8.0),
                                            borderSide: const BorderSide(
                                              color: ColorManager.primary,
                                              width: 1,
                                            ),
                                          ),
                                          contentPadding: const EdgeInsets
                                              .symmetric(
                                            vertical: 12.0,
                                            horizontal: 16.0,
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'من فضلك ادخل المبلغ';
                                          }
                                          if (int.tryParse(value) == null) {
                                            return 'يرجى إدخال قيمة صحيحة';
                                          }
                                          return null;
                                        },
                                        keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.done,
                                      ),
                                      const SizedBox(height: 24),
                                      const Text("ملاحظات"),
                                      const SizedBox(height: 6),
                                      Flexible(
                                        child: SingleChildScrollView(
                                          child: ConstrainedBox(
                                            constraints: const BoxConstraints(
                                              maxHeight: 100,
                                            ),
                                            child: TextFormField(
                                              controller: notesController,
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.grey.shade200,
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius
                                                      .circular(8.0),
                                                  borderSide: const BorderSide(
                                                    color: ColorManager
                                                        .lightGrey2,
                                                    width: 1,
                                                  ),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius
                                                      .circular(8.0),
                                                  borderSide: const BorderSide(
                                                    color: ColorManager.primary,
                                                    width: 1,
                                                  ),
                                                ),
                                                contentPadding: const EdgeInsets
                                                    .symmetric(
                                                  vertical: 12.0,
                                                  horizontal: 16.0,
                                                ),
                                              ),
                                              keyboardType: TextInputType
                                                  .multiline,
                                              textInputAction: TextInputAction
                                                  .newline,
                                              maxLines: null,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              actions: [
                                DefaultButton(
                                  onPressed: () {
                                    if (withdrawFormKey.currentState!
                                        .validate()) {
                                      if (int.parse(withdrawController.text) <
                                          5) {
                                        customToast(
                                            title: 'يجب أن تكون القيمة مساوية أو أكبر من 5.',
                                            color: Colors.red);
                                      }
                                      cubit.createWithdraw(
                                          int.parse(withdrawController.text),notesController.text);
                                      cubit.getWithdraws();
                                    }
                                  },
                                  borderRadius: BorderRadius.circular(10),
                                  text: 'سحب',
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(double.infinity, 43),
                        backgroundColor: ColorManager.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            Assets.imagesCash,
                            colorFilter: const ColorFilter.mode(
                                Colors.white, BlendMode.srcIn),
                          ),
                          const Text(
                            'سحب الأرباح',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Search and Table UI sections...
                  const WithdrawsListView(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:games_app/features/withdraws/presentation/controller/withdraws_cubit/withdraws_cubit.dart';
// import 'package:games_app/features/withdraws/presentation/views/widgets/withdraws_list_view.dart';
// import 'package:games_app/generated/assets.dart';
// import 'package:games_app/styles/colors/color_manager.dart';
// import 'package:games_app/styles/widgets/default_button.dart';
// import 'package:games_app/styles/widgets/toast.dart';
// import 'package:svg_flutter/svg.dart';
//
// class WithdrawsContainer extends StatelessWidget {
//   const WithdrawsContainer({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<WithdrawsCubit, WithdrawsState>(
//       builder: (context, state) {
//         TextEditingController withdrawController = TextEditingController();
//         TextEditingController notesController = TextEditingController();
//         withdrawController.text = '5';
//         var cubit = context.read<WithdrawsCubit>();
//         return Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Card(
//             color: Colors.white,
//             elevation: 4,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(18),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           SvgPicture.asset(
//                             Assets.imagesDollarSquare,
//                             width: 30,
//                             height: 30,
//                           ),
//                           const SizedBox(width: 8),
//                           const Text(
//                             'الأرباح',
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//
//                   const SizedBox(height: 16),
//
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                         onPressed: () {
//                           showDialog(
//                             context: context,
//                             builder: (BuildContext context) {
//                               final withdrawFormKey = GlobalKey<FormState>();
//                               return AlertDialog(
//                                 title: const Text("سحب الأرباح"),
//                                 content: ConstrainedBox(
//                                   constraints: BoxConstraints(
//                                     maxHeight:
//                                         MediaQuery.of(context).size.height *
//                                             0.6, // Limit dialog height
//                                   ),
//                                   child: Form(
//                                     key: withdrawFormKey,
//                                     child: Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         const Text(
//                                             "المبلغ (أدنى مبلغ للسحب: 5\$) *"),
//                                         const SizedBox(height: 6),
//                                         TextFormField(
//                                           controller: withdrawController,
//                                           decoration: InputDecoration(
//                                             filled: true,
//                                             fillColor: Colors.grey.shade200,
//                                             border: OutlineInputBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(8.0),
//                                               borderSide: const BorderSide(
//                                                 color: ColorManager.lightGrey2,
//                                                 width: 1,
//                                               ),
//                                             ),
//                                             focusedBorder: OutlineInputBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(8.0),
//                                               borderSide: const BorderSide(
//                                                 color: ColorManager.primary,
//                                                 width: 1,
//                                               ),
//                                             ),
//                                             contentPadding:
//                                                 const EdgeInsets.symmetric(
//                                               vertical: 12.0,
//                                               horizontal: 16.0,
//                                             ),
//                                           ),
//                                           validator: (value) {
//                                             if (value == null ||
//                                                 value.isEmpty) {
//                                               return 'من فضلك ادخل المبلغ';
//                                             }
//                                             return null;
//                                           },
//                                           keyboardType: TextInputType.number,
//                                           textInputAction: TextInputAction.done,
//                                         ),
//                                         const SizedBox(height: 24),
//                                         const Text("ملاحظات"),
//                                         const SizedBox(height: 6),
//                                         Flexible(
//                                           child: SingleChildScrollView(
//                                             child: ConstrainedBox(
//                                               constraints: const BoxConstraints(
//                                                 maxHeight: 100,
//                                               ),
//                                               child: TextFormField(
//                                                 controller: notesController,
//                                                 decoration: InputDecoration(
//                                                   filled: true,
//                                                   fillColor:
//                                                       Colors.grey.shade200,
//                                                   border: OutlineInputBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             8.0),
//                                                     borderSide:
//                                                         const BorderSide(
//                                                       color: ColorManager
//                                                           .lightGrey2,
//                                                       width: 1,
//                                                     ),
//                                                   ),
//                                                   focusedBorder:
//                                                       OutlineInputBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             8.0),
//                                                     borderSide:
//                                                         const BorderSide(
//                                                       color:
//                                                           ColorManager.primary,
//                                                       width: 1,
//                                                     ),
//                                                   ),
//                                                   contentPadding:
//                                                       const EdgeInsets
//                                                           .symmetric(
//                                                     vertical: 12.0,
//                                                     horizontal: 16.0,
//                                                   ),
//                                                 ),
//                                                 keyboardType:
//                                                     TextInputType.multiline,
//                                                 textInputAction:
//                                                     TextInputAction.newline,
//                                                 maxLines: null,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 actions: [
//                                   DefaultButton(
//                                       onPressed: () {
//                                         if (withdrawFormKey.currentState!
//                                             .validate()) {
//                                           if (int.parse(
//                                                   withdrawController.text) <
//                                               5) {
//                                             customToast(
//                                                 title:
//                                                     'يجب أن تكون القيمة مساوية أو أكبر من 5.',
//                                                 color: Colors.red);
//                                           } else {
//                                             cubit.createWithdraw(int.parse(
//                                                 withdrawController.text));
//                                           }
//                                         }
//                                       },
//                                       borderRadius: BorderRadius.circular(10),
//                                       text: 'سحب'),
//                                 ],
//                               );
//                             },
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           fixedSize: const Size(double.infinity, 43),
//                           padding: EdgeInsets.zero,
//                           alignment: Alignment.centerRight,
//                           backgroundColor: ColorManager.primary,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             SvgPicture.asset(
//                               Assets.imagesCash,
//                               colorFilter: const ColorFilter.mode(
//                                   Colors.white, BlendMode.srcIn),
//                             ),
//                             const Text(
//                               'سحب الأرباح',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         )),
//                   ),
//                   const SizedBox(height: 16),
//                   TextFormField(
//                     decoration: InputDecoration(
//                       contentPadding: const EdgeInsets.only(right: 10),
//                       filled: true,
//                       fillColor: Colors.grey.shade50,
//                       suffixIcon: const Icon(
//                         Icons.search,
//                         color: Colors.grey,
//                       ),
//                       hintText: 'البحث...',
//                       hintStyle: const TextStyle(color: Colors.grey),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: BorderSide(color: Colors.grey.shade200),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide:
//                             const BorderSide(color: ColorManager.primary),
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(height: 16),
//
//                   // Table headers
//                   Container(
//                     padding: const EdgeInsets.symmetric(vertical: 8),
//                     decoration: BoxDecoration(
//                       color: ColorManager.primary,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: const Row(
//                       //mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Expanded(
//                           child: Text(
//                             'رقم العملية',
//                             style: TextStyle(color: Colors.white),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                         Expanded(
//                           child: Text(
//                             'المبلغ',
//                             style: TextStyle(color: Colors.white),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                         Expanded(
//                           child: Text(
//                             'الحالة',
//                             style: TextStyle(color: Colors.white),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   const SizedBox(height: 16),
//                   Container(
//                       padding: const EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         color: Colors.grey.shade200,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: const WithdrawsListView()),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
