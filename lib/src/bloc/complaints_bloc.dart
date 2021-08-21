

import 'dart:async';

import 'package:utesaapp/src/models/complaints_model.dart';
import 'package:utesaapp/src/providers/services_provider.dart';

class ComplaintsBloc {

  final _complaintsController = new StreamController<List<ComplaintsModel>>.broadcast();

  final _servicesProvider = new ServicesProvider();
  
  Stream<List<ComplaintsModel>> get complaintsStream => _complaintsController.stream;

   loadingComplaints() async {

    final complaints = await _servicesProvider.getComplaints();
    
    final statusCode = complaints["ok"];
    List<ComplaintsModel> complaintsModels = [];
    if( !statusCode ){

      complaintsModels.add(
        ComplaintsModel(
          queja: '',
          estado: '',
          fecha: '',
          success: statusCode,
        )
      );

    _complaintsController.sink.add( complaintsModels );
      return;
    }

    final complaintsList = complaints["data"];

    complaintsList.map((complaint) => {
      complaintsModels.add(
        ComplaintsModel(
          queja: complaint["queja"],
          estado: complaint["estado"],
          fecha: complaint["fecha"],
          success: statusCode,
        )
      )
    }).toList();

    _complaintsController.sink.add( complaintsModels );
  }

  dynamic addComplaints( ComplaintsModel complaint ) async {

    final complaints = await _servicesProvider.addComplaints( complaint.queja );
    final resp = ( !complaints["ok"] ) ? 'false' : complaints["data"];

    loadingComplaints();
    
    return resp;
  }



  void disposeStream() {
    _complaintsController.close();
  }
}