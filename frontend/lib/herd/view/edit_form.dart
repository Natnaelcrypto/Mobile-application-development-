// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';


import '../herd_bloc/herd_bloc.dart';
import '../herd_bloc/herd_event.dart';
import '../model/herd_model.dart';

class EditHerd extends StatelessWidget {
  Herd herd;
  EditHerd({required this.herd});

  late TextEditingController hardIDController =
      TextEditingController(text: herd.herdID);
  late TextEditingController ageController =
      TextEditingController(text: herd.age);
  late TextEditingController breadController =
      TextEditingController(text: herd.bread);
  late TextEditingController genderController =
      TextEditingController(text: herd.gender);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Herd'),
        backgroundColor: Color.fromRGBO(36, 130, 50, .6),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: hardIDController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                  labelText: 'Herd Id',
                ),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: breadController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                  labelText: 'Bread',
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: ageController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                  labelText: 'Age',
                ),
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: genderController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                  labelText: 'Gender',
                ),
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.go("/herdlist");
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final HerdEvent event = HerdUpdate(
                      herd.id,
                      Herd(
                        farmname: herd.farmname,
                        herdID: hardIDController.text,
                        age: ageController.text,
                        bread: breadController.text,
                        health_history: herd.health_history,
                        vaccination: herd.vaccination,
                        medication: herd.medication,
                        pregnancy: herd.pregnancy,
                        gender: breadController.text,
                        id: herd.id,
                      ),
                    );
                    BlocProvider.of<HerdBloc>(context).add(event);
                    context.go("/herdlist");
                  },
                  child: const Text('Save'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
