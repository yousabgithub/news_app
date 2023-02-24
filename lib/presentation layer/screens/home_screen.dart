import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import '../../presentation layer/screens/planning_screen.dart';

import 'no_internet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (
        BuildContext context,
        ConnectivityResult connectivity,
        Widget child,
      ) {
        final bool connected = connectivity != ConnectivityResult.none;
        if (connected) {
          return const PlanningScreen();
        } else {
          return const NoInternet();
        }
      },
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.blue,
        ),
      ),
    );
  }
}
