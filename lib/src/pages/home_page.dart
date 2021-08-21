import 'package:flutter/material.dart';
import 'package:utesaapp/src/providers/services_provider.dart';
import 'package:utesaapp/src/shared_prefs/shared_preferences.dart';
import 'package:utesaapp/src/utils/utils.dart';
import 'package:utesaapp/src/widget/logout_widget.dart';
import 'package:utesaapp/src/widget/menu_widget.dart';

class HomePage extends StatelessWidget {

  final _prefs = new UserPrefereces();
  final serviceProvider = ServicesProvider();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
        backgroundColor: HexColor("327D57"),
      ),
      drawer: MenuWidget(),
      body: Column(
        children: [
          _header(context),
          ListTile(
            title: Text('INFORMACION BASICA'),
          ),
          Divider(),
          FutureBuilder(
            future: serviceProvider.initialSession(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {

              final infoData = snapshot.data;

              if( snapshot.hasData ){
                          
              if( !infoData["ok"] ){
                return LogoutWidget();
              }
                return Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.person_outline,color: Colors.black),
                      title: Text(_prefs.nombre),
                    ),
                    ListTile(
                      leading: Icon(Icons.email_outlined,color: Colors.black),
                      title: Text(_prefs.correo),
                    ),
                    ListTile(
                      leading: Icon(Icons.book_outlined,color: Colors.black),
                      title: Text('Cantidad de materias: ' + infoData["data"]["cantidad_de_materias"].toString()),
                    ),
                    ListTile(
                      leading: Icon(Icons.table_chart_outlined,color: Colors.black),
                      title: Text('Indice academico: ' +infoData["data"]["indice_academico"].toString()),
                    ),
                    ListTile(
                      leading: Icon(Icons.money_outlined,color: Colors.black),
                      title: Text('Balance pendiente: ' +infoData["data"]["balance_pendiente"].toString()),
                    ),
                  ],
                );
              }else {
                return Container(
                  padding: EdgeInsets.only(top: 30.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
          
        ],
      ),
    );
  }

  Widget _header( BuildContext context ) {

    final size = MediaQuery.of(context).size;

    return Container(
      color: HexColor("327D57"),
      height: size.height * 0.35,
      width: double.infinity,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 20.0),
            child: Image(
              height: 150.0,
              width: 150.0,
              color: Colors.white,
              image: AssetImage('assets/user.png'),
              fit: BoxFit.cover,
            ),
          ),
          Text(_prefs.nombre, style: TextStyle(fontSize: 30.0, color: Colors.white),),
          Text(_prefs.carrera, style: TextStyle(fontSize: 20.0, color: Colors.white),)
        ],
      ),
    );
  }
}