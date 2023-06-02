import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pro/auth/view/auth/signup.dart';

import '../../../LocalStroe/Store.dart';
import '../../../screens/Error_page.dart';
import '../../../screens/Loading_page.dart';
import '../../auth_bloc/auth_bloc.dart';
import '../../auth_bloc/auth_event.dart';
import '../../auth_bloc/auth_state.dart';
import '../../auth_data_providers/auth_data_provider.dart';
import '../../auth_model/auth.dart';
import '../../auth_repository/information_repository.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthDataProvider authDataProvider = AuthDataProvider();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) =>
              AuthBloc(authRepository: AuthRepository(authDataProvider)),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLoading) {
            } else {
              if (state is AuthDataLoadingError) {
                context.go("/error");
              } else {
                if (state is AuthDataLoaded) {
                  UserPreferences.username = state.user.userName;
                  UserPreferences.firstname = state.user.fristName;
                  UserPreferences.lastname = state.user.lastName;
                  UserPreferences.role = state.user.Role;
                  UserPreferences.userId = state.user.id;
                  UserPreferences.farmName = state.user.farmName;
                  context.go("/home");
                }
              }
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Scaffold(
                body: Center(
                  child: Center(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              icon(),
                              const SizedBox(height: 40.0),
                              TextFormField(
                                controller: _userNameController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  labelText: 'UserName',
                                  prefixIcon:
                                      Icon(Icons.email, color: Colors.black),
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              TextFormField(
                                controller: _passwordController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                                obscureText: true,
                                decoration: const InputDecoration(
                                    labelText: 'Password',
                                    prefixIcon:
                                        Icon(Icons.lock, color: Colors.black),
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Roboto',
                                    )),
                              ),
                              const SizedBox(height: 40.0),
                              TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor:
                                        Color.fromRGBO(36, 130, 50, .6),
                                  ),
                                  onPressed: () {
                                    print("clicked");
                                    if (_formKey.currentState!.validate()) {
                                      final AuthEvent event = AuthLogin(
                                        Auth(
                                            userName: _userNameController.text,
                                            password: _passwordController.text,
                                            token: ""),
                                      );

                                      BlocProvider.of<AuthBloc>(context)
                                          .add(event);
                                    }
                                  },
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 250, 251, 250)),
                                  )),
                              const SizedBox(height: 20.0),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromRGBO(237, 246, 249, 0.898)),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignupPage()),
                                  );
                                },
                                child: const Text(
                                  'Don\'t have an account? Sign up',
                                  style: TextStyle(
                                    color: Colors.black,
                                    decoration: TextDecoration.none,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

Widget icon() {
  return const Icon(Icons.person);
}
