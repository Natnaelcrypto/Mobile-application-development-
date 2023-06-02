import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';
import 'package:pro/screens/Drawer.dart';

import '../../LocalStroe/Store.dart';
import '../../screens/Error_page.dart';
import '../../screens/Loading_page.dart';
import '../../user/model/user_model.dart';
import '../herd_bloc/herd_bloc.dart';
import '../herd_bloc/herd_event.dart';
import '../herd_bloc/herd_state.dart';
import '../model/herd_model.dart';


class HerdList extends StatefulWidget {
  final User user;
  const HerdList({required this.user});

  @override
  State<HerdList> createState() => _HerdListState();
}

class _HerdListState extends State<HerdList> {
  late TextEditingController searchController;

  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  int _selectedIndex = 0;
  final List<String> _options = [];
  // ignore: non_constant_identifier_names
  late String SelectedBreed = "";

  void _onChipSelected(int index) {
    setState(
      () {
        _selectedIndex = index;
        SelectedBreed = _options[index];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HerdBloc, HerdState>(
      builder: (context, state) {
        if (state is HerdDataLoadingError) {
          return const ErrorScreen();
        } else if (state is HerdLoading) {
          return LoadingScreen() ;
        } else {
          if (state is HerdDataLoaded) {
            final List<Herd> herds = state.herds as List<Herd>;
            for (int i = 0; i < herds.length; i++) {
              if (!_options.contains(herds[i].bread)) {
                _options.add(herds[i].bread);
              }
            }
            return Scaffold(
              appBar: AppBar(
                title: const Text("Herd List"),
                actions: [
                  UserPreferences.role.toLowerCase() == "user"
                      ? IconButton(
                          onPressed: () {
                            context.go("/addherd");
                          },
                          icon: Icon(Icons.add))
                      : const Text(""),
                  const SizedBox(
                    width: 5,
                  )
                ],
                backgroundColor: Color.fromRGBO(36, 130, 50, .6),
              ),
              drawer: Drawerpage(),
              body: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Material(
                        borderRadius: BorderRadius.circular(10),
                        child: Card(
                          color: Color.fromARGB(255, 203, 216, 227),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _options.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: ChoiceChip(
                                  label: Text(_options[index]),
                                  selected: _selectedIndex == index,
                                  onSelected: (bool selected) {
                                    _onChipSelected(index);
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Card(
                    // ignore: sized_box_for_whitespace
                    child: Container(
                      width: 200,
                      height: 30,
                      child: const Center(
                        child: Text(
                          "Herd Lists",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: herds.length,
                      itemBuilder: (context, index) {
                        return herds[index].bread.contains(SelectedBreed)
                            ? Card(
                                color: Color.fromRGBO(149, 178, 184, .9),
                                child: ListTile(
                                  title:
                                      Text("Herd ID: ${herds[index].farmname}"),
                                  subtitle:
                                      Text("Bread: ${herds[index].bread}"),
                                  trailing: SizedBox(
                                    width: 110,
                                    child: UserPreferences.role.toLowerCase() ==
                                            "user"
                                        ? Row(
                                            children: [
                                              IconButton(
                                                icon: Icon(
                                                  Icons.edit,
                                                  color: Colors.green,
                                                ),
                                                onPressed: () {
                                                  context.go(
                                                    "/editherd",
                                                    extra: herds[index],
                                                  );
                                                },
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () {
                                                  HerdEvent event = HerdDelete(
                                                      herds[index].id);
                                                  BlocProvider.of<HerdBloc>(
                                                          context)
                                                      .add(event);
                                                },
                                              ),
                                            ],
                                          )
                                        : Text(""),
                                  ),
                                  onTap: () {
                                    context.go("/herddetails",
                                        extra: herds[index]);
                                  },
                                ),
                              )
                            : null;
                      },
                    ),
                  )
                ],
              ),
            );
          }
        }
        return const ErrorScreen();
      },
    );
  }
}
