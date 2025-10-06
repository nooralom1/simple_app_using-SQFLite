// ignore_for_file: unreachable_switch_case, unused_element

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:simple_app/feature/authentication/login/presentation/log_in_screen.dart';
import 'package:simple_app/feature/authentication/signup/presentation/sign_up_screen.dart';
import 'package:simple_app/feature/job_details/presentation/job_details_screen.dart';
import 'package:simple_app/navigation.dart';

final class Routes {
  static final Routes _routes = Routes._internal();
  Routes._internal();
  static Routes get instance => _routes;
  static const String login = '/login';
  static const String signup = '/signup';
  static const String navigation = '/navigation';
  static const String jobDetails = '/jobDetails';
}

final class RouteGenerator {
  static final RouteGenerator _routeGenerator = RouteGenerator._internal();
  RouteGenerator._internal();
  static RouteGenerator get instance => _routeGenerator;

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.jobDetails:
        Map args = settings.arguments as Map;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ScreenTitle(
                  widget: JobDetailsScreen(
                    title: args["title"],
                    description: args["description"],
                    thumnail: args["thumnail"],
                    company: args["company"],
                    sellary: args["sellary"],
                    location: args["location"],
                  ),
                ),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => JobDetailsScreen(
                  title: args["title"],
                  description: args["description"],
                  thumnail: args["thumnail"],
                  company: args["company"],
                  sellary: args["sellary"],
                  location: args["location"],
                ),
              );
      case Routes.navigation:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ScreenTitle(widget: NavigationScreen()),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => NavigationScreen());
      case Routes.signup:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ScreenTitle(widget: SignUpScreen()),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => SignUpScreen());
      case Routes.login:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ScreenTitle(widget: LogInScreen()),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => LogInScreen());

      default:
        return null;
    }
  }
}

class _FadedTransitionRoute extends PageRouteBuilder {
  final Widget widget;
  @override
  final RouteSettings settings;

  _FadedTransitionRoute({required this.widget, required this.settings})
    : super(
        settings: settings,
        reverseTransitionDuration: const Duration(milliseconds: 1),
        pageBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) {
              return widget;
            },
        transitionDuration: const Duration(milliseconds: 1),
        transitionsBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              return FadeTransition(
                opacity: CurvedAnimation(parent: animation, curve: Curves.ease),
                child: child,
              );
            },
      );
}

class ScreenTitle extends StatelessWidget {
  final Widget widget;

  const ScreenTitle({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: .5, end: 1),
      duration: const Duration(milliseconds: 500),
      curve: Curves.bounceIn,
      builder: (context, value, child) {
        return Opacity(opacity: value, child: child);
      },
      child: widget,
    );
  }
}
