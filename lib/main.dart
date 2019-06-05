import 'package:flutter/material.dart';
import 'package:estagio/ui/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Login', theme: ThemeData(primarySwatch: Colors.deepPurple), home: Login());
  }
}
