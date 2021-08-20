
import 'package:flutter/material.dart';
import 'package:utesaapp/src/pages/calendar_page.dart';
import 'package:utesaapp/src/pages/home_page.dart';
import 'package:utesaapp/src/pages/horario_page.dart';

import 'package:utesaapp/src/pages/login_page.dart';
import 'package:utesaapp/src/pages/pensum_page.dart';
import 'package:utesaapp/src/pages/ratings_page.dart';
import 'package:utesaapp/src/pages/signaturePending_page.dart';
import 'package:utesaapp/src/pages/video_page.dart';
import 'package:utesaapp/src/pages/virtualClass_page.dart';
import 'package:utesaapp/src/shared_prefs/shared_preferences.dart';
 
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new UserPrefereces();
  await prefs.initPrefs();

  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'login',
      routes: {
        'login'    : (BuildContext context) => LoginPage(),
        'home'     : (BuildContext context) => HomePage(),
        'pensum'   : (BuildContext context) => PensumPage(),
        'pending'  : (BuildContext context) => SignaturePending(),
        'class'    : (BuildContext context) => VirtualClassPage(),
        'ratings'  : (BuildContext context) => RatingsPage(),
        'horario'  : (BuildContext context) => HorarioPage(),
        'calendar' : (BuildContext context) => CalendarPage(),
        'video'    : (BuildContext context) => VideoPage(),

      },
    );
  }
}