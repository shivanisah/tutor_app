import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tutor_app/utils/colors.dart';

import '../providers/timeSlot_provider.dart';
import '../shared_preferences.dart/user_preferences.dart';

class TimeSlot {
  TimeOfDay startTime;
  TimeOfDay endTime;
  bool isSelected;

  TimeSlot({required this.startTime, required this.endTime, this.isSelected = false});
}


class MultipleTimePickerPage extends StatefulWidget {
  @override
  _MultipleTimePickerPageState createState() => _MultipleTimePickerPageState();
}

class _MultipleTimePickerPageState extends State<MultipleTimePickerPage> {
  List<TimeSlot> _timeSlots = [];
    final userPreferences = UserPreferences();
    int? teacherId;




  @override
  void initState() {
    super.initState();
    _addNewTimeSlot();
  }

  void _addNewTimeSlot() {
    setState(() {
      _timeSlots.add(TimeSlot(
        startTime: TimeOfDay.now(),
        endTime: TimeOfDay.now().replacing(hour: TimeOfDay.now().hour + 1),
      ));
    });
  }

String _formatTimeOfDay(TimeOfDay time) {
  final hour = time.hourOfPeriod;
  final minute = time.minute.toString().padLeft(2, '0');
  final period = time.period == DayPeriod.am ? 'AM' : 'PM';
  return '$hour:$minute $period';
}
String _formatTime(TimeOfDay time) {
  final hour = time.hour.toString().padLeft(2, '0');
  final minute = time.minute.toString().padLeft(2, '0');
  return '$hour:$minute:00';
}

  Future<void> _showStartTimePickerDialog(int index) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: _timeSlots[index].startTime,
    );

    if (selectedTime != null) {
      setState(() {
        _timeSlots[index].startTime = selectedTime;
      });
    }
  }

  Future<void> _showEndTimePickerDialog(int index) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: _timeSlots[index].endTime,
    );

    if (selectedTime != null) {
      setState(() {
        _timeSlots[index].endTime = selectedTime;
      });
    }
  }

  void _toggleTimeSlotSelection(int index) {
    setState(() {
      _timeSlots[index].isSelected = !_timeSlots[index].isSelected;
    });
  }


  void _saveTimeSlots(){
    final selectedTimeSlots = _timeSlots.where((timeSlot)=>timeSlot.isSelected).toList();

    final timeSlotsData = selectedTimeSlots.map((timeSlot) {
        return {
          'teacherId':teacherId.toString(),
          'startTime':_formatTime(timeSlot.startTime),
          'endTime': _formatTime(timeSlot.endTime),
          // 'startTime':timeSlot.startTime,
          // 'endTime':timeSlot.endTime,

        
        };
      
    },).toList();

    final timeSlotProvider = Provider.of<TimeSlotProvider>(context,listen:false);
    timeSlotProvider.saveTimeSlots(context,timeSlotsData);

  }
  @override
  Widget build(BuildContext context) {
        final timeSlotProvider = Provider.of<TimeSlotProvider>(context,listen:false);

    userPreferences.getUser().then((teacher) {
      if (teacher != null) {
        setState(() {
          teacherId = teacher.id;
          // print(teacherId);
        });
      }
    });  

    return Scaffold(
      appBar: AppBar(
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
                      SizedBox(height:40),
              Padding(
                padding: const EdgeInsets.only(left:15.0,bottom:9),
                child: Text(
                   'Pick Your Teaching Time Slots',
                   style:  GoogleFonts.poppins(
                    
                  fontSize:  22,
                      fontWeight:  FontWeight.w500,
                      height:  1.0,
                    color:  Color(0xff000000),
                    
                    )
                ),
              ),
              SizedBox(height:22),
      
            Container(
              height:440,
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _timeSlots.length,
                itemBuilder: (BuildContext context, int index) {
                  final TimeSlot timeSlot = _timeSlots[index];
      
                  return ListTile(
                    title: Text('Slot ${index + 1}',
                  style:  GoogleFonts.poppins(
                    
                  fontSize:  18,
                      // fontWeight:  FontWeight.w500,
                      height:  1.0,
                    color:  Color(0xff000000),
                    
                    )
      
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          child: Text(
                            timeSlot.startTime != null
                                ? _formatTimeOfDay(timeSlot.startTime)
                                : 'Select Start',
                          ),
                          onPressed: () => _showStartTimePickerDialog(index),
                        ),
                        Icon(Icons.arrow_forward),
                        ElevatedButton(
                          child: Text(
                            timeSlot.endTime != null
                                ? _formatTimeOfDay(timeSlot.endTime)
                                : 'Select End',
                          ),
                          onPressed: () => _showEndTimePickerDialog(index),
                        ),
                        IconButton(
                          icon: Icon(
                            timeSlot.isSelected
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                                color:Palette.theme1
                          ),
                          onPressed: () => _toggleTimeSlotSelection(index),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
      
            // ElevatedButton(child: Text("Save"),
            // onPressed: _saveTimeSlots,),
            // SizedBox(height:20),
      // Column(
      //   children: _timeSlots
      //       .where((timeSlot) => timeSlot.isSelected)
      //       .map((selectedTimeSlot) => Text(
      //             'Selected Time Slot : ${_formatTimeOfDay(selectedTimeSlot.startTime)} - ${_formatTimeOfDay(selectedTimeSlot.endTime)}',
      //           ))
      //       .toList(),
      // ),
      
      Column(
        children: _timeSlots
        .asMap()
        .entries
        .where((entry) => entry.value.isSelected)
        .map((entry) => Container(
          margin:EdgeInsets.only(left:45),
          child: Text(
                'Selected Time Slot ${entry.key + 1}:  ${_formatTimeOfDay(entry.value.startTime)} - ${_formatTimeOfDay(entry.value.endTime)}',
              ),
        ))
        .toList(),
      ),
      
      SizedBox(height:20),
      Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              ElevatedButton(
                  // child: Text('Save Slots'),
                                            child:Consumer<TimeSlotProvider>(
              builder: (context, provider,child) {
                if (timeSlotProvider.loading) {
                  return Center(child: CircularProgressIndicator(color: Colors.white));
                }
                 else {
                  return Center(child: Text('Save Slots', style: TextStyle(color: Colors.white, fontSize: 16)));
                }
              },
            ),

                  onPressed: _saveTimeSlots,
                ),
      
                ElevatedButton(
                  child: Text('Add Time Slot'),
                  onPressed: _addNewTimeSlot,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

