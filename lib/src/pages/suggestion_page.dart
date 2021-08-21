import 'package:flutter/material.dart';
import 'package:utesaapp/src/providers/services_provider.dart';
import 'package:utesaapp/src/utils/utils.dart';
import 'package:utesaapp/src/widget/menu_widget.dart';

class SuggestionPage extends StatefulWidget {

  @override
  _SuggestionPageState createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {

  final serviceProvider = ServicesProvider();
  final formKey  = GlobalKey<FormState>();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  String? _suggestion = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
        title: Text("Sugerencias"),
        backgroundColor: HexColor("327D57"),
      ),
      drawer: MenuWidget(),
      body: Container(
        padding: EdgeInsets.only(top: 65.0),
        child: Column(
          children: [
            Center(
              child: Text('Tu opinion nos importa', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
            ),
            SizedBox(height: 45.0,),
            Form(
              key: formKey,
              child: Column(
                children: [
                  _createInput(),
                  SizedBox(height: 45.0,),
                  _createButtton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        decoration: InputDecoration(
          icon: Icon(Icons.support, color: HexColor("327D57"),),
          labelText: 'Escribe tu sugerencia',
        ),
        onSaved: (value) => _suggestion = value,
        validator: (value) {
          if( value == "") return "Porfavor registre su sugerencia";
        },
      ),
    );
  }

  Widget _createButtton() {
   return RaisedButton(
     child: Container(
       padding: EdgeInsets.symmetric(horizontal: 80.0,vertical: 15.0),
       child: Text('Enviar'),
     ),
     shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(5.0),
     ),
     elevation: 0.0,
     color: HexColor("327D57"),
     textColor: Colors.white,
     onPressed: () => _onSubmit(),
   );
 }

  void _onSubmit() async {

      if( !formKey.currentState!.validate() ) return;

      formKey.currentState!.save();

      loading(context);

      final resp = await serviceProvider.addSuggestion( _suggestion  );

      if( !resp["ok"] ) {
        alertLogout(context);
      }
      Navigator.pop(context);
      mostrarSnackbar(resp["data"]);
  }

  void mostrarSnackbar(String mensaje) {

    final snackbar =SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 2500),
    );
    scaffoldkey.currentState!.showSnackBar(snackbar);
  }

}