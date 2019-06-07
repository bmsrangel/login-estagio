import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:estagio/ui/login.dart';
import 'package:estagio/ui/home.dart';

void main() async {
  Widget _defaultHome = Login();
  bool logged = false;

  SharedPreferences perfs = await SharedPreferences.getInstance();
  logged = perfs.getBool('logged');
  if (logged) {
    _defaultHome = Home();
  }
  runApp(MaterialApp(
      title: 'Estágio', theme: ThemeData(primarySwatch: Colors.deepPurple), home: _defaultHome));
}
