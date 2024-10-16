import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/home/presentation/controller/request_cubit/request_cubit.dart';
import 'package:games_app/styles/widgets/default_button.dart';

class RequestOrderButton extends StatelessWidget {
  const RequestOrderButton({
    super.key,
    required this.formKey,
    this.onPressed,
/*    required this.productId,
    required this.quantity,
    required this.field,*/
  });

  final GlobalKey<FormState> formKey;

/*  final int productId;
  final int quantity;
  final String field;*/
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DefaultButton(
        onPressed:onPressed ,

          /*onPressed: () {
            if (formKey.currentState!.validate()) {
              context.read<RequestCubit>().createOrder(
                    productId: productId,
                    quantity: quantity,
                    field: field,
                  );
            } else {
             // print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> $quantity");
              *//*context.read<RequestCubit>().createOrder(
                productId: productId,
                quantity: quantity,
                field: field,
              );*//*
            }*/
          //},
          haveIcon: true,
          borderRadius: BorderRadius.circular(12),
          icon: Icons.shopping_cart_outlined,
          text: 'إنشاء الطلب'),
    );
  }
}
