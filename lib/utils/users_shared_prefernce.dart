import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';
import '../providers/user_provider.dart';

class UsersSharedPreferences{
  static Future<void> saveUser(String uid, String username, String name) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('uid', uid);
    prefs.setString('username', username);
    prefs.setString("name", name);
  }

  static Future<void> clearUser() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("uid");
    prefs.remove("username");
    prefs.remove("name");
  }

  static Future<Map<String, String>> getUser(UserProvider userProvider) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? uid = prefs.getString('uid');
    final String? username = prefs.getString('username');
    final String? name = prefs.getString('name');

    if (uid != null && username != null && name != null) {
      final newUser = User(uid: uid, username: username, name: name);
      userProvider.updateUser(newUser);
    }

    return {'uid': uid ?? '', 'username': username ?? '', 'name': name ?? ''};
  }
}