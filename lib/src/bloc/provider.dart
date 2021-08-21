

import 'package:flutter/material.dart';
import 'package:utesaapp/src/bloc/complaints_bloc.dart';

class Provider extends InheritedWidget {

  final _complaintsBloc = new ComplaintsBloc();

  static Provider? _instance;

  factory Provider({ Key? key, required Widget child }) => _instance ??= _instance = new Provider._internal(key: key, child: child);

  Provider._internal({ Key? key, required Widget child }) : super(key: key, child: child);

  @override 
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static ComplaintsBloc of ( BuildContext context ) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()!._complaintsBloc;
  }

}