import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pro/farm/farm_model/farm_model.dart';

import '../../LocalStroe/Store.dart';
import '../../screens/Drawer.dart';
import '../../screens/Error_page.dart';
import '../../user/model/user_model.dart';

import '../farm_bloc/farm_bloc.dart';
import '../farm_bloc/farm_event.dart';
import '../farm_bloc/farm_state.dart';

class InventoryListScreen extends StatelessWidget {
  final User user;

  InventoryListScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FarmBloc, FarmState>(
      builder: (context, state) {
        if (state is FarmLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is FarmDataLoaded) {
          final List<Farm> item = state.farms;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Inventory List'),
              actions: [
                UserPreferences.role.toLowerCase() == "user"
                    ? IconButton(
                        icon: const Icon(Icons.add),
                        color: Color.fromRGBO(69, 55, 80, 0.9),
                        onPressed: () {
                          if (state is FarmDataLoaded) {
                            context.go("/additem", extra: state.farms);
                          }
                        },
                      )
                    : Text(""),
              ],
              backgroundColor: Color.fromRGBO(36, 130, 50, .6),
            ),
            drawer: Drawerpage(),
            body: item.isEmpty
                ? const Center(
                    child: Text("No item"),
                  )
                : ListView.builder(
                    itemCount: item.length,
                    itemBuilder: (context, index) {
                      return Material(
                        child: Card(
                          color: Color.fromRGBO(149, 178, 184, .9),
                          child: InkWell(
                            child: ListTile(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(5.0, 7.0, 5.0, 0.0),
                              leading: const Icon(Icons.local_grocery_store),
                              title: Text(item[index].itemName),
                              subtitle:
                                  Text('Quantity: ${item[index].quantity}'),
                              trailing: SizedBox(
                                width: 50,
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        FarmEvent event =
                                            FarmDelete(item[index].id_);
                                        BlocProvider.of<FarmBloc>(context)
                                            .add(event);
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                context.go('/itemdetail', extra: item[index]);
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          );
        } else {
          if (state is FarmDataLoadingError) {
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
              child: ErrorScreen(),
            ),
          );
        }
      },
    );
  }
}
