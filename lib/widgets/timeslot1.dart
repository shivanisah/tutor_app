import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tutor_app/utils/colors.dart';
import 'package:tutor_app/models/user_models/timeSlotmodel.dart';

import '../providers/timeSlot_provider.dart';
import '../shared_preferences.dart/user_preferences.dart';

class TimeSlot {
  TimeOfDay startTime;
  TimeOfDay endTime;
  bool isSelected;

  TimeSlot({required this.startTime, required this.endTime, this.isSelected = false});
}

class MultipleTime extends StatefulWidget {
  @override
  _MultipleTimeState createState() => _MultipleTimeState();
}

class _MultipleTimeState extends State<MultipleTime> {
  List<TimeSlot> _timeSlots = [];
  final userPreferences = UserPreferences();
  int? teacherId;

  @override
  void initState() {
    super.initState();
    _addNewTimeSlot();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final timeSlotProvider = Provider.of<TimeSlotProvider>(context, listen: false);
  }

void _addNewTimeSlot() {
  final startTime = TimeOfDay(hour: 0, minute: 0); 
  final endTime = TimeOfDay(hour: 0, minute: 0); 

  setState(() {
    _timeSlots.add(TimeSlot(
      startTime: startTime,
      endTime: endTime,
    ));
  });
}
String _formatTimeOfDay(TimeOfDay time) {
  if (time == null) {
    return '00:00';
  } else {
    var hour = time.hourOfPeriod.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    
    if (hour == '12') {
      // Convert 12-hour format to 24-hour format for 12 AM
      if (period == 'AM') {
        hour = '00';
      }
    }
    
    return '$hour:$minute $period';
  }
}


  // void _addNewTimeSlot() {
  //   setState(() {
  //     _timeSlots.add(TimeSlot(
  //       startTime: TimeOfDay.now(),
  //       endTime: TimeOfDay.now().replacing(hour: TimeOfDay.now().hour + 1),
  //     ));
  //   });
  // }

