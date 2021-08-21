import 'package:flutter/material.dart';
import 'package:utesaapp/src/utils/utils.dart';
import 'package:utesaapp/src/widget/menu_widget.dart';

class SuggestionPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sugerencias"),
        backgroundColor: HexColor("327D57"),
      ),
      drawer: MenuWidget(),
      body: Text('ds'),
    );
  }
}