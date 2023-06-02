// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:pro/herd/view/update_history.dart';

import '../../screens/Error_page.dart';
import '../herd_bloc/herd_bloc.dart';
import '../herd_bloc/herd_event.dart';
import '../herd_bloc/herd_state.dart';
import '../model/herd_model.dart';

class HerdDetails extends StatefulWidget {
  final Herd herd;

  HerdDetails({required this.herd});
  @override
  State<HerdDetails> createState() => _HerdDetailsState();
}

class _HerdDetailsState extends State<HerdDetails> {
  void _addTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          // ignore: prefer_const_constructors
          child: UpdateherdhisoryScreen(
            herd: widget.herd,
            selacted: "",
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HerdEvent event = HerdLoad();
    BlocProvider.of<HerdBloc>(context).add(event);
  }

  late Herd herdData;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HerdBloc, HerdState>(builder: (context, state) {
      print(state);

      if (state is HerdDataLoaded) {
        var herdDatas = state.herds;
        for (Herd newherd in herdDatas) {
          if (widget.herd.herdID == newherd) {
            print(newherd);
            herdData = newherd;
            break;
          }
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text("Herd Details Page"),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                context.go("/herdlist");
              },
            ),
            backgroundColor: Color.fromRGBO(36, 130, 50, .6),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 5.0),
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Breed',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text("${widget.herd.bread}"),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 5.0),
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Age',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(widget.herd.age)
                                ]),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 5.0),
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Id',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                                Text(widget.herd.herdID)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 40.0,
                  ),

                  // Health History -----------
                  Card(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(5.0),
                      color: Color.fromARGB(255, 223, 222, 222),
                      child: const Text(
                        "Health History",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  SizedBox(
                    height: 250,
                    child: Card(
                      child: ListView.builder(
                        itemCount: widget.herd.health_history.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "Title: ${widget.herd.health_history[index]["title"]}"),
                                Text(
                                    "Description: ${widget.herd.health_history[index]["description"]}"),
                                Text(
                                    "Date: ${widget.herd.health_history[index]["date"]}"),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  ElevatedButton(
                    onPressed: () => {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            // ignore: prefer_const_constructors
                            child: UpdateherdhisoryScreen(
                              herd: widget.herd,
                              selacted: "health",
                            ),
                          ),
                        ),
                      )
                    },
                    child: const Text('Add health history'),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),

                  // Medication History ------------
                  Card(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(5.0),
                      color: Color.fromARGB(255, 223, 222, 222),
                      child: const Text(
                        "Medication History",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  SizedBox(
                    height: 250,
                    child: Card(
                      child: ListView.builder(
                        itemCount: widget.herd.medication.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "Title: ${widget.herd.medication[index]["title"]}"),
                                Text(
                                    "Description: ${widget.herd.medication[index]["description"]}"),
                                Text(
                                    "Date: ${widget.herd.medication[index]["date"]}"),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  ElevatedButton(
                    onPressed: () => {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            // ignore: prefer_const_constructors
                            child: UpdateherdhisoryScreen(
                              herd: widget.herd,
                              selacted: "medication",
                            ),
                          ),
                        ),
                      )
                    },
                    child: const Text('Add Medication History'),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),

                  // Vaccination History --------------
                  Card(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(5.0),
                      color: Color.fromARGB(255, 223, 222, 222),
                      child: const Text(
                        "Vaccination History",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10.0),
                  SizedBox(
                    height: 250,
                    child: Card(
                      child: ListView.builder(
                        itemCount: widget.herd.vaccination.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "Title: ${widget.herd.vaccination[index]["title"]}"),
                                Text(
                                    "Description: ${widget.herd.vaccination[index]["description"]}"),
                                Text(
                                    "Date: ${widget.herd.vaccination[index]["date"]}"),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  ElevatedButton(
                    onPressed: () => {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            // ignore: prefer_const_constructors
                            child: UpdateherdhisoryScreen(
                              herd: widget.herd,
                              selacted: "vaccination",
                            ),
                          ),
                        ),
                      )
                    },
                    child: const Text('Add Vaccination History'),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),

                  // Pregnancy History ----------------
                  Card(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(5.0),
                      color: Color.fromARGB(255, 223, 222, 222),
                      child: const Text(
                        "Pregnancy History",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  SizedBox(
                    height: 250,
                    child: Card(
                      child: ListView.builder(
                        itemCount: widget.herd.pregnancy.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "Title: ${widget.herd.pregnancy[index]["title"]}"),
                                Text(
                                    "Description: ${widget.herd.pregnancy[index]["description"]}"),
                                Text(
                                    "Data: ${widget.herd.pregnancy[index]["date"]}"),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  ElevatedButton(
                    onPressed: () => {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            // ignore: prefer_const_constructors
                            child: UpdateherdhisoryScreen(
                              herd: herdData,
                              selacted: "pregnancy",
                            ),
                          ),
                        ),
                      )
                    },
                    child: const Text('Add pregnancy history'),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                ],
              ),
            ),
          ),
        );
      }
      return ErrorScreen();
    });
  }
}
