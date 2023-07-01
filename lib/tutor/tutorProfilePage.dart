import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../models/user_models/teacherProfilemodel.dart';
import '../../providers/teacherProfileprovider.dart';
import '../../shared_preferences.dart/user_preferences.dart';
import '../../utils/colors.dart';
import '../Apis/fetchClassSubject.dart';
import '../models/user_models/searchmodel.dart';


class TeacherProfilePage extends StatefulWidget{
  @override
  State<TeacherProfilePage> createState() => _TeacherProfilePage();
}

class _TeacherProfilePage extends State<TeacherProfilePage> {

  

    final userPreferences = UserPreferences();
    int? teacherId;


bool _isMounted = true; 

  @override
  void dispose() {
    _isMounted = false; 
    super.dispose();
  }  
String selectedTeachinglocation = "";

List teaching_location = [
  
    {"title":"Student Home","value":"Student Home"},
    {"title":"Tutor Place","value":"Tutor Place"},
    {"title":"Both","value":"Both"},


];
String selected_education="";
List Education = [
   { "title":'Secondary level',"value":'Secondary level' },
    {"title":'Higher Secondary level(Pursuing)',"value":'Higher Secondary level(Pursuing)'},
    {"title":'Higher Secondary level(Completed)',"value":'Higher Secondary level(Completed)'},
    {"title":'Bachelors Degree(Pursuing)',"value":'Bachelors Secondary level(Pursuing)'},
    {"title":'Bachelors Degree(Completed)',"value":'Bachelors Degree(Completed)'},
    {"title":'Masters Degree(Pursuing)',"value":'Masters Degree(Pusuing)'},
    {"title":'Masters Degree(Completed)',"value":'Masters Degree(Completed)'},

];

String selectedTeachingExperience="";
List teaching_experience = [
  { "title":'Not Yet',"value":'Not Yet' },
  { "title":'1 Year',"value":'1 Year' },
  { "title":'2 Years',"value":'2 Years' },
  { "title":'3 Years',"value":'3 Years' },
   { "title":'4 Years',"value": '4 Years'},
   { "title":'5 Years',"value": '5 Years'},
   { "title":'6 Years',"value": '6 Years'},
   { "title":'7 Years',"value":'7 Years' },
   { "title":'8 Years',"value":'8 Years' },
   { "title":'9 Years',"value": '9 Years'},
   { "title":'10 Years',"value": '10 Years'},
  { "title":'10+ Years',"value": '10+ Years'},

];

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
    _isMounted = true;
  }
void setSelectedTeachingExperience(String? value){
      setState(() {
        selectedTeachingExperience= value!;
   TeacherProfile(
      id: teacherId!,
      teaching_experience: selectedTeachingExperience,
    );
      });   
  
}
void setSelectedEducation(String? value){
      setState(() {
        selected_education= value!;
        TeacherProfile(
      id: teacherId!,
      education: selected_education,
    );

      });   
  
}


void setSelectedTeachingLocation(String? value){
      setState(() {
        selectedTeachinglocation = value!;
                TeacherProfile(
      id: teacherId!,
      teaching_location: selectedTeachinglocation,
    );

      });   
  
}

void setSelectedGrade(String? value){
      setState(() {
        selectedTeachinglocation = value!;

      });   
                TeacherProfile(
      id: teacherId!,
      teaching_location: selectedTeachinglocation,
    );
  
}



