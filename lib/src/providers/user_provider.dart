import 'dart:convert';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
import 'package:utesaapp/src/shared_prefs/shared_preferences.dart';

class UserProvider {

  final String _urlBase = 'https://apps.ia3x.com/ute_app_utesa/index.php?';
  final _prefs = new UserPrefereces();

  Future<List<dynamic>> getRecinto() async {

    final resp = await http.get('$_urlBase/App/recintos');

    final decodedResp = json.decode(resp.body);

    return decodedResp["data"];
  }

  Future<Map<String, dynamic>> login( String recinto, String? user, String? password ) async {

    final authData = {
      "recinto" : recinto,
      "usuario" : user,
      "clave"   : password,
      "app_id"  : '20197521'
    };

    final resp = await http.post(
      '$_urlBase/App/login',
      body: authData
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);

    if( decodedResp["success"] ) {
      _prefs.token = decodedResp["data"]["token"];
      return {"ok" : true, "data" : decodedResp["data"]};
    }else {
      return {"ok": false, "message" : decodedResp["mensaje"] };
    }

  }

}