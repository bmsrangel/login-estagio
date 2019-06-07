import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  String usuario, senha;

  AuthService(this.usuario, this.senha);

  Future<int> login() async {
    int result;
    if (this.usuario != null) {
      DocumentSnapshot snapshot =
          await Firestore.instance.collection("users").document(this.usuario).get();
      if (snapshot.data == null) {
        result = 2;
      } else if (snapshot.data["pass"] == this.senha) {
        SharedPreferences perfs = await SharedPreferences.getInstance();
        await perfs.setBool('logged', true);
        await perfs.setString('user', this.usuario);
        result = 0;
      } else {
        result = 1;
      }
    }
    return result;
  }

  void logout() async {
    SharedPreferences perfs = await SharedPreferences.getInstance();
    await perfs.setBool('logged', false);
    await perfs.setString('user', null);
  }
}
