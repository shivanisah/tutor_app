
import 'package:flutter/material.dart';
import 'package:tutor_app/FirstScreen/Home.dart';

import '../Apis/fetchClassSubject.dart';
import '../location/teachermap_page.dart';
import '../models/user_models/searchmodel.dart';
import '../shared_preferences.dart/user_preferences.dart';
import '../utils/colors.dart';

class MyClassSubjectPage extends StatefulWidget {
  @override
  _MyClassSubjectPageState createState() => _MyClassSubjectPageState();
}

class _MyClassSubjectPageState extends State<MyClassSubjectPage> {
  List<ClassSubject> _classSubjects = [];
  ClassSubject? _selectedClassSubject;
  List<String> _selectedSubjects = [];
  final userPreferences = UserPreferences();
  String user_type = '';

// @override
// void dispose(){
// _selectedClassSubject = null;
//   _selectedSubjects.clear();
//     super.dispose();
// }


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
      userPreferences.getUser().then((user) {
      setState(() {
          user_type = user.user_type?? '';
      });
    });  


    return Scaffold(
      appBar: AppBar(
        
          leading:IconButton(
            onPressed:(){
            Navigator.push(context,MaterialPageRoute(builder:((context) => Home()),
            settings: RouteSettings(arguments: user_type)
            ));

            },
            icon: Icon(Icons.arrow_back), 
          )
        
      ),
      body: Container(
        
        child: 
        Column(
          
                
          children: [
            Container(
              width:300,
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              // border: Border.all(color: Colors.grey),
                                          boxShadow:[
                                BoxShadow(
                                  color: Colors.grey,
    
                                  blurRadius:5,
                                  offset:Offset(0,0.5),
                                ),
                                BoxShadow(
                                  color:Colors.white,
                                  offset:Offset(-0.5,0),
                                ),
                              ]
    
               ),
              child: Align(
                alignment: AlignmentDirectional.center,
                child: DropdownButton<ClassSubject>(
                  value: _selectedClassSubject,
                  hint: Text('Select class'),
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
                  style: TextStyle(color: Colors.black, fontSize: 19),
                  icon: Icon(Icons.arrow_drop_down,size: 30,),
                  underline: SizedBox(),      
                ),
              ),
            ),
            SizedBox(height: 16),
            if (_selectedClassSubject != null)
              Column(
                children: _selectedClassSubject!.subjects.map<Widget>((subject) {
                  return ListTile(
                    title: Text(subject),
                    leading: Theme(
                      data: ThemeData(
                    // unselectedWidgetColor: Colors.grey, // Color when checkbox is not selected
                    checkboxTheme: CheckboxThemeData(
                      fillColor: MaterialStateProperty.all<Color>(Palette.theme1), // Color when checkbox is selected
                     ),
                        ),
                      child: Checkbox(
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
                    ),
                  );
                }).toList(),
              ),
          SizedBox(height: 30,),
    
          //  ElevatedButton(
          //     onPressed:(){
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) =>TeacherMapPage(className: _selectedClassSubject?.className ?? '',subjects: _selectedSubjects ,),
          //  ),
          //       );
    
          //     },
          //               child: Text('Find Nearby Teachers'),
          //             ),
    //..................................................
    
                                      Container(
                                        width:100,
                                        child: GestureDetector(
                                          onTap: (){
                                                    if (_selectedClassSubject == null) {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) => AlertDialog(
                                                    title: Text('Class Not Selected'),
                                                    content: Text('Please select a class.'),
                                                    actions: [
                                                      TextButton(
                                                        child: Text('OK'),
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              } else if (_selectedSubjects.isEmpty) {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) => AlertDialog(
                                                    title: Text('Subjects Not Selected'),
                                                    content: Text('Please select at least one subject.'),
                                                    actions: [
                                                      TextButton(
                                                        child: Text('OK'),
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              } else {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => TeacherMapPage(
                                                      className: _selectedClassSubject?.className ?? '',
                                                      subjects: _selectedSubjects,
                                                    ),
                                                  ),
                                                );
                                              }
                                            
                                            
                                        
                                        
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(left:20),
                                            decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16),
                                            border: Border.all(width: 0.5,color: Colors.black),
                                              color: Palette.theme1
                                            ),
                                            child: Row(
                                              children: [
                                                SizedBox(height:40),
                                                Text('Search',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color:Colors.white),),
                                        
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
    
          ],
        ),
      ),
    );
  }
}
