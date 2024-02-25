import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';
import '../providers/user_provider.dart';

class UsersSharedPreferences {
  static Future<void> saveUser(String uid, String username, String name, int phone, {double latitude = 0.0, double longitude = 0.0}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('uid', uid);
    prefs.setString('username', username);
    prefs.setString("name", name);
    prefs.setDouble("latitude", latitude);
    prefs.setDouble("longitude", longitude);
    prefs.setInt("phone", phone);
  }

  static Future<void> clearUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("uid");
    prefs.remove("username");
    prefs.remove("name");
    prefs.remove("latitude");
    prefs.remove("longitude");
    prefs.remove("phone");
  }

  static Future<Map<String, dynamic>> getUser(UserProvider userProvider) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? uid = prefs.getString('uid');
    final String? username = prefs.getString('username');
    final String? name = prefs.getString('name');
    final double? latitude = prefs.getDouble('latitude');
    final double? longitude = prefs.getDouble('longitude');
    final int? phone = prefs.getInt('phone');

    if (uid != null && username != null && name != null) {
      //final newUser = User(uid: uid, username: username, name: name, latitude: latitude ?? 0.0, longitude: longitude ?? 0.0, phone: phone ?? 0);
      userProvider.updateUser(uid: uid, username: username, name: name, latitude: latitude, longitude: longitude,phone: phone);
    }

    return {'uid': uid ?? '', 'username': username ?? '', 'name': name ?? '', 'latitude': latitude ?? 0.0, 'longitude': longitude ?? 0.0, 'phone': phone ?? 0};
  }
}
