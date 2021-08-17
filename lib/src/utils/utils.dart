import 'package:flutter/material.dart';

class HexColor extends Color {

  static int _getColorFromHex(String hexColor) {
    
    hexColor = hexColor.toUpperCase().replaceAll('#', "");

    if( hexColor.length == 6 ){
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

void showAlert( BuildContext context, String message ) {
  showDialog(
    context: context,
    builder: ( context ) {
      return AlertDialog(
        title: Center(child: Text("UTESA", style: TextStyle(fontWeight: FontWeight.bold),)),
        content: Text(message),
        actions: [
          FlatButton(
            child: Center(child: Text('OK')),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );
    }
  );
}
void alertLogout( BuildContext context) {
  showDialog(
    context: context,
    builder: ( context ) {
      return AlertDialog(
        title: Center(child: Text("UTESA", style: TextStyle(fontWeight: FontWeight.bold),)),
        content: Text("Debe ingresar nuevamente"),
        actions: [
          FlatButton(
            child: Center(child: Text('OK')),
            onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
          ),
        ],
      );
    }
  );
}

void loading( BuildContext context ) {
  showDialog(
    context: context,
    builder: ( context ) {
      return AlertDialog(
        title: Center(child: Text('Cargando...')),
        content: Image(
          height: 100.0,
          width: 100.0,
          image: AssetImage('assets/loading.gif'),
          fit: BoxFit.cover,
        ),
      );
    }
  );
}