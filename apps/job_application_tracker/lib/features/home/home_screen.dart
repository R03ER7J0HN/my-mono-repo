import 'package:flutter/material.dart';
import 'package:job_application_tracker/features/home/l10n/gen/app_localizations.dart';
import 'package:job_application_tracker/widgets/background_decoration.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundDecoration(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(HomeLocalizations.of(context).home_Title),
            ],
          ),
        ),
      ),
    );
  }
}
