import 'package:flutter/material.dart';

import '../utils/users_shared_prefernce.dart';
import '../models/user_model.dart';

class UserProvider with ChangeNotifier{
  User? _user;
  User? get user => _user;

  Future<void> login(String uid, String username, String name) async{
    _user= User(uid: uid, username: username, name: name);
    await UsersSharedPreferences.saveUser(uid, username, name);
    notifyListeners();
  }

  Future<void> logout() async{
    _user= null;
    await UsersSharedPreferences.clearUser();
    notifyListeners();
  }

  Future<void> checkLoggedIn() async {
    final Map<String, String> userData = await UsersSharedPreferences.getUser(this);
  }

  void updateUser(User newUser) {
    _user = newUser;
    notifyListeners();
  }
}