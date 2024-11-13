import 'package:flutter/material.dart';
import 'package:games_app/features/withdraws/presentation/views/widgets/client_order_container.dart';
import 'package:games_app/features/withdraws/presentation/views/widgets/withdraws_carousal_slider.dart';
import 'package:games_app/features/withdraws/presentation/views/widgets/withdraws_container.dart';
import 'package:games_app/styles/colors/color_manager.dart';

class WithdrawsScreenBody extends StatefulWidget {
  const WithdrawsScreenBody({super.key});

  @override
  State<WithdrawsScreenBody> createState() => _WithdrawsScreenBodyState();
}

class _WithdrawsScreenBodyState extends State<WithdrawsScreenBody> {
  bool isProfitsSelected = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const WithdrawsCarousalSlider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isProfitsSelected = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor:
                    isProfitsSelected ? ColorManager.primary : Colors.white,
                  ),
                  child: Text(
                    'الأرباح',
                    style: TextStyle(
                      color: isProfitsSelected ? ColorManager.white : Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isProfitsSelected = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor:
                    isProfitsSelected ? Colors.white : ColorManager.primary,
                  ),
                  child: Text(
                    'العمليات',
                    style: TextStyle(
                      color: isProfitsSelected ? Colors.blue : ColorManager.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 0.6,
            ),
            child: Center(
              child: isProfitsSelected
                  ? const WithdrawsContainer()
                  : const ClientOrderContainer(),
            ),
          ),
        ],
      ),
    );
  }
}
