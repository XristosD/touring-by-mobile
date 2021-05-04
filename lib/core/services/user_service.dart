import 'package:touring_by/core/models/user.dart';
import 'package:touring_by/core/services/shared_preferences_service.dart';
import 'package:touring_by/locator.dart';

class UserService {
  User _user;

  Future<bool> createUser(Map<String, dynamic> jsonUser) async{
    // print(jsonUser);
    _user = User.fromJson(jsonUser);
    // print(_user.email);
    bool storeSuccess = await locator<SharedPreferencesService>().storeJson("user", jsonUser);
    return storeSuccess;
  }

  Future<User> getUser() async {
    if( _user == null ){
      var jsonUser = await locator<SharedPreferencesService>().getJson("user");
      _user = jsonUser == null ? null : User.fromJson(jsonUser);
    }

    return _user;
  }

  Future<bool> hasUser() async {
    await getUser();
    return _user == null ? false : true;
  }

  Future<String> getUsersToken() async {
    await getUser();
    // print(this._user.email);
    return _user == null ? null :_user.token;
  }


}