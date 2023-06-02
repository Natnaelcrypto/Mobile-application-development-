import 'package:pro/herd/herd_data_providers/Local_Storage/Local_data.dart';

import '../herd_data_providers/API/herd_data_provider.dart';
import '../model/herd_model.dart';

class HerdRepository {
  final HerdDataProvider dataProvider;
  HerdDbHelper herdDbHelper;
  HerdRepository(this.dataProvider, this.herdDbHelper);

  Future<Herd> fetchOne(String id) async {
    return dataProvider.fetchOne(id);
  }

  Future<Herd> create(Herd herd) async {
    Herd result=await dataProvider.create(herd);
    await herdDbHelper.insertHerd(result);
    return result;
  }

  Future<Herd> update(String id, Herd herd) async {
    await herdDbHelper.updateHerd(herd);
    return dataProvider.update(id, herd);
  }

  Future<List<Herd>> fetchAll() async {
    try {
      final dataFromLocalDatabase = await herdDbHelper.getHerdLists();
      if (dataFromLocalDatabase.isNotEmpty) {
        return dataFromLocalDatabase;
      } else {
        final dataFromApi = await dataProvider.fetchAll();
        for (Herd x in dataFromApi) {
          await herdDbHelper.insertHerd(x);
        }

        return dataFromApi;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    // return dataProvider.fetchAll();
  }

  Future<void> delete(String id) async {
    await herdDbHelper.deleteherd(id);
    dataProvider.delete(id);
  }
}
