import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutor_app/models/user_models/teacher_data.dart';


import '../utils/colors.dart';


class VerifiedTutorDetailPage extends StatefulWidget{

  @override
  State<VerifiedTutorDetailPage> createState() => _VerifiedTutorDetailPageState();
}

class _VerifiedTutorDetailPageState extends State<VerifiedTutorDetailPage> {
  bool isLoading = false;  

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



  @override
  Widget build(BuildContext context) {
    
    TeacherData teacher = ModalRoute.of(context)!.settings.arguments as TeacherData;
 
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(

      appBar:AppBar(

      ),

      body:SingleChildScrollView(
        child: Container(
          padding:EdgeInsets.only(top:20,left:10),
          margin: EdgeInsets.only(left:20,right:20,top:40,bottom:30),
          height:height*0.94,
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
                              Text("Teaching Grade",
                style:  GoogleFonts.poppins(
                fontSize:  16,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                color: const Color.fromARGB(221, 83, 79, 79),
                  ),
              ),
              Text(teacher.grade?? '',
                style:  GoogleFonts.poppins(
                fontSize:  16,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                color: Colors.black,
                  ),
              ),
              SizedBox(height:14),
                              Text("Teaching Subjects",
                style:  GoogleFonts.poppins(
                fontSize:  16,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                color: const Color.fromARGB(221, 83, 79, 79),
                  ),
              ),
              Text('${teacher.subjects?.join(',')}',
                style:  GoogleFonts.poppins(
                fontSize:  16,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                color: Colors.black,
                  ),
              ),
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
