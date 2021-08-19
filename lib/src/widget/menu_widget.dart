import 'package:flutter/material.dart';
import 'package:utesaapp/src/utils/utils.dart';

class MenuWidget extends StatelessWidget {

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
            onTap: () {},
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
          // ListTile(
          //   leading: Icon(Icons.settings,color: Colors.blue,),
          //   title: Text('Settings'),
          //   onTap: () { 
          //     Navigator.pop(context);
          //     Navigator.pushReplacementNamed(context, SettingsPage.routName);
          //   },
          // ),
        ],
      ),
    );
  }
}