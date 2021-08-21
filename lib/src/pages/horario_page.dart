import 'package:flutter/material.dart';
import 'package:utesaapp/src/providers/services_provider.dart';
import 'package:utesaapp/src/utils/utils.dart';
import 'package:utesaapp/src/widget/logout_widget.dart';
import 'package:utesaapp/src/widget/menu_widget.dart';

class HorarioPage extends StatelessWidget {

  final serviceProvider = ServicesProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mi Horario"),
        backgroundColor: HexColor("327D57"),
      ),
      drawer: MenuWidget(),
      body: _crearHorarioList(),
    );
  }

  Widget _crearHorarioList() {
    return FutureBuilder(
      future: serviceProvider.getHorarios(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if( snapshot.hasData ){

            final horarios = snapshot.data;
            if( !horarios["ok"] ){
              return LogoutWidget();
            }
            final horariosList = horarios["data"];

            return ListView.builder(
              itemCount: horariosList.length,
              itemBuilder: (BuildContext context, int i) => _crearHorarioItem(horariosList[i]),
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

  Widget _crearHorarioItem(horario) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      child: Column(
        children:[
           Row(
              children: [
                Icon(Icons.date_range, size: 40.0, color: HexColor("327D57"),),
                SizedBox(width: 10.0,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(horario["nombre"], style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                    SizedBox(height: 3.0,),
                    Text('Profesor: ${horario["profesor"]}'),
                    Text('Creditos: ${horario["creditos"]}'),
                    Text('Aula: ${horario["aula"]}'),
                    Text('Nota: ${horario["nota"]}'),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 80.0,),
                    Text(horario["horario"], textAlign: TextAlign.justify, style:  TextStyle(fontSize: 13.0,),),
                  ],
                ),
              ],
          ),
          SizedBox(height: 15.0,),
          Divider(),
          // SizedBox(height: 5.0,),
          
        ],
      ),
    );
  }
}