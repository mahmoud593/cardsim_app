import 'package:flutter/material.dart';
import 'package:games_app/features/settings/presentation/view/widgets/settings_body_view.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width*.06,
          vertical: MediaQuery.of(context).size.height*.05
        ),
        child: const SettingsBodyView(),
      ),
    );
  }
}
