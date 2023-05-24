import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
// import 'package:tutor_app/FirstScreen/teacher_search.dart';
// import 'package:tutor_app/providers/googlemapPage.dart';

import '../Apis/fetchClassSubject.dart';
import '../location/teachermap_page.dart';
import '../models/user_models/searchmodel.dart';
// import '../providers/googlemapPage.dart';

class MyClassSubjectPage extends StatefulWidget {
  @override
  _MyClassSubjectPageState createState() => _MyClassSubjectPageState();
}

class _MyClassSubjectPageState extends State<MyClassSubjectPage> {
  List<ClassSubject> _classSubjects = [];
  ClassSubject? _selectedClassSubject;
  List<String> _selectedSubjects = [];

  @override
  void initState() {
    super.initState();
    fetchClassSubjects().then((classSubjects) {
      setState(() {
        _classSubjects = classSubjects;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
      // final provider = Provider.of<TeacherMapState>(context,listen: false);
            // final provider = Provider.of<TeacherMapPage>(context,listen: false);


    return Container(
      
      child: Column(
        children: [
          DropdownButton<ClassSubject>(
            value: _selectedClassSubject,
            hint: Text('Select a class'),
            onChanged: (ClassSubject? newValue) {
              setState(() {
                _selectedClassSubject = newValue;
                _selectedSubjects.clear();
              });
            },
            items: _classSubjects.map<DropdownMenuItem<ClassSubject>>((ClassSubject classSubject) {
              return DropdownMenuItem<ClassSubject>(
                value: classSubject,
                child: Text(classSubject.className),
              );
            }).toList(),
          ),
          SizedBox(height: 16),
          if (_selectedClassSubject != null)
            Column(
              children: _selectedClassSubject!.subjects.map<Widget>((subject) {
                return ListTile(
                  title: Text(subject),
                  leading: Checkbox(
                    value: _selectedSubjects.contains(subject),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          _selectedSubjects.add(subject);
                        } else {
                          _selectedSubjects.remove(subject);
                        }
                      });
                    },
                  ),
                );
              }).toList(),
            ),
        SizedBox(height: 30,),
        //  ElevatedButton(
        //     onPressed:(){
        //       provider.getCurrentLocationAndFindTeachers(context,_selectedClassSubject,_selectedSubjects);
        //                           print(_selectedClassSubject?.className);
        //                           print(_selectedSubjects);

        //     },
        //               child: Text('Find Nearby Teachers'),
        //             ),

         ElevatedButton(
            onPressed:(){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>TeacherMapPage(className: _selectedClassSubject?.className ?? '',subjects: _selectedSubjects ,),
          //    settings: RouteSettings(
          //     arguments: {
          //   'selectedClassSubject': _selectedClassSubject?.className,
          //   'selectedSubjects': _selectedSubjects,
        //   },
        // ),               
         ),
              );

            },
                      child: Text('Find Nearby Teachers'),
                    ),



            //          ElevatedButton(
            // onPressed:(){
            //                       print(_selectedClassSubject);
            //                       print(_selectedSubjects);

            // },
            //           child: Text('Testing'),
            //         ),


        ],
      ),
    );
  }
}
