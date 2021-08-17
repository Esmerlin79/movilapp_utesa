import 'package:flutter/material.dart';
import 'package:utesaapp/src/providers/services_provider.dart';
import 'package:utesaapp/src/utils/utils.dart';
import 'package:utesaapp/src/widget/menu_widget.dart';

class PensumPage extends StatelessWidget {

  final serviceProvider = ServicesProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mi Pensum"),
        backgroundColor: HexColor("327D57"),
      ),
      drawer: MenuWidget(),
      body: ListView(
        children:[ 
          FutureBuilder(
            future: serviceProvider.getPensum(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {

              if( snapshot.hasData ) {

                final pensumData = snapshot.data;
                final materias = pensumData["data"]["materias"];

                final List<Widget> materiaListWidget = [
                  Container(
                    padding: EdgeInsets.all(20.0),
                    width: double.infinity,
                    height: 60.0,
                    color: HexColor("FFCC00"),
                    child: Text(pensumData["data"]["carrera"], style: TextStyle(fontSize: 15.0),),
                  ),
                ];
                int isHeader1 = 0;
                int isHeader2 = 0;
                int isHeader3 = 0;
                int isHeader4 = 0;

                materias.forEach((materia) {
                  if( materia["cuatrimestre"] == 1 ){
                    isHeader1++;
                    materiaListWidget.add(
                      Container(
                          padding: EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              (isHeader1 < 2) ?
                              _pensumItemHeaer('1', materia["codigo"] + " - " + materia["nombre"])
                              : _pensumItem(materia["codigo"] + " - " + materia["nombre"]),
                            ],
                          ),
                        )
                    );                 
                  }                  
                });

                materias.forEach((materia) {
                  if( materia["cuatrimestre"] == 2 ){
                    isHeader2++;
                    materiaListWidget.add(
                      Container(
                          padding: EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              (isHeader2 < 2) ?
                              _pensumItemHeaer('2', materia["codigo"] + " - " + materia["nombre"])
                              : _pensumItem(materia["codigo"] + " - " + materia["nombre"]),
                            ],
                          ),
                        )
                    );                 
                  }                  
                });

                materias.forEach((materia) {
                  if( materia["cuatrimestre"] == 3 ){
                    isHeader3++;
                    materiaListWidget.add(
                      Container(
                          padding: EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              (isHeader3 < 2) ?
                              _pensumItemHeaer('3', materia["codigo"] + " - " + materia["nombre"])
                              : _pensumItem(materia["codigo"] + " - " + materia["nombre"]),
                            ],
                          ),
                        )
                    );                 
                  }                  
                });

                materias.forEach((materia) {
                  if( materia["cuatrimestre"] == 4 ){
                    isHeader4++;
                    materiaListWidget.add(
                      Container(
                          padding: EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              (isHeader4 < 2) ?
                              _pensumItemHeaer('4', materia["codigo"] + " - " + materia["nombre"])
                              : _pensumItem(materia["codigo"] + " - " + materia["nombre"]),
                            ],
                          ),
                        )
                    );                 
                  }                  
                });

                return Column(
                  children: materiaListWidget,
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

  Widget _pensumItemHeaer(numCuatrimestre, nombre) {

    return Column(
      children: [
        Container(
          child: Center(child: Text('Cuatrimestre $numCuatrimestre', style: TextStyle(color: Colors.white, fontSize: 16.0),)),
          color: Colors.green, 
          width: double.infinity, 
          height: 40,
        ),
         ListTile(
          title: Text(nombre),
        ),
        Divider(),
      ],
    );
  }

  Widget _pensumItem(nombre) {

    return Column(
      children: [
         ListTile(
          title: Text(nombre),
        ),
        Divider(),
      ],
    );
  }
}