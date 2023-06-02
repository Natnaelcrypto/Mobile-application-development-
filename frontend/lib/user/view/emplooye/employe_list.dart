import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';
import 'package:pro/user/model/user_model.dart';
import 'package:pro/user/user_exports.dart';

import '../../../screens/Drawer.dart';

import '../../user_bloc/user_bloc.dart';
import '../../user_bloc/user_event.dart';
import '../../user_bloc/user_state.dart';

class EmplooyeListScreen extends StatelessWidget {
  final User userr;
  EmplooyeListScreen({required this.userr});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        print(state);
        if (state is UserLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is UserDataLoaded) {
          final List<User> user = state.users;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Emplooye List'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    // ignore: unnecessary_type_check
                    if (state is UserDataLoaded) {
                      context.go("/addemplooye", extra: state.users);
                    }
                  },
                ),
              ],
              backgroundColor: Color.fromRGBO(36, 130, 50, .6),
            ),
            drawer: Drawerpage(),
            body: user.isEmpty
                ? const Center(
                    child: Text("No Emplooye"),
                  )
                : ListView.builder(
                    itemCount: user.length,
                    itemBuilder: (context, index) {
                      print(user[index].Role);

                      return true
                          ? Card(
                              color: Color.fromRGBO(149, 178, 184, .9),
                              child: ListTile(
                                contentPadding: const EdgeInsets.fromLTRB(
                                    5.0, 7.0, 5.0, 0.0),
                                leading: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                title: Text(
                                  "Username: ${user[index].userName}",
                                  style: TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(
                                  'Name: ${user[index].fristName} ${user[index].lastName}',
                                  style: TextStyle(color: Colors.white),
                                ),
                                trailing: IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    UserEvent event =
                                        UserDelete(user[index].id);
                                    BlocProvider.of<UserBloc>(context)
                                        .add(event);
                                  },
                                ),
                              ),
                            )
                          : null;
                    },
                  ),
          );
        } else {
          if (state is UserDataLoadingError) {
            return Scaffold(
              body: Center(
                child: Text(
                  state.error.toString(),
                ),
              ),
            );
          }
          return const Scaffold(
            body: Center(
              child: Text("Error"),
            ),
          );
        }
      },
    );
  }
}