  // String _formatTimeOfDay(TimeOfDay time) {
  //   if (time == null) {
  //   return '00:00';
  // }else{
  //   final hour = time.hourOfPeriod;
  //   final minute = time.minute.toString().padLeft(2, '0');
  //   final period = time.period == DayPeriod.am ? 'AM' : 'PM';
  //   return '$hour:$minute $period';
  // }
  // }

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
        _timeSlots[index].endTime = selectedTime.replacing(hour:selectedTime.hour+1);
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

//....................
void _saveTimeSlots() async{
  final selectedTimeSlots = _timeSlots.where((timeSlot) => timeSlot.isSelected).toList();

  // Check for conflicting time slots
  final conflictingSlots = _checkConflictingTimeSlots(selectedTimeSlots);

  if (conflictingSlots.isEmpty) {
    final timeSlotsData = selectedTimeSlots.map((timeSlot) {
      return {
        'teacherId': teacherId.toString(),
        'startTime': _formatTime(timeSlot.startTime),
        'endTime': _formatTime(timeSlot.endTime),
      };
    }).toList();

    // Check if any of the selected time slots match the fetched time slots
final timeSlotProvider = Provider.of<TimeSlotProvider>(context, listen: false);
final fetchedData = await timeSlotProvider.fetchTimeSlots(teacherId!);
print("time................................");
print(fetchedData);   

// final List<TimeSlot> fetchedTimeSlots = [];

// Check if fetchedData is a List<TimeSlot> or a single TimeSlot
// if (fetchedData is List<TimeSlot>) {
//   fetchedTimeSlots.addAll(fetchedData);
// } else if (fetchedData is TimeSlot) {
//   fetchedTimeSlots.add(fetchedData );
// }
final List<TimeSlot> fetchedTimeSlots = fetchedData.cast<TimeSlot>();
print(fetchedTimeSlots);

 final List<TimeSlot> matchingSlots = _getMatchingTimeSlots(selectedTimeSlots, fetchedTimeSlots );

    if (matchingSlots.isEmpty) {
      final timeSlotProvider = Provider.of<TimeSlotProvider>(context, listen: false);
      timeSlotProvider.saveTimeSlots(context, timeSlotsData);
    } else {
      _showMatchingSlotsDialog(matchingSlots);
    }
  } else {
    _showConflictingSlotsDialog(conflictingSlots);
  }
}

List<TimeSlot> _getMatchingTimeSlots(List<TimeSlot> selectedSlots, List<TimeSlot> fetchedSlots) {
  final List<TimeSlot> matchingSlots = [];

  for (final selectedSlot in selectedSlots) {
    for (final fetchedSlot in fetchedSlots) {
      if (_isTimeSlotMatch(selectedSlot, fetchedSlot)) {
        matchingSlots.add(selectedSlot);
        break;
      }
    }
  }

  return matchingSlots;
}

bool _isTimeSlotMatch(TimeSlot selectedSlot, TimeSlot fetchedSlot) {
  return selectedSlot.startTime == fetchedSlot.startTime && selectedSlot.endTime == fetchedSlot.endTime;
}

void _showMatchingSlotsDialog(List<TimeSlot> matchingSlots) {
  String message = 'The following time slots already exist:\n\n';

  for (final slot in matchingSlots) {
    message += 'Time Slot: ${_formatTimeOfDay(slot.startTime)} - ${_formatTimeOfDay(slot.endTime)}\n\n';
  }

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Matching Time Slots'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

  // void _saveTimeSlots() {
  //   final selectedTimeSlots = _timeSlots.where((timeSlot) => timeSlot.isSelected).toList();

  //   // Check for conflicting time slots
  //   final conflictingSlots = _checkConflictingTimeSlots(selectedTimeSlots);

  //   if (conflictingSlots.isEmpty) {
  //     final timeSlotsData = selectedTimeSlots.map((timeSlot) {
  //       return {
  //         'teacherId': teacherId.toString(),
  //         'startTime': _formatTime(timeSlot.startTime),
  //         'endTime': _formatTime(timeSlot.endTime),
  //       };
  //     }).toList();

  //     //...........
      
      
  //   final timeSlotProvider = Provider.of<TimeSlotProvider>(context, listen: false);
  //     timeSlotProvider.saveTimeSlots(context, timeSlotsData);
  //   } else {
  //     _showConflictingSlotsDialog(conflictingSlots);
  //   }
  // }

  List<int> _checkConflictingTimeSlots(List<TimeSlot> timeSlots) {
    final conflictingSlots = <int>[];

    for (int i = 0; i < timeSlots.length - 1; i++) {
      final TimeSlot currentSlot = timeSlots[i];

      for (int j = i + 1; j < timeSlots.length; j++) {
        final TimeSlot comparedSlot = timeSlots[j];

        if (_isTimeSlotConflict(currentSlot, comparedSlot)) {
          conflictingSlots.add(i);
          conflictingSlots.add(j);
        }
      }
    }

    return conflictingSlots;
  }

  bool _isTimeSlotConflict(TimeSlot slot1, TimeSlot slot2) {
  final start1 = slot1.startTime.hour * 60 + slot1.startTime.minute;
  final end1 = slot1.endTime.hour * 60 + slot1.endTime.minute;
  final start2 = slot2.startTime.hour * 60 + slot2.startTime.minute;
  final end2 = slot2.endTime.hour * 60 + slot2.endTime.minute;

// if((end2<start1 && end2>start2 )||(start2>end1 && end2>start2)){
//   return false;
// }

if((end2<start1 && start2<start1)||(start2>end1 && end2>end1)){
  return false;
}

  // if ((start1 >= start2 && start1 < end2) || (end1 > start2 && end1 <= end2)) {
  //   return true; // Overlapping or conflicting time slots
  // }

  return true; // No conflict
}


  // bool _isTimeSlotConflict(TimeSlot slot1, TimeSlot slot2) {
  //   if (slot1.startTime.isBefore(slot2.endTime) && slot1.endTime.isAfter(slot2.startTime)) {
  //     return true;
  //   }

  //   return false;
  // }

  void _showConflictingSlotsDialog(List<int> conflictingSlots) {
    String message = 'Conflicting time slots found:\n\n';

    for (int i = 0; i < conflictingSlots.length; i += 2) {
      final int index1 = conflictingSlots[i];
      final int index2 = conflictingSlots[i + 1];

      final TimeSlot slot1 = _timeSlots[index1];
      final TimeSlot slot2 = _timeSlots[index2];

      message += 'Slot ${index1 + 1}: ${_formatTimeOfDay(slot1.startTime)} - ${_formatTimeOfDay(slot1.endTime)}\n';
      message += 'Slot ${index2 + 1}: ${_formatTimeOfDay(slot2.startTime)} - ${_formatTimeOfDay(slot2.endTime)}\n';
      message +='\n\n';
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Conflict Detected'),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final timeSlotProvider = Provider.of<TimeSlotProvider>(context, listen: false);

    userPreferences.getUser().then((teacher) {
      if (teacher != null) {
        setState(() {
          teacherId = teacher.id;
        });
      }
    });

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, bottom: 9),
              child: Text(
                'Pick Your Teaching Time Slots',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  height: 1.0,
                  color: Color(0xff000000),
                ),
              ),
            ),
            SizedBox(height: 22),
            Container(
              height: 440,
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _timeSlots.length,
                itemBuilder: (BuildContext context, int index) {
                  final TimeSlot timeSlot = _timeSlots[index];

                  return ListTile(
                    title: Text(
                      'Slot ${index + 1}',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        height: 1.0,
                        color: Color(0xff000000),
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          child: Text(
                            timeSlot.startTime != null ? _formatTimeOfDay(timeSlot.startTime) : 'Select Start',
                          ),
                          onPressed: () => _showStartTimePickerDialog(index),
                        ),
                        Icon(Icons.arrow_forward),
                        ElevatedButton(
                          child: Text(
                            timeSlot.endTime != null ? _formatTimeOfDay(timeSlot.endTime) : 'Select End',
                          ),
                          onPressed: () => _showEndTimePickerDialog(index),
                        ),
                        IconButton(
                          icon: Icon(
                            timeSlot.isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                            color: Palette.theme1,
                          ),
                          onPressed: () => _toggleTimeSlotSelection(index),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Column(
              children: _timeSlots
                  .asMap()
                  .entries
                  .where((entry) => entry.value.isSelected)
                  .map((entry) => Container(
                        margin: EdgeInsets.only(left: 45),
                        child: Text(
                          'Selected Time Slot ${entry.key + 1}:  ${_formatTimeOfDay(entry.value.startTime)} - ${_formatTimeOfDay(entry.value.endTime)}',
                        ),
                      ))
                  .toList(),
            ),
            SizedBox(height: 20),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: Consumer<TimeSlotProvider>(
                    builder: (context, provider, child) {
                      if (timeSlotProvider.loading) {
                        return Center(child: CircularProgressIndicator(color: Colors.white));
                      } else {
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
