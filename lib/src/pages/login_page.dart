import 'package:flutter/material.dart';
import 'package:utesaapp/src/providers/user_provider.dart';
import 'package:utesaapp/src/shared_prefs/shared_preferences.dart';

import 'package:utesaapp/src/utils/utils.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>  {

  final formKey  = GlobalKey<FormState>();

  final _prefs = new UserPrefereces();
  final userProvider = new UserProvider();
  String? _user = '';
  String? _password = '';
  String recinto = 'Selecciona tu Recinto';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _createBackground(context),
          _loginForm(context)
        ],
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0,5.0),
                  spreadRadius: 3.0,
                ),
              ],
            ),
            child: Form(
              key: formKey,
              child: Column(
              children: [
                Text('Ingreso', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 60),
                _createDropdwn(),
                SizedBox(height: 30.0,),
                _createUser(),
                SizedBox(height: 30.0,),
                _createPassword(),
                SizedBox(height: 30.0,),
                _createButtton(),
              ],
            ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createDropdwn() {
    return FutureBuilder(
      future: userProvider.getRecinto(),
      initialData: [{"cod": "Selecciona tu Recinto", "txt": "Selecciona tu Recinto"}],
      builder: (BuildContext context, AsyncSnapshot snapshot) {

        final recintosData = snapshot.data;

        List<DropdownMenuItem<String>> list = [];
        
        recintosData.forEach((recinto) {
          list.add(
            DropdownMenuItem(
              child: Text(recinto["txt"]),
              value: recinto["cod"],
            ),
          );
        });

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: DropdownButtonFormField(
            items: list,
            decoration: InputDecoration(
              icon: Icon(Icons.home, color: HexColor("327D57"),),
              labelText: 'Recinto',
            ),
            validator: (value) {
              if( value == null ) return "Seleccione su recinto";
            },
            onChanged: (dynamic value){
              setState(() {
                recinto = value;
              });
            },
          ),
        );
      },
    );
  }

  Widget _createUser() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        decoration: InputDecoration(
          icon: Icon(Icons.person, color: HexColor("327D57"),),
          labelText: 'Usuario',
        ),
        onSaved: (value) => _user = value,
        validator: (value) {
          if( value == "") return "El usuario es requerido";
        },
      ),
    );
  }

  Widget _createPassword() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock_outline, color: HexColor("327D57"),),
          labelText: 'Contraseña',
        ),
        onSaved: (value) => _password = value,
        validator: (value) {
          if( value == "") return "La contraseña es requerida";
        },
      ),
    );
  }

 Widget _createButtton() {
   return RaisedButton(
     child: Container(
       padding: EdgeInsets.symmetric(horizontal: 80.0,vertical: 15.0),
       child: Text('Ingresar'),
     ),
     shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(5.0),
     ),
     elevation: 0.0,
     color: HexColor("327D57"),
     textColor: Colors.white,
     onPressed: _onSubmit,
   );
 }

  void _onSubmit() async {

    if( !formKey.currentState!.validate() ) return;

    formKey.currentState!.save();
    loading(context);
    Map status = await userProvider.login(recinto, _user, _password);
    
    if( status["ok"] ) {
      Navigator.of(context).pop();
      
      _prefs.nombre = status["data"]["nombre"] + " " + status["data"]["apellido"];
      _prefs.carrera = status["data"]["carrera"];
      _prefs.correo = status["data"]["correo"];

      Navigator.pushReplacementNamed(context, 'home');
    }else {
      Navigator.of(context).pop();
      showAlert(context, status["message"]);
    }

  }


  Widget _createBackground(BuildContext context) {

    final size = MediaQuery.of(context).size;

    final background = Container(
      height: size.height * 0.40,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color.fromRGBO(50, 125, 87, 1.0),
            Color.fromRGBO(55, 136, 95, 1.0)
          ]
        ),
      ),
    );

    final circle = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.05),
      ),
    );

    return Stack(
      children: [
        background,
        Positioned(top: 90.0, left: 30.0, child: circle),
        Positioned(top: -40.0,right:-30.0,child: circle),
        Positioned(bottom: -50.0, right: -10.0, child: circle),
        Positioned(bottom: 120.0, right: 20.0, child: circle),
        Positioned(bottom: -50.0, left: -20.0, child: circle),

        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: [
              Image(
                image: AssetImage('assets/logo-bg.png'),
                fit: BoxFit.cover,
              ),
              // Icon(Icons.person_pin_circle, color: Colors.white, size: 100.0,),
              SizedBox(height: 10.0, width: double.infinity,),
              Text('UTESA', style: TextStyle(color: Colors.white, fontSize: 25.0),),
            ],
          ),
        ),
      ],
    );

  }
}