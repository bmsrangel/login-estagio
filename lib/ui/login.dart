import 'package:flutter/material.dart';

import 'package:estagio/ui/register.dart';
import 'package:estagio/ui/home.dart';
import 'package:estagio/services/auth.dart';

class Login extends StatefulWidget {
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _usuario = TextEditingController();
  final _senha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[_usuarioForm(), _senhaForm(), _botaoLogin(), _botaoRegistrar()],
          ),
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
        decoration:
            InputDecoration(hintText: 'Senha', icon: Icon(Icons.lock, color: Colors.deepPurple)),
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
        onPressed: _handleLogin,
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _botaoRegistrar() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
      child: MaterialButton(
        elevation: 5.0,
        minWidth: 200.0,
        height: 42.0,
        color: Colors.deepPurple,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Registrar()));
        },
        child: Text(
          'Registrar',
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
      codigo == 1 ? conteudo = 'Senha incorreta!' : conteudo = 'Usuário não encontrado';
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
                onPressed: () {
                  Navigator.of(context).pop();
                  if (codigo == 0) {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => Home()));
                  }
                },
              )
            ],
          );
        });
  }

  void _handleLogin() async {
    AuthService auth = AuthService(_usuario.text, _senha.text);
    int _result = await auth.login();
    _mostrarDialogo(_result);
  }
}
