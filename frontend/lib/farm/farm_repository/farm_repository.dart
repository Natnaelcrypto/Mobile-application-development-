import '../farm_data_providers/API/API_farm_data_provider.dart';
import '../farm_data_providers/local_storage/Local_farm_data_provider.dart';
import '../farm_model/farm_model.dart';

class FarmRepository {
  FarmDataProvider dataProvider;
  FarmDbHelper farmDbHelper;

  FarmRepository(this.dataProvider, this.farmDbHelper);

  Future<Future<Farm>> fetchOne(String id) async {
    return dataProvider.fetchOne(id);
  }

  Future<Farm> create(Farm farm) async {
    var result = await dataProvider.create(farm);
    await farmDbHelper.insertfarm(result);
    return result;
  }

  Future<Farm> update(String id, Farm farm) async {
    await farmDbHelper.updatefarm(farm);
    return dataProvider.update(id, farm);
  }

  Future<List<Farm>> fetchAll() async {
    try {
      final dataFromLocalDatabase = await farmDbHelper.getfarmLists();
      if (dataFromLocalDatabase.isNotEmpty) {
        return dataFromLocalDatabase;
      } else {
        final dataFromApi = await dataProvider.fetchAll();
        for (Farm x in dataFromApi) {
          await farmDbHelper.insertfarm(x);
        }

        return dataFromApi;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    // return await dataProvider.fetchAll();
  }

  Future<void> delete(String id) async {
    print("delated$id");
    await farmDbHelper.deletefarm(id);
    dataProvider.delete(id);
  }
}
