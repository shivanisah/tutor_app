import 'package:flutter/material.dart';



class SelectedTimeSlot{
  TimeOfDay startTime;
  TimeOfDay endTime;
  bool isSelected;

  SelectedTimeSlot({required this.startTime,required this.endTime, this.isSelected = false});
}
class TeachingTime extends StatefulWidget{

  @override
   State<TeachingTime> createState()=> _TeachingTimeState();


}


class _TeachingTimeState extends State<TeachingTime>{
  List<SelectedTimeSlot> _timeSlots = [];

  void _addNewTimeSlot(){
    final startTime = TimeOfDay(hour:0,minute:0);
    final endTime = TimeOfDay(hour:0,minute:0);
    _timeSlots.add(SelectedTimeSlot(startTime: startTime, endTime: endTime));
  }

  String _formatTimeOfDay(TimeOfDay time){


      var hour = time.hourOfPeriod.toString().padLeft(2,'0');
      final minute = time.minute.toString().padLeft(2,'0');
      final period = time.period == DayPeriod.am?'AM':'PM';

      return '$hour:$minute $period';
    }


    Future<void> _showStartTimePickerDialog(int index) async{

    final TimeOfDay? selectedTime = await showTimePicker(
          context:context,
          initialTime:_timeSlots[index].startTime,
        );

        if(selectedTime!=null){
          setState((){
          _timeSlots[index].startTime = selectedTime;
          _timeSlots[index].endTime = selectedTime.replacing(hour:selectedTime.hour+1);

          });
        }
    } 

    Future<void> _showEndTimePickerDialog(int index) async{
       final TimeOfDay? selectedTime = await showTimePicker(
        context:context,
        initialTime: _timeSlots[index].endTime,
      );
      if(selectedTime!=null){
        _timeSlots[index].endTime = selectedTime;
      }
    }

  @override
  void initState(){
    super.initState();
    _addNewTimeSlot();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),
      body:Column(children: [
        Text('Your Teaching Time Slots'),
        
        Container(
          child:ListView.builder(
            shrinkWrap: true,
            itemCount:_timeSlots.length,
            itemBuilder:(context,index){

              final SelectedTimeSlot timeSlots = _timeSlots[index];

              return ListTile(
                leading: Row(
                  children: [
                    ElevatedButton(child: Text(_formatTimeOfDay(timeSlots.startTime)),
                    onPressed: () => _showStartTimePickerDialog(index),
                    ),
                    Icon(Icons.arrow_forward),
                    ElevatedButton(onPressed:() =>_showEndTimePickerDialog(index), child: Text(_formatTimeOfDay(timeSlots.endTime)))
                  ],
                ),
                
              );

            }
          )
        )
      ],)
    );
  }

}

