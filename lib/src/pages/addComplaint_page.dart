import 'package:flutter/material.dart';
import 'package:utesaapp/src/bloc/complaints_bloc.dart';
import 'package:utesaapp/src/bloc/provider.dart';
import 'package:utesaapp/src/models/complaints_model.dart';
import 'package:utesaapp/src/utils/utils.dart';

class AddComplaintPage extends StatefulWidget {

  @override
  _AddComplaintPageState createState() => _AddComplaintPageState();
}

class _AddComplaintPageState extends State<AddComplaintPage> {

  final formKey  = GlobalKey<FormState>();
  final scaffoldkey = GlobalKey<ScaffoldState>();

  String? _complaints = '';

  @override
  Widget build(BuildContext context) {

    final complaintsBloc = Provider.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Registra tu Queja"),
        backgroundColor: HexColor("327D57"),
      ),
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
                  _createButtton( complaintsBloc ),
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
          icon: Icon(Icons.contact_support_outlined, color: HexColor("327D57"),),
          labelText: 'Escribe tu queja',
        ),
        onSaved: (value) => _complaints = value,
        validator: (value) {
          if( value == "") return "Porfavor registre su queja";
        },
      ),
    );
  }

  Widget _createButtton( ComplaintsBloc bloc ) {
   // ignore: deprecated_member_use
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
     onPressed: () => _onSubmit(bloc),
   );
 }

 void _onSubmit( ComplaintsBloc bloc ) async {

    if( !formKey.currentState!.validate() ) return;

    formKey.currentState!.save();

    loading(context);

    final complaint = new ComplaintsModel(
      queja: _complaints,
      fecha: '',
      estado: ''
    );

    final resp = await bloc.addComplaints( complaint  );

    if( resp == "false" ) {
      alertLogout(context);
    }
    Navigator.pop(context);
    Navigator.pop(context);
}



}