import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indoor_navigation_system/data_layer/models/map.dart';
import 'package:indoor_navigation_system/data_layer/repositories/user_repository.dart';
import 'package:indoor_navigation_system/logic_layer/cubits/login_cubit.dart';
import 'package:indoor_navigation_system/logic_layer/blocs/map_bloc.dart';
import 'package:indoor_navigation_system/logic_layer/single_bloc_observer.dart';
import 'package:indoor_navigation_system/presentation_layer/screens/initial%20_screen.dart';
import 'package:indoor_navigation_system/presentation_layer/screens/login_screen.dart';
import 'package:indoor_navigation_system/presentation_layer/screens/main_screen.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const NavMe());
}

class NavMe extends StatelessWidget {
  const NavMe({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Bloc.observer = SimpleBlocObserver();
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(create: (context) => LoginCubit(databaseRepository: DatabaseRepository())),
        BlocProvider<MapBloc>(create: (context) => MapBloc(graph: Graph()))
      ],
      child: MaterialApp(
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
          LoginScreen.id: (context) => const LoginScreen(),
          MainScreen.id: (context) => const MainScreen(),
        },
      ),
    );
  }
}
