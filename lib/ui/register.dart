import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Registrar extends StatefulWidget {
  @override
  Registrar();
  _RegistrarState createState() => _RegistrarState();
}

class _RegistrarState extends State<Registrar> {
  final _usuario = TextEditingController();
  final _senha = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registrar"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
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
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Informe um usuário válido';
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0.0),
                child: TextFormField(
                  maxLines: 1,
                  autofocus: false,
                  controller: _senha,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'Senha', icon: Icon(Icons.lock, color: Colors.deepPurple)),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Este campo não pode ser vazio";
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: MaterialButton(
                  child: Text(
                    "Registrar",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _registrarUsuario();
                    }
                  },
                  color: Colors.deepPurple,
                  minWidth: 200.0,
                  height: 42.0,
                  elevation: 5.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _mostrarDialogo(dynamic e) {
    String titulo, conteudo;
    bool sucesso = false;
    if (e == null) {
      titulo = "Sucesso!";
      conteudo = "Cadastro realizado!";
      sucesso = true;
    } else {
      titulo = "Erro!";
      conteudo = e;
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
                  if (sucesso) {
                    Navigator.pop(context);
                  }
                },
              )
            ],
          );
        });
  }

  void _registrarUsuario() {
    try {
      Firestore.instance.collection("users").document(_usuario.text).setData({"pass": _senha.text});
      _mostrarDialogo(null);
    } catch (e) {
      _mostrarDialogo(e);
    }
  }
}
