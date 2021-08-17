import 'dart:convert';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
import 'package:utesaapp/src/shared_prefs/shared_preferences.dart';


class ServicesProvider {
  final String _urlBase = 'https://apps.ia3x.com/ute_app_utesa/index.php?';
  final _prefs = new UserPrefereces();

  Future<Map<String, dynamic>> initialSession() async {

    final authData = {
      "token" : _prefs.token,
    };

     final resp = await http.post(
      '$_urlBase/App/inicio',
      body: authData
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp["data"]);

    if( decodedResp["success"] ) {
      return {"ok" : true, "data" : decodedResp["data"]};
    }else {
      return {"ok": false, "message" : decodedResp["mensaje"] };
    }

  }
  
}