@override
void didChangeDependencies() {
  super.didChangeDependencies();
  final teacherprofileProvider = Provider.of<TeacherProfileProvider>(context, listen: false);
  final userPreferences = UserPreferences();

  userPreferences.getUser().then((teacher) {
    if (teacher != null && _isMounted) {
      setState(() {
        teacherId = teacher.id;
        teacherprofileProvider.fetchTeacherProfile(teacherId!);
      });
    }
  });
}

  @override
  Widget build(BuildContext context) {
    final teacherprofileProvider = Provider.of<TeacherProfileProvider>(context);
    final profile = teacherprofileProvider.teacherProfile;
    // final userPreferences = UserPreferences();
    // int? teacherId;

    // userPreferences.getUser().then((teacher) {
    //   if (teacher != null && _isMounted) {
    //     setState(() {
    //       teacherId = teacher.id;
    //       // print(teacherId);
    //     });
    //   }
    // });  


    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                        SizedBox(height:40),
                        
                Container(
                  margin:EdgeInsets.only(left:30),
                  child: Text(
                     'Profile Details',
                     style:  GoogleFonts.poppins(
                
                    fontSize:  25,
                        fontWeight:  FontWeight.w500,
                        height:  1.5,
                        
                      color:  Color(0xff000000),
                
                      )
                  ),
                ),
          
            // SizedBox(height:20),
                      Container(
              margin:EdgeInsets.all(20),
            child:  InputDecorator(
              decoration: InputDecoration(
                border:OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
                contentPadding:const EdgeInsets.all(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                    // value:selected_education,
                   value:selected_education.isNotEmpty?selected_education:profile?.education?? '',

                    isExpanded: true,
                    isDense: true,
              
              
                    
                    
                    items: [
                        const DropdownMenuItem(child: Text("Your Education"),value:""),
                         ...Education.map<DropdownMenuItem<String>>((e){
              
                          return DropdownMenuItem(child: Text(e['title']),value:e['value']);
                        }).toList(),
                    ],
                    onChanged:(value){
                      setState(() {
                        setSelectedEducation(value);
                        // selected_education = value!;
                        
                      });
                    }),
              ),
            )
          
            ),
            Container(
              margin:EdgeInsets.all(20),
            child:  InputDecorator(
              decoration: InputDecoration(
                border:OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
                contentPadding:const EdgeInsets.all(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                    // value:selectedTeachingExperience,
                   value:selectedTeachingExperience.isNotEmpty?selectedTeachingExperience:profile?.teaching_experience?? '',

                    isExpanded: true,
                    isDense: true,
              

                    
                    
                    items: [
                        const DropdownMenuItem(child: Text("Your Teaching Experience"),value:""),
                         ...teaching_experience.map<DropdownMenuItem<String>>((e){
              
                          return DropdownMenuItem(child: Text(e['title']),value:e['value']);
                        }).toList(),
                    ],
                    onChanged:(value){
                      setState(() {
                        setSelectedTeachingExperience(value);
                        // selectedTeachingExperience = value!;
                      });
                    }),
              ),
            )
          
            ),
      
      //Class and subjects
             Column(
            
                  
            children: [
              Container(
              margin:EdgeInsets.all(20),
                child: InputDecorator(
                                decoration: InputDecoration(
                border:OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
                contentPadding:const EdgeInsets.all(10),
              ),

                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<ClassSubject>(
                      value: _selectedClassSubject,
                      isExpanded:true,
                      isDense: true,
                      // hint: profile?.grade!=null?Text('${profile?.grade}',style:TextStyle(color:Colors.black)):Text('Select class',style:TextStyle(color:Colors.black)),
                        hint: Text('Select class',style:TextStyle(color:Colors.black)),

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
              ),
              SizedBox(height: 4),
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
            ]
          ),
      
      
      
                      Container(
              margin:EdgeInsets.all(20),
            child:  InputDecorator(
              decoration: InputDecoration(
                border:OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
                contentPadding:const EdgeInsets.all(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                    value:selectedTeachinglocation.isNotEmpty?selectedTeachinglocation:profile?.teaching_location?? '',
                  
                    // value:selectedTeachinglocation,
                    isExpanded: true,
                    isDense: true,
              
              
                    
                    
                    items: [
                        const DropdownMenuItem(child: Text("Select location for Teaching"),value:""),
                         ...teaching_location.map<DropdownMenuItem<String>>((e){
              
                          return DropdownMenuItem(child: Text(e['title']),value:e['value']);
                        }).toList(),
                    ],
                    onChanged:(value){
                      setState(() {
                       print("///////////////////");
                        print(selectedTeachinglocation);

                        setSelectedTeachingLocation(value);
                        // selectedTeachinglocation = value!;
                      });
                    }),
              ),
            )
          
            ),
      
      
                            SizedBox(height:30),
                        GestureDetector(
                          
                                          onTap: ()async{
                          //             if(selectedTeachinglocation=="" 
                                      
                          //             ){
                          // final snackBar = SnackBar(content: Text('All selection fields are required'));
                          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
          
                          //             }
                                      

                            //  updateTeacherProfile();           
                                         
                final teacher = TeacherProfile(
                  id: teacherId!, 
                  teaching_location: selectedTeachinglocation,
                  teaching_experience: selectedTeachingExperience,
                  education: selected_education, 
                  className : _selectedClassSubject?.className?? '',
                  subjects:_selectedSubjects
                );
          
                await teacherprofileProvider.updateTeacher(context,teacher.id, teacher);
              
          
                                      
          
                                          },
                                          child: Container(
                                            margin:EdgeInsets.all(20),
                                            height:50,
                                            width:350,
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(6),
                                            // border: Border.all(width: 0.7,color: Colors.black),
                                              color: Palette.theme1
                                            ),
                                            child:
          
                                                        
                                                Center(child: Text('Update',style:TextStyle(color:Colors.white,fontSize: 16))),                                       
                                          ),
                                        ),
          
          ],
        ),
      ),
    );



    


  }

}
