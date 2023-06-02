// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro/task/repository/task_repository.dart';
import 'package:pro/task/task_bloc/task_bloc.dart';
import 'package:pro/task/task_bloc/task_event.dart';
import 'package:pro/task/task_data_providers/API/task_data_provider.dart';
import 'package:pro/task/task_data_providers/Local_Storage/Local_Storage.dart';
import 'package:pro/user/user_bloc/user_bloc.dart';
import 'package:pro/user/user_bloc/user_event.dart';
import 'package:pro/user/user_data_providers/API/user_data_provider.dart';
import 'package:pro/user/user_data_providers/Local_storage/Localstorage.dart';
import 'package:pro/user/user_repository/user_repository.dart';

import 'LocalStroe/Store.dart';
import 'Route.dart';
import 'farm/farm_bloc/farm_bloc.dart';
import 'farm/farm_bloc/farm_event.dart';
import 'farm/farm_data_providers/API/API_farm_data_provider.dart';
import 'farm/farm_data_providers/local_storage/Local_farm_data_provider.dart';
import 'farm/farm_repository/farm_repository.dart';
import 'herd/herd_bloc/herd_bloc.dart';
import 'herd/herd_bloc/herd_event.dart';
import 'herd/herd_data_providers/API/herd_data_provider.dart';
import 'herd/herd_data_providers/Local_Storage/Local_data.dart';
import 'herd/herd_repository/herd_repository.dart';

class Startpage extends StatelessWidget {
  Startpage({super.key});
  final FarmDataProvider farmDataProvider = FarmDataProvider();
  final TaskDataProvider taskdataProvider = TaskDataProvider();
  final UserDataProvider userDataProvider = UserDataProvider();
  final HerdDataProvider herdDataProvide = HerdDataProvider();
  final TaskDbHelper taskdbHelper = TaskDbHelper();
  final UserDbHelper userDbHelper = UserDbHelper();
  final FarmDbHelper farmDbHelper = FarmDbHelper();
  final HerdDbHelper herdDbHelper = HerdDbHelper();
  @override
  Widget build(BuildContext context) {
    taskdbHelper.openDb();
    userDbHelper.openDb();
    farmDbHelper.openDb();
    herdDbHelper.openDb();
    UserPreferences.init();
    return MultiBlocProvider(providers: [
      BlocProvider<FarmBloc>(
        create: (BuildContext context) => FarmBloc(
          farmRepository: FarmRepository(farmDataProvider, farmDbHelper),
        )..add(
            const FarmLoad(),
          ),
      ),
      BlocProvider<TaskBloc>(
        create: (BuildContext context) => TaskBloc(
          taskRepository: TaskRepository(taskdataProvider, taskdbHelper),
        )..add(
            const TaskLoad(),
          ),
      ),
      BlocProvider<UserBloc>(
        create: (BuildContext context) => UserBloc(
            userRepository: UserRepository(userDataProvider, userDbHelper))
          ..add(
            const UserLoad(),
          ),
      ),
      BlocProvider<HerdBloc>(
        create: (BuildContext context) => HerdBloc(
            herdRepository: HerdRepository(herdDataProvide, herdDbHelper))
          ..add(const HerdLoad()),
      ),
    ], child: Routes_page());
  }
}
