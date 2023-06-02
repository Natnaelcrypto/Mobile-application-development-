import 'package:flutter/material.dart';

import '../model/Task_model.dart';

class EditTaskScreen extends StatelessWidget {
  final Task oldTask;
  const EditTaskScreen({super.key, required this.oldTask});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController =
        TextEditingController(text: oldTask.title);
    TextEditingController descriptionController =
        TextEditingController(text: oldTask.detail);
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            "Edit Task",
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: TextField(
              autofocus: true,
              controller: titleController,
              decoration: const InputDecoration(
                label: Text("Title"),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          TextField(
            autofocus: true,
            minLines: 3,
            maxLines: 20,
            controller: descriptionController,
            decoration: const InputDecoration(
              label: Text("Description"),
              border: OutlineInputBorder(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("cancel")),
              ElevatedButton(
                  onPressed: () {
                    var editedTask = Task(
                        id: "",
                        title: titleController.text,
                        detail: descriptionController.text,
                        date_created: DateTime.now().toString(),
                        status: false,
                        userID: oldTask.userID,
                        due_date: "");
                  },
                  child: const Text("Save"))
            ],
          ),
        ],
      ),
    );
  }
}
