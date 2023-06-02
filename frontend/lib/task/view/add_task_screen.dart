import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pro/LocalStroe/Store.dart';

import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';
import '../bloc/task_state.dart';
import '../model/task_model.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController emplooyeusername = TextEditingController();
    final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                "Add Task",
                style: TextStyle(fontSize: 24),
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
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                autofocus: true,
                minLines: 1,
                maxLines: 2,
                controller: emplooyeusername,
                decoration: const InputDecoration(
                  label: Text("Emplooye username"),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == "") {
                    return "Emplooye username is required";
                  } else {
                    return null;
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () => context.go("/tasklist"),
                      child: const Text("cancel")),
                  ElevatedButton(
                    onPressed: () {
                      String title = titleController.text;
                      String description = descriptionController.text;
                      if (title.isNotEmpty && description.isNotEmpty) {
                        final TaskEvent event = TaskCreate(
                          Task(
                            id: "",
                            title: title,
                            detail: description,
                            status: false,
                            due_date: "dsmlc",
                            date_created: "djnck",
                            farmname: UserPreferences.farmName,
                            assgined_to: emplooyeusername.text,
                          ),
                        );
                        BlocProvider.of<TaskBloc>(context).add(event);
                        context.go("/tasklist");
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
