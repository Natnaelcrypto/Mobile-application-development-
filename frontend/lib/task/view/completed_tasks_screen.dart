import 'package:flutter/material.dart';
import 'package:pro/task/view/tasks_list.dart';

class CompletedTasksScreen extends StatelessWidget {
  const CompletedTasksScreen({Key? key}) : super(key: key);
  static const id = "tasks_screen";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 10),
          child: Center(
            child: Chip(
              label: Text(
                ' Tasks',
              ),
            ),
          ),
        ),
        SizedBox(
          width: 400,
          height: 450,
          child: TasksList(status: true),
        )
      ],
    );
  }
}
