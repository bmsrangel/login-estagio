import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:estagio/ui/login.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _usuario;
  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bem-vindo, $_usuario!"),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: _logout,
          )
        ],
      ),
      backgroundColor: Colors.white,
    );
  }

  void _getUser() async {
    SharedPreferences perfs = await SharedPreferences.getInstance();
    setState(() {
      _usuario = perfs.getString('user');
    });
  }

  void _logout() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Deseja mesmo sair?"),
            content: Text("Você será deslogado do sistema."),
            actions: <Widget>[
              FlatButton(
                child: Text('Não'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Sim'),
                onPressed: () async {
                  SharedPreferences perfs = await SharedPreferences.getInstance();
                  perfs.setBool('logged', false);
                  perfs.setString('user', null);
                  Navigator.pop(context);
                  // Navigator.of(context).pop();
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => Login()));
                },
              ),
            ],
          );
        });
  }
}
