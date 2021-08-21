import 'package:flutter/material.dart';
import 'package:utesaapp/src/providers/services_provider.dart';
import 'package:utesaapp/src/utils/utils.dart';
import 'package:utesaapp/src/widget/menu_widget.dart';

class NewsPage extends StatelessWidget {

  final serviceProvider = ServicesProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Noticias"),
        backgroundColor: HexColor("327D57"),
      ),
      drawer: MenuWidget(),
      body: _createList(context),
    );
  }

  Widget _createList(BuildContext context) {
    return FutureBuilder(
        future: serviceProvider.getNews(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if( snapshot.hasData ){

            final news = snapshot.data;         

            return ListView.builder(
              itemCount: news.length,
              itemBuilder: (BuildContext context, int i) => _createNews(context, news[i]),
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

  Widget _createNews(context, news) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'newsdetails', arguments: news),
      child: Card(
        borderOnForeground: true,
          child: Column(
            children: [
              FadeInImage(
                image: NetworkImage(news["imagen"]),
                placeholder: AssetImage('assets/jar-loading.gif'),
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              ListTile(
                title: Text(news["titulo"], style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                subtitle: Text(news["resumen"],textAlign: TextAlign.justify),
                trailing: Text(news["fecha"], style: Theme.of(context).textTheme.subtitle2,),
              ),
            ],
          ),
        ),
    );
  }
}