import 'package:pro/user/model/user_model.dart';

import '../auth_data_providers/auth_data_provider.dart';
import '../auth_model/auth.dart';

// import '../../user/model/User_model.dart';

class AuthRepository {
  final AuthDataProvider dataProvider;
  AuthRepository(this.dataProvider);

  Future<User> login(Auth auth) async {
    
    return await dataProvider.post_login(auth);
  }

  Future<User> signup(User user) async {
    return await dataProvider.post_signup(user);
  }

  // ignore: non_constant_identifier_names
  Future<Future<String>> get_user() async {
    return dataProvider.get();
  }
}
