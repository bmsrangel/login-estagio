import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _fbUser;
  String _fbPass;
  bool _success = false;

  final TextEditingController _usuario = TextEditingController();
  final TextEditingController _senha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[_usuarioForm(), _senhaForm(), _botaoLogin()],
        ),
      ),
    );
  }

  Widget _usuarioForm() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 100.0, 10.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        autofocus: false,
        controller: _usuario,
        decoration: InputDecoration(
            hintText: 'Usuário',
            icon: Icon(
              Icons.account_circle,
              color: Colors.deepPurple,
            )),
      ),
    );
  }

  Widget _senhaForm() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        autofocus: false,
        controller: _senha,
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Senha',
            icon: Icon(Icons.lock, color: Colors.deepPurple)),
      ),
    );
  }

  Widget _botaoLogin() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
      child: MaterialButton(
        elevation: 5.0,
        minWidth: 200.0,
        height: 42.0,
        color: Colors.deepPurple,
        onPressed: () => _validarUsuario(),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  void _mostrarDialogo(codigo) {
    String titulo, conteudo;
    if (codigo == 0) {
      titulo = 'Sucesso!';
      conteudo = 'Usuário logado com sucesso!';
    } else {
      titulo = 'Erro!';
      codigo == 1
          ? conteudo = 'Senha incorreta!'
          : conteudo = 'Usuário não encontrado';
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(titulo),
            content: Text(conteudo),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }

  _buscarNoBanco() async {
    Completer completer = new Completer();
    completer.complete(Firestore.instance
        .collection('users')
        .where('user', isEqualTo: '${_usuario.text}')
        .snapshots()
        .listen((data) => data.documents.forEach((doc) => setState(() {
              _fbUser = _usuario.text;
              _fbPass = doc['pass'];
            }))));
    return completer.future;
  }

  void _resetStates() {
    setState(() {
      _success = false;
      _fbUser = null;
      _fbPass = null;
    });
  }

  _validacao() {
    if (_fbUser != null) {
      if (_fbPass == _senha.text) {
        setState(() {
          _success = true;
        });
        _mostrarDialogo(0);
      } else {
        _resetStates();
        _mostrarDialogo(1);
      }
    } else {
      _resetStates();
      _mostrarDialogo(2);
    }
  }

  void _validarUsuario() async {
    await _buscarNoBanco();
    _validacao();
  }
}
