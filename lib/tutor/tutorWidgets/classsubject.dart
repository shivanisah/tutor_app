import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tutor_app/providers/classSubjectprovider.dart';
import 'package:tutor_app/utils/colors.dart';

import '../../Apis/fetchClassSubject.dart';
import '../../models/user_models/searchmodel.dart';


class RetrieveClassSubject extends StatefulWidget{
  @override
  State<RetrieveClassSubject> createState() => _RetrieveClassSubject();
}

class _RetrieveClassSubject extends State<RetrieveClassSubject> {

    List<ClassSubject> _classSubjects = [];
    List<String> _selectedSubjects = [];
    Map<String,List<String>> selectedSubjectMap = {};
    String? selectedClass;
    String? selectedSubject;
    bool _isMounted = true; 
    bool isExpanded = false;
    int? selectedIndex;
    int? teacherId;

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

  @override
  void dispose() {
    _isMounted = false; 
    super.dispose();
  }  


  @override
  Widget build(BuildContext context) {

    teacherId = ModalRoute.of(context)!.settings.arguments as int;
    double height = MediaQuery.of(context).size.height;
// print("Teacher argument: $teacherId");
    final provider = Provider.of<ClassSubjectProvider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(),
    
      body:
      // ListView.builder(
      //   itemCount:_classSubjects.length,
      //   itemBuilder: (context,index){
      //   final classSubject = _classSubjects[index];
      //   return ListTile(
      //     title: Text(classSubject.className),
      //     subtitle: Column(children: 
      //       classSubject.subjects.map((subject)=>Text(subject)).toList(),
      //     ),
    
      //   );
      // }
      
      // )
    
      SingleChildScrollView(
        child: Column(
          
          children: [
          SizedBox(height:height*0.05),
            Container(
              margin: EdgeInsets.only(left:20),
              child: Center(
                child: Text(
                  "Select Your Teaching ",
                    style:  GoogleFonts.poppins(
                    fontSize:  25,
                    fontWeight:  FontWeight.w500,
                    height:  1.5,
                    color:  Color.fromARGB(255, 44, 41, 41),
                      ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left:20),
              child: Center(
                child: Text(
                  "Class and Subjects",
                    style:  GoogleFonts.poppins(
                    fontSize:  20,
                    fontWeight:  FontWeight.w500,
                    height:  1.5,
                    color:  Color.fromARGB(255, 44, 41, 41),
                      ),
                ),
              ),
            ),
          
          
            ListView.builder(
              shrinkWrap: true,
              itemCount: _classSubjects.length,
              physics:NeverScrollableScrollPhysics(),
              itemBuilder: (context,index){
                final classsubject = _classSubjects[index];
                
                
            return           
                
            Column(
              children: [
                GestureDetector( 
                  onTap: () {
                    
                      // isExpanded = !isExpanded;
                      selectedIndex = index;
                      if(selectedIndex == index){
                        isExpanded=true;
                      }
                      else{
                        isExpanded =false;
                      }
                    setState(() {
        
                      print(isExpanded);
                      print(selectedIndex);
                    });
                    
                  },
        
                
        
          child: Container(
                          height:60,
                          // width:350,
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.only(left:10,right:5,top:5,bottom:5),
                          decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                                                  // border: Border.all(width: 0.7,color: Colors.black),
                          color: Color.fromARGB(255, 234, 235, 236),
                          ),
                          child: Row(
                            children: [
                            Icon(Icons.add_circle_outline,size: 16,),
                              SizedBox(width:15),
        
                              Text(classsubject.className,style: GoogleFonts.poppins(
                                  color:Colors.black,
                                  fontWeight:FontWeight.w400
                              )
                              // TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                              ),
                            ],
                            
                          ),
                          
        
                        ),      
        
                ),
                Visibility(
                  visible:isExpanded && selectedIndex == index,
                  child: Container(
                    
                    // color:Colors.grey,
                    margin:EdgeInsets.only(left:20),
                    child: ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children:classsubject.subjects.map<Widget>((subject){
                        return ListTile(
                          title:Text(subject),
                          leading:Theme(
                            data:ThemeData(
                              checkboxTheme: CheckboxThemeData(
                                fillColor: MaterialStateProperty.all<Color>(Palette.theme1),
                              )
                            ),
                            child:Checkbox(
                              value:selectedSubjectMap[classsubject.className]?.contains(subject)?? false,
                              onChanged: (bool? value){
                                setState(() {
                                  if(value == true){
                                    if(!selectedSubjectMap.containsKey(classsubject.className)){
                                      selectedSubjectMap[classsubject.className] = [];
                                    }
                                    selectedSubjectMap[classsubject.className]?.add(subject);
        
                                  }else{
                                    selectedSubjectMap[classsubject.className]?.remove(subject);
        
                                    if(selectedSubjectMap[classsubject.className]?.isEmpty?? false){
                                      selectedSubjectMap.remove(classsubject.className);
                                    }
                                  }
                                  
                                });
                                print(selectedSubjectMap);
                              },
        
                            )
                          )
                        );
                      }).toList(),
                    ),
                  ),
                )
              ],
            );
              }
              ),
            SizedBox(height:height*0.2),
              GestureDetector(
                onTap:(){
              for (var entry in selectedSubjectMap.entries) {
              String className = entry.key;
              List<String> subjects = entry.value;
        
              for (String subject in subjects) {
              selectedClass = className;
              selectedSubject = subject;
              print("$selectedClass:$selectedSubject");
                if(selectedClass!=null && selectedSubject!=null && teacherId!=null){
                    provider.teachingclasssubject(context, selectedClass, selectedSubject,teacherId!);
        
              }
        
          }
        }                             
          
        },
              child:Container(
                height:50,
                width:300,
                margin:EdgeInsets.all(5),
                decoration:BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color:Palette.theme1
                ),
                child:
                Consumer<ClassSubjectProvider>(
                  builder:(context,provider,child){
                    if(provider.loading){
                    return  Center(child: CircularProgressIndicator(color:Colors.white),);
                    }
                    else{
               return Center(child: Text(
               'Done',
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
              ),
        //       ElevatedButton(child:Text("Done"),
              
        //                     onPressed:() {
        //                       try{
                                
        //                         // selectedSubjectMap.forEach((className, subjects) {
        //                         //   for(String subject in subjects){
        //                         //     selectedClass = className;
        //                         //     selectedSubject = subject;
        //                         //     // print("$selectedClass:$selectedSubject:$teacher");
        //                         //     if(selectedClass!=null && selectedSubject!=null){
        //                         //     provider.teachingclasssubject(context, selectedClass, selectedSubject, teacher);
        
        //                         //     }
        //                         //   }
        //                         // });
        //       for (var entry in selectedSubjectMap.entries) {
        //       String className = entry.key;
        //       List<String> subjects = entry.value;
        
        //       for (String subject in subjects) {
        //       selectedClass = className;
        //       selectedSubject = subject;
        //       print("$selectedClass:$selectedSubject");
        //         if(selectedClass!=null && selectedSubject!=null && teacherId!=null){
        //             provider.teachingclasssubject(context, selectedClass, selectedSubject,teacherId!);
        
        //       }
        
        //   }
        // }                             
        //   }
        //   catch(e){
        //         print("Error: $e");
        //         }
        //     }
        //       )
          ],
        ),
      )
    
    );

  }
  


  void RetrieveandDisplaySubject() {
    selectedSubjectMap.forEach((className, subjects) { 
        for(String subject in subjects ){
          selectedClass = className;
          selectedSubject = subject;
          
          print("$selectedClass:$selectedSubject");

        }
        

    });
  }
}
