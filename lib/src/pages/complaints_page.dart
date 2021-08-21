import 'package:flutter/material.dart';
import 'package:utesaapp/src/bloc/complaints_bloc.dart';
import 'package:utesaapp/src/bloc/provider.dart';
import 'package:utesaapp/src/models/complaints_model.dart';
import 'package:utesaapp/src/utils/utils.dart';
import 'package:utesaapp/src/widget/logout_widget.dart';
import 'package:utesaapp/src/widget/menu_widget.dart';

class ComplaintsPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
  
    final complaintsBloc = Provider.of(context);
    complaintsBloc.loadingComplaints();

    return Scaffold(
      appBar: AppBar(
        title: Text("Mis Quejas"),
        backgroundColor: HexColor("327D57"),
      ),
      drawer: MenuWidget(),
      body: _createList( complaintsBloc ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: HexColor("327D57"),
        onPressed: () => Navigator.pushNamed(context, 'addcomplaint'),
      ),
    );
  }

  Widget _createList(ComplaintsBloc complaintsBloc) {

    return StreamBuilder(
      stream: complaintsBloc.complaintsStream,
      builder: (BuildContext context, AsyncSnapshot<List<ComplaintsModel>> snapshot) {
         if( snapshot.hasData ){

            final complaints = snapshot.data;
            if( !complaints![0].success ){
              return LogoutWidget();
            }
            return ListView.builder(
              itemCount: complaints.length,
              itemBuilder: (BuildContext context, int i) => _createItem(complaints[i]),
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

  _createItem(ComplaintsModel complaint) {
    return Column(
      children: [
        ListTile(
          title: Text(complaint.queja ?? ''),
          subtitle: Text(complaint.fecha ?? ''),
          trailing: Text(complaint.estado ?? '', style: (complaint.estado == 'pendiente') ? TextStyle(color: Colors.red) :TextStyle(color: Colors.green),),
        ),
        Divider(),
      ],
    );
  }
}