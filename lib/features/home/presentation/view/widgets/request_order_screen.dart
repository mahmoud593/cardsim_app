import 'package:flutter/material.dart';
import 'package:games_app/features/home/presentation/view/widgets/request_order_screen_body.dart';

class RequestOrderScreen extends StatelessWidget {
  const RequestOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: SafeArea(child: RequestOrderScreenBody()),
      ),
    );
  }
}
