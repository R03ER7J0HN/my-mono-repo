import 'package:flutter/widgets.dart';
import 'package:job_application_tracker/features/home/l10n/gen/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(HomeLocalizations.of(context).home_Title),
    );
  }
}
