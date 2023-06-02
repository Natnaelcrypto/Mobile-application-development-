import 'package:pro/task/model/task_model.dart';
import '../data_providers/API/task_data_provider.dart';
import '../data_providers/Local_Storage/Local_Storage.dart';

class TaskRepository {
  TaskDataProvider taskdataProvider;
  TaskDbHelper dbHelper;
  TaskRepository(this.taskdataProvider, this.dbHelper);

  Future<Future<Task>> fetchOne(String id) async {
    return taskdataProvider.fetchOne(id);
  }

  Future<Task> create(Task task) async {
    await dbHelper.insertTask(task);
    return taskdataProvider.create(task);
  }

  Future<Task> update(String id, Task task) async {
    await dbHelper.updateTask(task);
    return taskdataProvider.update(id, task);
  }

  Future<List<Task>> fetchAll() async {
    try {
      final dataFromLocalDatabase = await dbHelper.getTaskLists();
      if (dataFromLocalDatabase.isNotEmpty) {
        return dataFromLocalDatabase;
      } else {
        final dataFromApi = await taskdataProvider.fetchAll();
        for (Task x in dataFromApi) {
          print(x.farmname);
          await dbHelper.insertTask(x);
        }

        return dataFromApi;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    // return taskdataProvider.fetchAll();
  }

  Future<void> delete(String id) async {
    await dbHelper.deletetask(id);
    taskdataProvider.delete(id);
  }
}
