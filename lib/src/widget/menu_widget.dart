import 'package:flutter/material.dart';
import 'package:utesaapp/src/shared_prefs/shared_preferences.dart';
import 'package:utesaapp/src/utils/utils.dart';

class MenuWidget extends StatelessWidget {

  final _prefs = new UserPrefereces();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Container(
              padding: EdgeInsets.only(top: 40.0),
              child: Center(
                child: Column(
                  children:[ 
                    Text('UTESA', style: TextStyle(color: HexColor("327D57"), fontWeight: FontWeight.bold, fontSize: 40.0),),
                    Text('Universidad Tecnologica de Santiago'),
                  ]
                ) 
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.pages,color: HexColor("327D57"),),
            title: Text('Inicio'),
            onTap: () => Navigator.pushReplacementNamed(context, 'home'),
          ),
          ListTile(
            leading: Icon(Icons.list,color: HexColor("327D57")),
            title: Text('Pensum'),
            onTap: () => Navigator.pushReplacementNamed(context, 'pensum'),
          ),
          ListTile(
            leading: Icon(Icons.query_builder,color: HexColor("327D57")),
            title: Text('Horarios'),
            onTap: () => Navigator.pushReplacementNamed(context, 'horario'),
          ),
          ListTile(
            leading: Icon(Icons.pending_actions_outlined,color: HexColor("327D57")),
            title: Text('Asignaturas Pendientes'),
            onTap: () => Navigator.pushReplacementNamed(context, 'pending'),
          ),
          ListTile(
            leading: Icon(Icons.auto_stories_outlined,color: HexColor("327D57")),
            title: Text('Clases Virtuales'),
            onTap: () => Navigator.pushReplacementNamed(context, 'class'),
          ),
          ListTile(
            leading: Icon(Icons.auto_awesome_mosaic_outlined,color: HexColor("327D57")),
            title: Text('Calificaciones'),
            onTap: () => Navigator.pushReplacementNamed(context, 'ratings'),
          ),
          ListTile(
            leading: Icon(Icons.calendar_today, color: HexColor("327D57")),
            title: Text('Calendario de Eventos'),
            onTap: () => Navigator.pushReplacementNamed(context, 'calendar'),
          ),
          ListTile(
            leading: Icon(Icons.chrome_reader_mode_outlined, color: HexColor("327D57")),
            title: Text('Noticias'),
            onTap: () => Navigator.pushReplacementNamed(context, 'news'),
          ),
          ListTile(
            leading: Icon(Icons.video_call_outlined, color: HexColor("327D57")),
            title: Text('Videos'),
            onTap: () => Navigator.pushReplacementNamed(context, 'video'),
          ),
          ListTile(
            leading: Icon(Icons.contact_support_outlined, color: HexColor("327D57")),
            title: Text('Quejas'),
            onTap: () => Navigator.pushReplacementNamed(context, 'complaints'),
          ),
          ListTile(
            leading: Icon(Icons.support_sharp, color: HexColor("327D57")),
            title: Text('Sugerencias'),
            onTap: () => Navigator.pushReplacementNamed(context, 'suggestion'),
          ),
          ListTile(
            leading: Icon(Icons.power_settings_new_rounded ,color: HexColor("327D57"),),
            title: Text('Salir'),
            onTap: () { 
              _prefs.token = "";
              Navigator.pushReplacementNamed(context, 'login');
            },
          ),
        ],
      ),
    );
  }
}