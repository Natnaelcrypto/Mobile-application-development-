import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../LocalStroe/Store.dart';
import '../../../screens/Loading_page.dart';
import '../../../user/model/user_model.dart';
import '../../auth_bloc/auth_bloc.dart';
import '../../auth_bloc/auth_event.dart';
import '../../auth_bloc/auth_state.dart';


class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _frameNameController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _frameNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Signup Page'),
          backgroundColor: const Color.fromRGBO(36, 130, 50, .6),
        ),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLoading) {
            }
            if (state is AuthDataLoaded) {
              UserPreferences.username = state.user.userName;
              UserPreferences.role = state.user.Role;
              UserPreferences.userId = state.user.id;
              UserPreferences.farmName = state.user.farmName;
              context.go("/home");
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  height: 1000,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: _firstNameController,
                            decoration: InputDecoration(labelText: 'First Name'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your first name';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _lastNameController,
                            decoration: InputDecoration(labelText: 'Last Name'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your last name';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _usernameController,
                            decoration: InputDecoration(labelText: 'Username'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a username';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(labelText: 'Password'),
                            obscureText: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a password';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _confirmPasswordController,
                            decoration:
                                InputDecoration(labelText: 'Confirm Password'),
                            obscureText: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please confirm your password';
                              }
                              if (value != _passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _frameNameController,
                            decoration: InputDecoration(labelText: 'Frame Name'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a frame name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 7.0),
                          ElevatedButton(
                            key: const Key("signupbutton"),
                            onPressed: () {
                              print("clicked");
                              if (_formKey.currentState!.validate()) {
                                // Perform signup logic here
                                String firstName = _firstNameController.text;
                                String lastName = _lastNameController.text;
                                String username = _usernameController.text;
                                String password = _passwordController.text;
                                String frameName = _frameNameController.text;
                
                                AuthEvent event = AuthSignup(
                                  User(
                                    farmName: frameName,
                                    fristName: firstName,
                                    password: password,
                                    lastName: lastName,
                                    userName: username,
                                    Role: "user",
                                    id: "",
                                  ),
                                );
                
                                BlocProvider.of<AuthBloc>(context).add(event);
                
                                // Clear the form fields
                                _firstNameController.clear();
                                _lastNameController.clear();
                                _usernameController.clear();
                                _passwordController.clear();
                                _confirmPasswordController.clear();
                                _frameNameController.clear();
                
                                // Show success message or navigate to the next screen
                              }
                            },
                            child: Text('Sign Up'),
                          ),
                        ],
                      ),
                    ),
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
