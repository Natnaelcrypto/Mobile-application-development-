import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pro/herd/model/herd_model.dart';

import '../herd_bloc/herd_bloc.dart';
import '../herd_bloc/herd_event.dart';
import '../herd_bloc/herd_state.dart';

// ignore: must_be_immutable
class UpdateherdhisoryScreen extends StatelessWidget {
  Herd herd;
  String selacted;
  UpdateherdhisoryScreen(
      {super.key, required this.herd, required this.selacted});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

    DateTime now = DateTime.now();
    String day = "${now.year / now.month / now.day}";

    return BlocBuilder<HerdBloc, HerdState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                "Add ${selacted} history",
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: TextFormField(
                  autofocus: true,
                  controller: titleController,
                  decoration: const InputDecoration(
                    label: Text("Title"),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == "") {
                      return "Title is required";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              TextFormField(
                autofocus: true,
                minLines: 3,
                maxLines: 20,
                controller: descriptionController,
                decoration: const InputDecoration(
                  label: Text("Description"),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == "") {
                    return "Description is required";
                  } else {
                    return null;
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => context.go("/herddetails"),
                    child: const Text("cancel"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      String title = titleController.text;
                      String description = descriptionController.text;
                      if (title.isNotEmpty && description.isNotEmpty) {
                        var newObject = {
                          "title": title,
                          "description": description,
                          "date": day
                        };

                        print(selacted);
                        if (selacted == "health") {
                          herd.health_history.add(newObject);
                        } else if (selacted == "medication") {
                          herd.medication.add(newObject);
                        } else if (selacted == "pregnancy") {
                          herd.pregnancy.add(newObject);
                        } else if (selacted == "vaccination") {
                          herd.vaccination.add(newObject);
                        }

                        final HerdEvent event = HerdUpdate(
                          herd.id,
                          Herd(
                            farmname: herd.farmname,
                            herdID: herd.herdID,
                            age: herd.age,
                            bread: herd.bread,
                            health_history: herd.health_history,
                            vaccination: herd.vaccination,
                            medication: herd.medication,
                            pregnancy: herd.pregnancy,
                            gender: herd.gender,
                            id: herd.id,
                          ),
                        );
                        BlocProvider.of<HerdBloc>(context).add(event);
                        context.go("/herddetails");
                      }
                    },
                    child: const Text("Add"),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
