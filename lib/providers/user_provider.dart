import 'package:flutter/material.dart';

import '../utils/users_shared_prefernce.dart';
import '../models/user_model.dart';

class UserProvider with ChangeNotifier{
  User? _user;
  User? get user => _user;

  Future<void> login(String uid, String username, String name, double latitude, double longitude, int phone) async{
    _user= User(uid: uid, username: username, name: name, latitude: latitude, longitude: longitude, phone:phone);
    await UsersSharedPreferences.saveUser(uid, username, name, phone);
    notifyListeners();
  }

  Future<void> logout() async{
    _user= null;
    await UsersSharedPreferences.clearUser();
    notifyListeners();
  }

  Future<void> checkLoggedIn() async {
    final Map<String, dynamic> userData = await UsersSharedPreferences.getUser(this);
  }

  void updateUser({
    String? uid,
    String? name,
    String? username,
    int? phone,
    double? latitude,
    double? longitude,
  }) {

    _user = User(
      uid: uid ?? _user?.uid ?? '',
      name: name ?? _user?.name ?? '',
      username: username ?? _user?.username ?? '',
      phone: phone ?? _user?.phone ?? 0,
      latitude: latitude ?? _user?.latitude ?? 0,
      longitude: longitude ?? _user?.longitude ?? 0,

    );

    notifyListeners();
  }
}