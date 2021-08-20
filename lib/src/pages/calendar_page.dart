
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:utesaapp/src/providers/services_provider.dart';
import 'package:utesaapp/src/utils/utils.dart';
import 'package:utesaapp/src/widget/logout_widget.dart';
import 'package:utesaapp/src/widget/menu_widget.dart';



class CalendarPage extends StatefulWidget {
  @override
  CalendarAppointment createState() => CalendarAppointment();
}

class CalendarAppointment extends State<CalendarPage> {

  final serviceProvider = ServicesProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendario de Eventos"),
        backgroundColor: HexColor("327D57"),
      ),
      drawer: MenuWidget(),
      body: FutureBuilder(
        future: serviceProvider.getCalendar(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if( snapshot.hasData ) {

            final calendar = snapshot.data;
            if( !calendar["ok"] ){
              return LogoutWidget();
            }
            final eventList = calendar["data"];

            late CalendarDataSource _dataSource = _getDataSource(eventList);

            return SfCalendar(
              dataSource: _dataSource,
              view: CalendarView.month,
              allowedViews: [
                CalendarView.month,
                CalendarView.day,
                CalendarView.week,
                CalendarView.workWeek,
                CalendarView.timelineDay,
                CalendarView.timelineWeek,
                CalendarView.timelineWorkWeek,
                CalendarView.timelineMonth,
                CalendarView.schedule
              ],
              monthViewSettings: MonthViewSettings(showAgenda: true),
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
    );
  }

  _DataSource _getDataSource(eventList)  {

    List<Appointment> appointments = <Appointment>[];

    eventList.forEach((event) {
      final year = event["fecha"].substring(0,4);
      final month = event["fecha"].substring(5,7);
      final day = event["fecha"].substring(8,10);

      final DateTime startTime = DateTime(int.parse(year), int.parse(month), int.parse(day), 9, 0, 0);
      final DateTime endTime = startTime.add(const Duration(hours: 2));

      appointments.add(Appointment(
        startTime: startTime,
        endTime: endTime,
        subject: event["nombre"],
        color: Colors.teal,
      ));
    });  
    
    return _DataSource(appointments);
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}