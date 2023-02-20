import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indoor_navigation_system/logic_layer/blocs/map_bloc.dart';
import 'package:indoor_navigation_system/logic_layer/cubits/login_cubit.dart';
import 'package:indoor_navigation_system/logic_layer/events/map_event.dart';
import 'package:indoor_navigation_system/logic_layer/states/login_state.dart';
import 'package:indoor_navigation_system/presentation_layer/screens/main_screen.dart';
import 'package:indoor_navigation_system/presentation_layer/utilities/styles.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _username;

  String? validateUsername(value) {
    value = value.toString();
    if (value.isEmpty) {
      return "* Required";
    } else if (value.length < 6) {
      return "Username should be at least 6 characters";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: initialScreenBC,
      body: Container(
        padding: const EdgeInsets.all(32.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                  child: Hero(
                      tag: 'logo',
                      child: SizedBox(
                          width: 300,
                          child: Image.asset('assets/images/logo.jpg')))),
              const SizedBox(height: 16.0),
              BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
                if (state is LoginFailedState) {
                  showDialog(
                      context: context,
                      builder: (context) => const AlertDialog(
                            elevation: 5,
                            title: Text('Login Error'),
                            content: Text('User Already Exist'),
                          ));
                }
              }, builder: (context, state) {
                if (state is LoginLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is LoginSuccessState) {
                  final bloc = context.read<MapBloc>();
                  bloc.add(LoadMapEvent(imagePath: "assets/images/map.jpg"));
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    //used to return circular progress indicator until the frame build
                    Navigator.pushReplacementNamed(context, MainScreen.id);
                  });
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Column(
                    children: [
                      TextFormField(
                        textAlign: TextAlign.center,
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return 'Please enter your email';
                          }
                          if (value.toString().length < 6) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        onChanged: (value) => _username = value,
                        decoration: InputDecoration(
                          hintText: hintText,
                          filled: true,
                          fillColor: fillColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      SizedBox(
                        width: 120,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: buttonElvColor, elevation: 5),
                          child: const Text(buttonText),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final cubit = context.read<LoginCubit>();
                              cubit.onLogin(_username);
                            }
                          },
                        ),
                      ),
                    ],
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
