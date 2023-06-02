
import '../model/user_model.dart';
import '../user_data_providers/API/user_data_provider.dart';
import '../user_data_providers/Local_storage/Localstorage.dart';

class UserRepository {
  final UserDataProvider dataProvider;
  final UserDbHelper userDbHelper;
  UserRepository(this.dataProvider, this.userDbHelper);

  Future<User> create(User user) async {
    await userDbHelper.insertuser(user);
    return dataProvider.create(user);
  }

  Future<User> update(String id, User user) async {
    await userDbHelper.updateuser(user);
    return dataProvider.update(id, user);
  }

  Future<List<User>> fetchAll() async {
    try {
      final dataFromLocalDatabase = await userDbHelper.getuserLists();
      if (dataFromLocalDatabase.isNotEmpty) {
        return dataFromLocalDatabase;
      } else {
        final dataFromApi = await dataProvider.fetchAll();
        for (User x in dataFromApi) {
          await userDbHelper.insertuser(x);
        }

        return dataFromApi;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> delete(String id) async {
    await userDbHelper.deleteuser(id);
    dataProvider.delete(id);
  }
}
