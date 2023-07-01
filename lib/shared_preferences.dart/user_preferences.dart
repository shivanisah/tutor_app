import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutor_app/models/user_models/teacher_model.dart';

class UserPreferences with ChangeNotifier{

  Future<bool> saveUser(Teacher user)async{

    final SharedPreferences _pref = await SharedPreferences.getInstance();
      _pref.setString('email',user.email!);
      _pref.setInt('id',user.id!);
      _pref.setString('user_type',user.user_type!);
      notifyListeners();
      return _pref.commit();
  }

  void removeUser() async{
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.remove('email');
    _pref.remove('id');
    _pref.remove('user_type');
    notifyListeners();
  }

    Future<Teacher> getUser() async{
    final SharedPreferences _pref = await SharedPreferences.getInstance();

    int? id = _pref.getInt('id');
    String? email = _pref.getString('email');
    // String? name = _pref.getString('name');
    String? token = _pref.getString('token');
    bool? is_staff  = _pref.getBool('is_staff');
    String? user_type = _pref.getString('user_type');


    return Teacher(
      email: email,
      id: id,
      token: token,
      isStaff: is_staff,
      user_type: user_type,
    );

  }


}