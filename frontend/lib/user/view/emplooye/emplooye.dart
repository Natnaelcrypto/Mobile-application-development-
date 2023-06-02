import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pro/user/model/user_model.dart';
import 'package:pro/user/user_exports.dart';

import '../../../LocalStroe/Store.dart';
import '../../user_bloc/user_bloc.dart';
import '../../user_bloc/user_event.dart';
import '../../user_bloc/user_state.dart';

class EmplooyeRegistor extends StatelessWidget {
  EmplooyeRegistor({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // ignore: non_constant_identifier_names
  final TextEditingController _FirstnameController = TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController _LastnameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passswordConfirmationController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        print(state);
        if (state is UserDataLoadingError) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Scaffold(
                body: Center(
                  child: Text("Change the Username"),
                ),
              ),
            ),
          );
        } else {
          if (state is UserLoading) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else {
            if (state is UserDataLoaded) {
              context.go("/emplooyes");
            }
          }
        }
      },
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Add emplooye",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Roboto',
                ),
              ),
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.black),
              backgroundColor: Color.fromRGBO(36, 130, 50, .6),
            ),
            backgroundColor: Colors.white,
            body: ListView(
              children: [
                Center(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              controller: _FirstnameController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your first name';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  labelText: 'First Name',
                                  prefixIcon: Icon(Icons.person)),
                            ),
                            const SizedBox(height: 10.0),
                            TextFormField(
                              controller: _LastnameController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your last name';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  labelText: 'Last Name',
                                  prefixIcon: Icon(Icons.person)),
                            ),
                            const SizedBox(height: 10.0),
                            TextFormField(
                              controller: _userNameController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your username';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  labelText: 'Username',
                                  prefixIcon: Icon(Icons.person)),
                            ),
                            const SizedBox(height: 10.0),
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
                                  prefixIcon: Icon(Icons.person)),
                            ),
                            const SizedBox(height: 10.0),
                            TextFormField(
                              controller: _passswordConfirmationController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "please confirm your password";
                                }
                                if (value != _passwordController.text) {
                                  return "password must be same";
                                }
                                return null;
                              },
                              obscureText: true,
                              decoration: const InputDecoration(
                                  labelText: 'Confirm Password',
                                  prefixIcon: Icon(Icons.lock)),
                            ),
                            const SizedBox(height: 25.0),
                            ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    UserEvent event = UserCreate(
                                      User(
                                          farmName: UserPreferences.farmName,
                                          fristName: _FirstnameController.text,
                                          password: _passwordController.text,
                                          lastName: _LastnameController.text,
                                          userName: _userNameController.text,
                                          Role: "emplooye",
                                          id: ""),
                                    );
                                    BlocProvider.of<UserBloc>(context)
                                        .add(event);
                                  }
                                },
                                child: const Text("Add Emplooye"))
                          ],
                        ),
                      )),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
