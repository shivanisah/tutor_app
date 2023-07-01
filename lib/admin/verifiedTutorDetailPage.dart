import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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



  @override
  Widget build(BuildContext context) {
    
    TeacherData teacher = ModalRoute.of(context)!.settings.arguments as TeacherData;

    return Scaffold(

      appBar:AppBar(

      ),

      body:SingleChildScrollView(
        child: Container(
          padding:EdgeInsets.only(top:20,left:10),
          margin: EdgeInsets.only(left:20,right:20,top:40,bottom:30),
          height:500,
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
                      Text("Education Details",style:TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color:Palette.theme1)),
                      SizedBox(height:12),  
                       Row(children: [
                            Icon(Icons.school,size:18),
                              SizedBox(width:10),

                              Text("Education: ",style:TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                              Text('${teacher.education}',style:TextStyle(fontSize: 16)),
                              ]), 

                     SizedBox(height:12),  
                       Row(children: [
                            Icon(Icons.timeline,size:18),
                              SizedBox(width:10),

                              Text("Teaching Experience: ",style:TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                              Text('${teacher.teaching_experience}',style:TextStyle(fontSize: 16)),
                              ]),     
                    SizedBox(height:12),  
                       Row(children: [
                            Icon(Icons.map,size:18),
                              SizedBox(width:10),

                              Text("Teaching Location: ",style:TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                              Text('${teacher.teaching_location}',style:TextStyle(fontSize: 16)),
                              ]),     
                    SizedBox(height:12),  
                       Row(children: [
                            Icon(Icons.class_,size:18),
                              SizedBox(width:10),

                              Text("Teaching Grade: ",style:TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                              Text('${teacher.grade}',style:TextStyle(fontSize: 16)),
                              ]),
                                          SizedBox(height:12),  
                       Row(children: [
                            Icon(Icons.class_,size:18),
                              SizedBox(width:10),

                              Text("Teaching Subjects: ",style:TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                              Text('${teacher.subjects?.join(',')}',style:TextStyle(fontSize: 16)),
                              ]),     
        





            

                      // SizedBox(height:60),
                      // Divider(thickness:2,endIndent: 10,),
      
            // Padding(
            //   padding: const EdgeInsets.only(left:20.0,right:20),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            
            //     teacher.verification_status == true
            //           ? Text("Accepted")
            //           : 
   
            //               SizedBox(
            //                 width:130,
            //                 child: ElevatedButton(
            //                   onPressed: () {
            //                   // showVerificationDialog(teacher);

            //                   },
            //                   child: isLoading?CircularProgressIndicator(color:Colors.white):Text("Accept"),
            //                 ),
            //               ),
            //   ],),
            // ),
                            
          ]),
        
        ),
      ),

    );



    


  }

}
