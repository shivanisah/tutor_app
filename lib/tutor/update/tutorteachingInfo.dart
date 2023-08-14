import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tutor_app/utils/colors.dart';

import '../../Apis/fetchClassSubject.dart';
import '../../models/user_models/searchmodel.dart';
import '../../models/user_models/teacher_data.dart';
import '../../providers/auth_provider.dart';
import '../../providers/teacherProfileprovider.dart';

class TeacherTeachingInfoUpdate extends StatefulWidget{
  final TeacherData profile;
  TeacherTeachingInfoUpdate(this.profile,{super.key});


  @override
  State<TeacherTeachingInfoUpdate> createState() => _TeacherTeachingInfoUpdateState();
}

class _TeacherTeachingInfoUpdateState extends State<TeacherTeachingInfoUpdate> {


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



  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  void initState() {
        fetchClassSubjects().then((classSubjects) {
      setState(() {
        _classSubjects = classSubjects;
      });
    });

    selectedTeachinglocation = widget.profile.teaching_location?? '';
    selected_education = widget.profile.education?? '';
    selectedTeachingExperience = widget.profile.teaching_experience?? '';
    _selectedClassSubject?.className =widget.profile.grade?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TeacherData profile = ModalRoute.of(context)!.settings.arguments as TeacherData;
    final teacherprofileProvider = Provider.of<TeacherProfileProvider>(context);
    double height = MediaQuery.of(context).size.height;
    double width =  MediaQuery.of(context).size.width;
    

    return Scaffold(
      appBar: AppBar(),
      body:Container(
        margin:EdgeInsets.all(20),
        height:height,
        width:width,
        child:Form(key: formkey,
        child:SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            SizedBox(height:height*0.05),
            Text(
              "Update Your Teaching Details",
                style:  GoogleFonts.poppins(
                fontSize:  20,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                color:  Color(0xff000000),
                  ),
            ),
          SizedBox(height:30),
            Text(
               'Education',
               style:  GoogleFonts.poppins(

              fontSize:  15,
                  height:  1.5,
                color:  Colors.black,

                )
            ),  
            Container(
              margin:EdgeInsets.only(top:4),
            child:  InputDecorator(
              decoration: InputDecoration(
                border:OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
                contentPadding:const EdgeInsets.all(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                    value:selected_education.isNotEmpty?selected_education:null,

                    isExpanded: true,
                    isDense: true,
                  hint: Text('Your Education',style:TextStyle(color:Colors.black)),

              
                    
                    
                    items: [
                         ...Education.map<DropdownMenuItem<String>>((e){
              
                          return DropdownMenuItem(child: Text(e['title']),value:e['value']);
                        }).toList(),
                    ],
                    onChanged:(value){
                      setState(() {
                        selected_education = value!;
                        
                      });
                    }),
              ),
            )
          
            ),

                        SizedBox(height:14),         

           Text(
               'Teaching Experience',
               style:  GoogleFonts.poppins(

              fontSize:  15,
              height:  1.5,
              color:  Colors.black,

                )
            ),           
            Container(
              margin:EdgeInsets.only(top:4),
            child:  InputDecorator(
              decoration: InputDecoration(
                border:OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
                contentPadding:const EdgeInsets.all(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                    value:selectedTeachingExperience.isNotEmpty?selectedTeachingExperience:null,

                    isExpanded: true,
                    isDense: true,
                   hint: Text('Your Teaching Experience',style:TextStyle(color:Colors.black)),


                    
                    
                    items: [
                         ...teaching_experience.map<DropdownMenuItem<String>>((e){
              
                          return DropdownMenuItem(child: Text(e['title']),value:e['value']);
                        }).toList(),
                    ],
                    onChanged:(value){
                      setState(() {
                        selectedTeachingExperience = value!;
                      });
                    }),
              ),
            )
          
            ),

            SizedBox(height:14),         

           Text(
               'Teaching Grade',
               style:  GoogleFonts.poppins(

              fontSize:  15,
              height:  1.5,
              color:  Colors.black,

                )
            ), 

            Column(
            
                  
            children: [
              Container(
              margin:EdgeInsets.only(top:4),
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
                        hint: Text(widget.profile.grade?? '',style:TextStyle(color:Colors.black)),

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
                      checkboxTheme: CheckboxThemeData(
                        fillColor: MaterialStateProperty.all<Color>(Palette.theme1), 
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
          


            SizedBox(height:14),         

           Text(
               'Teaching Location',
               style:  GoogleFonts.poppins(

              fontSize:  15,
                  height:  1.5,
                color:  Colors.black,

                )
            ), 


          Container(
              margin:EdgeInsets.only(top: 4),
            child:  InputDecorator(
              decoration: InputDecoration(
                border:OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
                contentPadding:const EdgeInsets.all(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  
                    value:selectedTeachinglocation.isNotEmpty?selectedTeachinglocation:null,
                    isExpanded: true,
                    isDense: true,
                     hint: Text('Select Teaching Location',style:TextStyle(color:Colors.black)),

              
                    
                    
                    items: [
                         ...teaching_location.map<DropdownMenuItem<String>>((e){
              
                          return DropdownMenuItem(child: Text(e['title']),value:e['value']);
                        }).toList(),
                    ],
                    onChanged:(value){
                      setState(() {

                        selectedTeachinglocation = value!;
                      });
                    }),
              ),
            )
          
            ),
            SizedBox(height:height*0.1),
            GestureDetector(
              onTap:(){
                if(formkey.currentState!.validate()){
                  teacherprofileProvider.teacherteachingInfoUpdate(context,selectedTeachinglocation,
                  selected_education,selectedTeachingExperience,_selectedClassSubject?.className?? '',_selectedSubjects,
                  
                  widget.profile.id);
        
                }
              },
              child:Container(
                height:50,
                width:350,
                margin:EdgeInsets.all(5),
                decoration:BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color:Palette.theme1
                ),
                child:Consumer<AuthProvider>(
                  builder:(context,provider,child){
                    if(provider.loading){
                    return  Center(child: CircularProgressIndicator(color:Colors.white),);
                    }
                    else{
               return Center(child: Text(
               'Update',
               style:  GoogleFonts.poppins(

              fontSize:  17,
                  height:  1.5,
                color:  Colors.white,

                )
            ),           
);
        
                    }
                  }
                )
                
              )
            )
          ],),
        )
        ),

      )

    );

  }

}
