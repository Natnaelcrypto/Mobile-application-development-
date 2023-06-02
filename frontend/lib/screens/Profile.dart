import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pro/user/model/user_model.dart';
import 'package:pro/user/user_exports.dart';

import '../LocalStroe/Store.dart';
import '../user/user_bloc/user_bloc.dart';
import '../user/user_bloc/user_event.dart';
import '../user/user_bloc/user_state.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _FirstnameController = TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController _LastnameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _FirstnameController.text = UserPreferences.firstname;
    _LastnameController.text = UserPreferences.lastname;
    _userNameController.text = UserPreferences.username;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        print(state);
        if (state is UserLoading) {}
        if (state is UserDataLoaded) {
          UserPreferences.firstname = _FirstnameController.text;
          UserPreferences.lastname = _LastnameController.text;
          UserPreferences.username = _userNameController.text;
          print(UserPreferences.username);
          context.go("/home");
        }
      },
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text(
                'Profile',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Roboto',
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  context.go("/home");
                },
              ),
              iconTheme: const IconThemeData(color: Colors.black),
              elevation: 0,
              backgroundColor: Color.fromRGBO(36, 130, 50, .6),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 130.0),
                    TextFormField(
                      controller: _FirstnameController,
                      decoration: const InputDecoration(
                        labelText: 'First Name',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _LastnameController,
                      decoration: const InputDecoration(
                        labelText: 'Last name',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _userNameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                      ),
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(8, 103, 136, .9)),
                      onPressed: () {
                        UserEvent event = UserUpdate(
                          UserPreferences.userId,
                          User(
                            fristName: _FirstnameController.text,
                            lastName: _LastnameController.text,
                            password: _passwordController.text,
                            userName: _userNameController.text,
                            Role: UserPreferences.role,
                            id: UserPreferences.userId,
                            farmName: UserPreferences.farmName,
                          ),
                        );
                        BlocProvider.of<UserBloc>(context).add(event);
                      },
                      child: const Text(
                        'Save Changes',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () {
                        UserEvent event = UserDelete(UserPreferences.userId);
                        BlocProvider.of<UserBloc>(context).add(event);
                        context.go("/");
                      },
                      child: const Text(
                        'delete account',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
