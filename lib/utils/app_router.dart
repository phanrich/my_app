import 'package:flutter/material.dart';

import '../screens/dashboard/dashboard_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/otp/otp_screen.dart';
import '../screens/recycle_bin/recycle_bin_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    switch (routeSettings.name) {
      case DashBoardScreen.id:
        return MaterialPageRoute(builder: (_) => const DashBoardScreen());
      case RecycleBinScreen.id:
        return MaterialPageRoute(builder: (_) => const RecycleBinScreen());
      case HomeScreen.id:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case LoginScreen.id:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case OtpScreen.id:
        return MaterialPageRoute(
            builder: (_) => const OtpScreen(
                  verificationId: "verificationId",
                ));
      default:
        return null;
    }
  }
}
