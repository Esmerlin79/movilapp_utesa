import 'package:flutter/material.dart';
import 'package:utesaapp/src/providers/services_provider.dart';
import 'package:utesaapp/src/utils/utils.dart';
import 'package:utesaapp/src/widget/logout_widget.dart';
import 'package:utesaapp/src/widget/menu_widget.dart';

class SignaturePending extends StatelessWidget {

   final serviceProvider = ServicesProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Asignaturas Pendientes"),
        backgroundColor: HexColor("327D57"),
      ),
      drawer: MenuWidget(),
      body: ListView(
        children: [
          SizedBox(height: 20.0,),
          _signaturePendingList(),
        ],
      ),
    );
  }
  _signaturePendingList() {
    return FutureBuilder(
      future: serviceProvider.getSignaturePending(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        
        final signatureData = snapshot.data;

        if( snapshot.hasData ) {

          if( !signatureData["ok"] ){
            return LogoutWidget();
          }

          final materias = signatureData["data"]["materias"];
          final List<Widget> siganuteListWidget = [];
          
          materias.forEach((signautre) {
              siganuteListWidget.add(
                  ListTile(
                  leading: Icon(Icons.av_timer,color: HexColor("327D57")),
                  title: Text(signautre["codigo"] + " - " +signautre["nombre"],),
                  subtitle: Text("Cuatrimestre " + signautre["cuatrimestre"].toString()),
                ),
              );
              siganuteListWidget.add(
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  height: 2.0,
                  color: HexColor("E7E7E7"),
                ),
              );            
          });

          return Column(
            children: siganuteListWidget,
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
    );
  }
}