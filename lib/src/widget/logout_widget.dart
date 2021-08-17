import 'package:flutter/material.dart';
import 'package:utesaapp/src/utils/utils.dart';

class LogoutWidget extends StatefulWidget {
  LogoutWidget({Key? key}) : super(key: key);

  @override
  _LogoutWidgetState createState() => _LogoutWidgetState();
}

class _LogoutWidgetState extends State<LogoutWidget> {

  @override
  void initState() {
    super.initState();
     WidgetsBinding.instance!.addPostFrameCallback((timeStamp) => alertLogout(context));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}