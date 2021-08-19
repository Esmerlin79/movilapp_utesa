import 'package:flutter/material.dart';
import 'package:utesaapp/src/providers/services_provider.dart';
import 'package:utesaapp/src/utils/utils.dart';
import 'package:utesaapp/src/widget/logout_widget.dart';
import 'package:utesaapp/src/widget/menu_widget.dart';

class RatingsPage extends StatelessWidget {

  final serviceProvider = ServicesProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calificaciones"),
        backgroundColor: HexColor("327D57"),
      ),
      drawer: MenuWidget(),
      body: _createRatingList(),
    );
  }

  Widget _createRatingList() {
    return FutureBuilder(
        future: serviceProvider.getRatings(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if( snapshot.hasData ){

            final ratings = snapshot.data;
            if( !ratings["ok"] ){
              return LogoutWidget();
            }
            final ratinglist = ratings["data"];

            return ListView.builder(
              itemCount: ratinglist.length,
              itemBuilder: (BuildContext context, int i) => _createRatingItem(ratinglist[i]),
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

  Widget _createRatingItem(ratings){
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.assignment_rounded),
            title: Text(ratings["nombre"], style: TextStyle(fontSize: 20.0),),
            subtitle: Text(ratings["codigo"]),
            trailing:  Text(ratings["nota"],style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            height: 2.0,
            color: HexColor("E7E7E7"),
          ),
      ],
    );
  }
}