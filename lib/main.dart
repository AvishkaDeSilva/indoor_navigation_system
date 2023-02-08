import 'package:flutter/material.dart';
import 'package:indoor_navigation_system/presentation_layer/screens/Initial%20Screen.dart';
import 'package:indoor_navigation_system/presentation_layer/screens/Main%20Screen.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

void main() {
  runApp(const NavMe());
}

class NavMe extends StatelessWidget {
  const NavMe({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, widget) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, widget!),
        maxWidth: 1200,
        minWidth: 450,
        defaultScale: true,
        breakpoints: [
          const ResponsiveBreakpoint.resize(450, name: MOBILE),
          const ResponsiveBreakpoint.autoScale(800, name: TABLET),
          const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
          const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
          const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
        ],
      ),
      initialRoute: InitialScreen.id,
      routes: {
        InitialScreen.id: (context) => const InitialScreen(),
        MainScreen.id: (context) => const MainScreen(),
      },
    );
  }
}
