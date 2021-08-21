import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:utesaapp/src/providers/services_provider.dart';
import 'package:utesaapp/src/utils/utils.dart';
import 'package:utesaapp/src/widget/logout_widget.dart';
import 'package:utesaapp/src/widget/menu_widget.dart';

class VirtualClassPage extends StatelessWidget {

  final serviceProvider = ServicesProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clases Virtuales"),
        backgroundColor: HexColor("327D57"),
      ),
      drawer: MenuWidget(),
      body: ListView(
        children: [
         FutureBuilder(
           future: serviceProvider.getVirtualClass(),
           builder: (BuildContext context, AsyncSnapshot snapshot) {
             
             if( snapshot.hasData ) {

               final classData = snapshot.data;

                if( !classData["ok"] ){
                  return LogoutWidget();
                }

                final classList = classData["data"];
                final List<Widget> classListWidget = [];
          
                classList.forEach((virtualClass) {
                    classListWidget.add(
                         Container(
                          child: Row(
                            children: [
                              FadeInImage(
                                image: NetworkImage(virtualClass["foto"]),
                                placeholder: AssetImage('assets/jar-loading.gif'),
                                height: double.infinity,
                                width: 210.0,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: 12.0,),
                              Column(
                                children: [
                                  SizedBox(height: 20.0,),
                                  Text(virtualClass["nombre"], overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
                                  Text(virtualClass["codigo"], style: Theme.of(context).textTheme.subtitle1,),
                                  SizedBox(height: 10.0,),
                                  RaisedButton(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 50.0,vertical: 10.0),
                                      child: Text('Ir'),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    elevation: 0.0,
                                    color: HexColor("327D57"),
                                    textColor: Colors.white,
                                    onPressed: () => _openUrlClass(context, virtualClass["link"]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          height: 150.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 3.0,
                                offset: Offset(0.0,1.0),
                                spreadRadius: 1.0,
                              ),
                            ],
                          ),
                        ),

                    );
                  classListWidget.add( SizedBox(height: 30.0,),);            
                });         
              return Container(
                  padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 10.0),
                  child: Column(
                    children: classListWidget,
                ),
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
  _openUrlClass(context,dynamic url) async {
    if( await canLaunch(url) ) {
      await launch(url);
    }else {
      showAlert(context, 'El link no se pudo abrir');
    }
  }
}