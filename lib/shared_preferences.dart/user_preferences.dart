import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutor_app/models/user_models/teacher_model.dart';

class UserPreferences with ChangeNotifier{

  Future<bool> saveUser(Teacher user)async{

    final SharedPreferences _pref = await SharedPreferences.getInstance();
      _pref.setString('email',user.email!);
      _pref.setInt('id',user.id!);
      notifyListeners();
      return _pref.commit();
  }

  void removeUser() async{
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.remove('email');
    _pref.remove('id');
    notifyListeners();
  }

    Future<Teacher> getUser() async{
    final SharedPreferences _pref = await SharedPreferences.getInstance();

    int? id = _pref.getInt('id');
    String? email = _pref.getString('email');
    String? token = _pref.getString('token');
    bool? is_staff  = _pref.getBool('is_staff');

    return Teacher(
      email: email,
      id: id,
      token: token,
      isStaff: is_staff
    );

  }


}