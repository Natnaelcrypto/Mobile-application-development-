import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../LocalStroe/Store.dart';
import '../../user/bloc/user_event.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';
import '../bloc/task_state.dart';
import '../model/task_model.dart';

class TasksList extends StatelessWidget {
  bool status;

  TasksList({
    required this.status,
    super.key,
  });
  final bool statu = false;
  final bool done = true;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is TaskDataLoadingError) {
          print(state.error.toString());
        }
        if (state is TaskLoading) {
        } else {
          if (state is TaskDataLoaded) {
            final List<Task> tasks = [];
            state.tasks.forEach(
              (element) {
                if (status == element.status) {
                  tasks.add(element);
                }
              },
            );

            return tasks.isEmpty
                ? const Center(
                    child: Text("No Task"),
                  )
                : ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return UserPreferences.role == "emplooye"
                          ? tasks[index].assgined_to == UserPreferences.username
                              ? InkWell(
                                  onTap: () {},
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "Title: ${tasks.elementAt(index).title}"),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                  'Due Date: ${tasks.elementAt(index).due_date}'),
                                              Text(
                                                  'detaile: ${tasks.elementAt(index).detail}')
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              (UserPreferences.role
                                                              .toLowerCase() ==
                                                          "employe" &&
                                                      !statu)
                                                  ? Checkbox(
                                                      value:
                                                          tasks[index].status,
                                                      onChanged: (done) {
                                                        final Task task = Task(
                                                            assgined_to: tasks[
                                                                    index]
                                                                .assgined_to,
                                                            farmname:
                                                                UserPreferences
                                                                    .farmName,
                                                            title: tasks[index]
                                                                .title,
                                                            detail: tasks[index]
                                                                .detail,
                                                            status: done!,
                                                            id: tasks[index].id,
                                                            due_date:
                                                                tasks[index]
                                                                    .due_date,
                                                            date_created: tasks[
                                                                    index]
                                                                .date_created);
                                                        TaskEvent event =
                                                            TaskUpdate(
                                                                tasks[index].id,
                                                                task);
                                                        BlocProvider.of<
                                                                    TaskBloc>(
                                                                context)
                                                            .add(event);
                                                      },
                                                    )
                                                  : Text(""),
                                              UserPreferences.role
                                                          .toLowerCase() ==
                                                      "user"
                                                  ? IconButton(
                                                      onPressed: () {
                                                        TaskEvent event =
                                                            TaskDelete(tasks
                                                                .elementAt(
                                                                    index)
                                                                .id);

                                                        BlocProvider.of<
                                                                    TaskBloc>(
                                                                context)
                                                            .add(event);
                                                      },
                                                      icon: const Icon(
                                                          Icons.delete),
                                                    )
                                                  : const Text("")
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : null
                          : InkWell(
                              onTap: () {},
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "Title: ${tasks.elementAt(index).title}"),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                              'Due Date: ${tasks.elementAt(index).due_date}'),
                                          Text(
                                              'detaile: ${tasks.elementAt(index).detail}')
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Checkbox(
                                            value: tasks[index].status,
                                            onChanged: (done) {
                                              print(
                                                  "from screen${tasks[index].id}");
                                              final Task task = Task(
                                                  assgined_to:
                                                      tasks[index].assgined_to,
                                                  farmname:
                                                      UserPreferences.farmName,
                                                  title: tasks[index].title,
                                                  detail: tasks[index].detail,
                                                  status: done!,
                                                  id: tasks[index].id,
                                                  due_date:
                                                      tasks[index].due_date,
                                                  date_created: tasks[index]
                                                      .date_created);
                                              TaskEvent event = TaskUpdate(
                                                  tasks[index].id, task);
                                              BlocProvider.of<TaskBloc>(context)
                                                  .add(event);
                                            },
                                          ),
                                          UserPreferences.role.toLowerCase() ==
                                                  "user"
                                              ? IconButton(
                                                  onPressed: () {
                                                    print(tasks
                                                        .elementAt(index)
                                                        .detail);
                                                    print("Delated");
                                                    TaskEvent event =
                                                        TaskDelete(tasks
                                                            .elementAt(index)
                                                            .id);

                                                    BlocProvider.of<TaskBloc>(
                                                            context)
                                                        .add(event);
                                                  },
                                                  icon:
                                                      const Icon(Icons.delete),
                                                )
                                              : const Text("")
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                    },
                  );
          }
          return Text("Error");
        }
        return Text("Errors");
      },
    );
  }
}

// Expanded(
//       child: ListView.builder(
//           itemCount: taskList.length,
//           itemBuilder: ((context, index) {
//             var task = taskList[index];
//             return TaskTile(task: task);
//           })),
//     );

