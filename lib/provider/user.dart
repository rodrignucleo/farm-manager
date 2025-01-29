import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  Future<void> setUser(User? user) async {
    _user = user;
    notifyListeners();

    if (user != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userEmail', user.email ?? '');
      await prefs.setString('userUid', user.uid);
    }
  }

  Future<void> loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('userEmail');
    String? uid = prefs.getString('userUid');

    if (email != null && uid != null) {
      _user = FirebaseAuth.instance.currentUser; // Reautentica
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userEmail');
    await prefs.remove('userUid');

    _user = null;
    notifyListeners();
  }
}
