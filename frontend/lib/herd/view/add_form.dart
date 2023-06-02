import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../LocalStroe/Store.dart';
import '../herd_bloc/herd_bloc.dart';
import '../herd_bloc/herd_event.dart';
import '../model/herd_model.dart';


class AddHerd extends StatefulWidget {
  const AddHerd({super.key});

  @override
  State<AddHerd> createState() => _AddHerdState();
}

class _AddHerdState extends State<AddHerd> {
  late TextEditingController hardIDController = TextEditingController();
  late TextEditingController ageController = TextEditingController();
  late TextEditingController breadController = TextEditingController();
  late TextEditingController genderController = TextEditingController();

  @override
  void dispose() {
    hardIDController.dispose();
    ageController.dispose();
    breadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Herd'),
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
                    final HerdEvent event = HerdCreate(
                      Herd(
                          farmname: UserPreferences.farmName,
                          herdID: hardIDController.text,
                          age: ageController.text,
                          bread: breadController.text,
                          health_history: [],
                          vaccination: [],
                          medication: [],
                          pregnancy: [],
                          gender: genderController.text,
                          id: ""),
                    );
                    BlocProvider.of<HerdBloc>(context).add(event);
                    context.go("/herdlist");
                  },
                  child: const Text('Add'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
