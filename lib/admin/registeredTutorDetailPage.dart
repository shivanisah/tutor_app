import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tutor_app/app_urls/app_urls.dart';
import 'package:tutor_app/models/user_models/teacher_data.dart';

import 'package:http/http.dart' as http;

import '../utils/colors.dart';


class RegisteredTutorDetailPage extends StatefulWidget{

  @override
  State<RegisteredTutorDetailPage> createState() => _RegisteredTutorDetailPageState();
}

class _RegisteredTutorDetailPageState extends State<RegisteredTutorDetailPage> {
  bool isLoading = false;  

    @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<void> updateVerification(TeacherData teacher, bool verification) async {
    setState(() {
      isLoading = true;
    });
    try{
    final url = Uri.parse(AppUrl.baseUrl+'/registered_teachers/${teacher.id}/verification/');
    final now = DateTime.now();
    final response = await http.post(url,
    body:{
      'verification_date':DateFormat('yyyy-MM-dd HH:mm:ss').format(now),
    }
    );

    if (response.statusCode == 200) {

      setState(() {
              teacher.setVerification(verification);
              teacher.setVerificationDate(now);

            }); 
    final snackBar = SnackBar(content: Text('Teacher Verified'),backgroundColor: Palette.theme1,);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

         } 
         
         else {
      throw Exception('Failed to update verification');
    }
  }catch(error){

  }finally{
    setState(() {
      isLoading = false;
    });
  }
  }
    Future<void> showVerificationDialog(TeacherData teacher)async{
    return showDialog<void>(
      context:context,
      builder:(BuildContext context){
        return AlertDialog(
          title:Text("Verify teacher"),
          content:Text("Are you sure you want verify teacher?"),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
                updateVerification(teacher,true);
              },
              child:Text('Yes')
            ),
            TextButton(
              onPressed:(){
                Navigator.of(context).pop();
              },
              child:Text('No'),
            ),
          ],

        );
      }
    );
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
          height:580,
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
        





            

                      SizedBox(height:60),
                      Divider(thickness:2,endIndent: 10,),
      
            Padding(
              padding: const EdgeInsets.only(left:20.0,right:20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
            
                teacher.verification_status == true
                      ? Text("Accepted")
                      : 
   
                          SizedBox(
                            width:130,
                            child: ElevatedButton(
                              onPressed: () {
                              showVerificationDialog(teacher);

                              },
                              child: isLoading?CircularProgressIndicator(color:Colors.white):Text("Accept"),
                            ),
                          ),
              ],),
            ),
                            
          ]),
        
        ),
      ),

    );



    


  }

}
