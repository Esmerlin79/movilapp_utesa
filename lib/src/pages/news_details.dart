import 'package:flutter/material.dart';
import 'package:utesaapp/src/utils/utils.dart';

class NewsDetails extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final routeArgs =
      ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text(routeArgs["titulo"]),
        backgroundColor: HexColor("327D57"),
      ),
      body: _createView(routeArgs),
    );
  }

  Widget _createView(news) {
    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInImage(
              image: NetworkImage(news["imagen"]),
              placeholder: AssetImage('assets/jar-loading.gif'),
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20.0,),
            
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(news["contenido"],style: TextStyle(fontSize: 17.0), textAlign: TextAlign.center),
            ),
          ],
        ),
      );
  }
}