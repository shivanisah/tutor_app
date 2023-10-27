import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutor_app/admin/teachercertificate.dart';
import 'package:tutor_app/models/user_models/teacher_data.dart';


import '../app_urls/app_urls.dart';
import '../models/user_models/classsubjectmodel.dart';
import '../utils/colors.dart';
import 'package:http/http.dart' as http;


class VerifiedTutorDetailPage extends StatefulWidget{
  late final TeacherData profile;
  VerifiedTutorDetailPage({required this.profile});

  @override
  State<VerifiedTutorDetailPage> createState() => _VerifiedTutorDetailPageState();
}

class _VerifiedTutorDetailPageState extends State<VerifiedTutorDetailPage> {
  bool isLoading = false;  
  bool isblocked= false;  


    @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
    Future<void> showVerificationDialog(TeacherData teacher)async{
    return showDialog<void>(
      context:context,
      builder:(BuildContext context){
        return AlertDialog(
          title:Text("Change Status"),
          content:Text("Take Actions"),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
                // updateVerification(teacher,true);
              },
              child:Text('Cancel Verified Tutor')
            ),

            TextButton(
              onPressed:(){
                Navigator.of(context).pop();
              },
              child:Text('Back'),
            ),
          ],

        );
      }
    );
  }

//block and unblock
    Future<void> blockUser(TeacherData teacher, bool block) async {
    setState(() {
      isblocked = true;
    });
    try{
    final url = Uri.parse(AppUrl.baseUrl+'/blockUser/${teacher.id}');
    
    final response = await http.post(url
    );
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {

      setState(() {
              teacher.setBlockedUser(block);

            }); 
    final snackBar = SnackBar(content: Text('User blocked and message sent to user'),backgroundColor: Palette.theme1,);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

         } 
         
         else {
      throw Exception('Failed to block user');
    }
  }catch(error){

  }finally{
    setState(() {
      isblocked = false;
    });
  }
  }
 
     Future<void> UnblockUser(TeacherData teacher, bool block) async {
    setState(() {
      isblocked = true;
    });
    try{
    final url = Uri.parse(AppUrl.baseUrl+'/UnblockUser/${teacher.id}');
    
    final response = await http.post(url
    );
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {

      setState(() {
              teacher.setUnBlockedUser(block);

            }); 
    final snackBar = SnackBar(content: Text('User active and message sent to user'),backgroundColor: Palette.theme1,);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

         } 
         
         else {
      throw Exception('Failed to unblock user');
    }
  }catch(error){

  }finally{
    setState(() {
      isblocked = false;
    });
  }
  }

    Future<void> showBlockingDialog(TeacherData teacher)async{
    return showDialog<void>(
      context:context,
      builder:(BuildContext context){
        return AlertDialog(
          title:Text("Block User"),
          content:Text("Are you sure you want to block?"),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
                blockUser(teacher,true);
              },
              child:Text('Yes')
            ),
            TextButton(
              onPressed:(){
                Navigator.of(context).pop();
              },
              child:Text('Cancel'),
            ),
          ],

        );
      }
    );
  }
      Future<void> showUnBlockDialog(TeacherData teacher)async{
    return showDialog<void>(
      context:context,
      builder:(BuildContext context){
        return AlertDialog(
          title:Text("UnBlock User"),
          content:Text("Are you sure you want to active the blocked user?"),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
                UnblockUser(teacher,false);
              },
              child:Text('Yes')
            ),
            TextButton(
              onPressed:(){
                Navigator.of(context).pop();
              },
              child:Text('Cancel'),
            ),
          ],

        );
      }
    );
  }



  @override
  Widget build(BuildContext context) {
    
    TeacherData teacher = ModalRoute.of(context)!.settings.arguments as TeacherData;
    List<GradeSubjectsModel>? classsubject = widget.profile.classSubjectfinallist;

 
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(

      appBar:AppBar(

      ),

      body:SingleChildScrollView(
        child: Container(
          padding:EdgeInsets.only(top:20,left:10,bottom: 10),
          margin: EdgeInsets.only(left:20,right:20,top:40,bottom:30),
          // height:height*0.94,
          width:350,
          
          // color:Colors.blue,
          decoration:BoxDecoration(
            borderRadius:BorderRadius.circular(20),
            // border:Border.all(color:Colors.blueGrey,width: 2),
            
            color:Colors.white,
                    boxShadow:[
                                BoxShadow(
                                  color: Colors.grey,
      
                                  blurRadius:3,
                                  offset:Offset(0,1),
                                ),
                              ]
      
          ),
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Row(children: [
              Icon(Icons.account_circle_rounded,size:90,color:Palette.theme1),
              SizedBox(width:10),
              Column(
                crossAxisAlignment:CrossAxisAlignment.start,
      
                children: [
                Text('${teacher.fullName}',style:TextStyle(fontSize: 20)),
                SizedBox(height:6),
                Text('${teacher.email}',style:TextStyle(fontSize: 15)),
                // Text('${enrollment.students_email}',style:TextStyle(fontSize: 15)),

      
              ],)
      
            ],),
            Divider(thickness: 2,color:Colors.blueGrey,indent:5,endIndent: 10,),
            SizedBox(height:7),
            Row(children: [
                              Icon(Icons.face,size:18),
                              SizedBox(width:10),
                              Text("Gender: ",style:TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                              Text(teacher.gender?? '',style:TextStyle(fontSize: 16)),
                              ]),

            SizedBox(height:12),
                        Row(children: [
                              Icon(Icons.place_rounded,size:18),
                              SizedBox(width:10),

                              Text("Address: ",style:TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                              Text(teacher.address?? '',style:TextStyle(fontSize: 16)),
                              ]),
     
            SizedBox(height:12),  
                        Row(children: [
                              Icon(Icons.call,size:18),
                              SizedBox(width:10),

                              Text("Phone Number: ",style:TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                              Text(teacher.phoneNumber,style:TextStyle(fontSize: 16)),
                              ]),
     
    
                      SizedBox(height:10),
                      Divider(endIndent: 10,),
                      Text("Teaching Details",style:TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color:Palette.theme1)),
                      SizedBox(height:12),  

                Text("Education",
                style:  GoogleFonts.poppins(
                fontSize:  16,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                color: const Color.fromARGB(221, 83, 79, 79),
                  ),
              ),
              Text(teacher.education?? '',
                style:  GoogleFonts.poppins(
                fontSize:  16,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                color: Colors.black,
                  ),
              ),
              SizedBox(height:14),
                  Text("Teaching Experience",
                style:  GoogleFonts.poppins(
                fontSize:  16,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                color: const Color.fromARGB(221, 83, 79, 79),
                  ),
              ),
              Text(teacher.teaching_experience?? '',
                style:  GoogleFonts.poppins(
                fontSize:  16,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                color: Colors.black,
                  ),
              ),
              SizedBox(height:14),
                Row(
                children: [
                  Text("Teaching Class and Subjects",
                    style:  GoogleFonts.poppins(
                    fontSize:  16,
                    fontWeight:  FontWeight.w500,
                    height:  1.5,
                    color: const Color.fromARGB(221, 83, 79, 79),
                      ),
                  ),

                ],
              ),
              
              for(final classname in classsubject!)
                  Column(children: [
              Row(
                children: [
                  Text(classname.class_name?? '',
                    style:  GoogleFonts.poppins(
                    fontSize:  16,
                    fontWeight:  FontWeight.w500,
                    height:  1.5,
                    color: Colors.black,
                      ),         
                  ),
                  SizedBox(width:10),
              Text(classname.subject_name?.join(',')?? '',
                style:  GoogleFonts.poppins(
                fontSize:  16,
                fontWeight:  FontWeight.w400,
                height:  1.5,
                color: Colors.black,
                  ),         
              ),


                ],
              ),

                  ],),
              SizedBox(height:14),
              Text("Teaching Location",
                style:  GoogleFonts.poppins(
                fontSize:  16,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                color: const Color.fromARGB(221, 83, 79, 79),
                  ),
              ),
              Text(teacher.teaching_location?? '',
                style:  GoogleFonts.poppins(
                fontSize:  16,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                color: Colors.black,
                  ),
              ),
              SizedBox(height:14),
                            Row(
                      children: [
                Text("Teacher Educational Certificate ",
                style:  GoogleFonts.poppins(
                fontSize:  16,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                color: Colors.black,
                  ),
              ),

                        GestureDetector(
                              onTap:(){
                          Navigator.push(                
                            context,MaterialPageRoute(builder: (context) => TeacherCertificate(teacher),
                            )
                            
                            );

                              },
                              child:Icon(Icons.visibility,color:Palette.theme1)
                            ),
                      ],
                    ),
                      SizedBox(height:14),
                            teacher.block == false?
                                              Row(children: [
                      Icon(Icons.person,color:Colors.black),
                      SizedBox(width:12),
                      GestureDetector(child:Text("Block",                style:  GoogleFonts.poppins(
                fontSize:  16,
                fontWeight:  FontWeight.w700,
                height:  1.5,
                color: Palette.theme1,
                  ),
                    ),
                      onTap:() {
                    showBlockingDialog(teacher);
                     },)              
                      ],) :                               
                             Row(
                                children: [
                                  Icon(Icons.block_rounded,color:Colors.red),
                                  SizedBox(width:12),
                                  GestureDetector(child:Text("Unblock",style:  GoogleFonts.poppins(
                fontSize:  16,
                fontWeight:  FontWeight.w700,
                height:  1.5,
                color:Palette.theme1,
                  ),
                ),
                                  onTap:(){
                                    showUnBlockDialog(teacher);
                                  }
                                  ),
                                ],
                              ),


                      SizedBox(height:14),
                      Divider(thickness:2,endIndent: 10,),
      
            Center(
              child: GestureDetector(
                onTap:(){
               showVerificationDialog(teacher);

                  
                },
                child:Container(
                  height:height*0.06,
                  width:width*0.4,
                  margin:EdgeInsets.all(5),
                  decoration:BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color:Palette.theme1
                  ),
                  child:
                      
                  Center(child: Text("Change Status",
                  style:  GoogleFonts.poppins(
                  fontSize:  18,
                  fontWeight:  FontWeight.w500,
                  height:  1.5,
                  color: Colors.white,
                    ),
            
                  ))            
                  
                )
              ),
            )
                            
          ]
          ),
        
        ),
      ),

    );



    


  }

}
