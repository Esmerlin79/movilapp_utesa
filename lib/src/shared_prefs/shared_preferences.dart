

import 'package:shared_preferences/shared_preferences.dart';

class UserPrefereces {

  static final UserPrefereces _intance = new UserPrefereces._internal();

  factory UserPrefereces() {
    return _intance;
  }
  UserPrefereces._internal();

  SharedPreferences? _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  get token {
    return _prefs!.getString('token') ?? '';
  }
  set token( dynamic value ) {
    _prefs!.setString('token', value);
  }

  get nombre {
    return _prefs!.getString('nombre') ?? '';
  }
  set nombre( dynamic value ) {
    _prefs!.setString('nombre', value);
  }

  get carrera {
    return _prefs!.getString('carrera') ?? '';
  }
  set carrera( dynamic value ) {
    _prefs!.setString('carrera', value);
  }

  get correo {
    return _prefs!.getString('correo') ?? '';
  }
  set correo( dynamic value ) {
    _prefs!.setString('correo', value);
  }
  
} 