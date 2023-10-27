import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tutor_app/models/user_models/studentnotificationmodel.dart';
import 'package:tutor_app/utils/colors.dart';

import '../providers/student_provider.dart';

class NotificationList extends StatefulWidget{
  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {

int? studentId;
bool loading = true;

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    fetchData();
  }

  Future<void> fetchData() async{

    try{
    final provider = Provider.of<StudentProvider>(context,listen:false);
    studentId = ModalRoute.of(context)!.settings.arguments as int;
        // print(studentId);

    await provider.fetchnotificationList(studentId!);

    }catch(e){

    }finally{
      setState(() {
        
        loading = false;
      });
    }
    
  }
   
   void _deleteNotification(int notificationId){
    final provider = Provider.of<StudentProvider>(context,listen:false);
    provider.deleteNotification(notificationId);

   }
   List<StudentNotification> sortData(List<StudentNotification> notifications) {
    notifications.sort((a, b) {
      final aDateTime = DateTime(a.date!.year, a.date!.month, a.date!.day);
      final bDateTime = DateTime(b.date!.year, b.date!.month, b.date!.day);
      return bDateTime.compareTo(aDateTime);
    });

    return notifications;
  }  

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StudentProvider>(context);
    final datalist =  provider.notificationlist;
    final sortedData = sortData(datalist);
    // print(datalist);

    return Scaffold(
      backgroundColor: Color(0xFFF5F7F9),
      appBar: AppBar(backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Palette.theme1),
      elevation:0
      
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        
        child: loading?Padding(
        padding: const EdgeInsets.only(top:150),

          child: Center(child: CircularProgressIndicator()),
        ):
        datalist.isEmpty?
        Center(child: Container(
          margin:EdgeInsets.only(top:200),
          child: Text("No Notification Yet"))):

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height:30),
            Container(
              child:ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: sortedData.length,
                itemBuilder: (context,index){
                  final data = sortedData[index];
                  return 
                  
                   Container(
                    margin:EdgeInsets.only(left:20,top:10,bottom:10,right:20),
                    padding:EdgeInsets.only(top:2,left:10,bottom:3),
                    height:130,
                        decoration: BoxDecoration(
                          borderRadius:BorderRadius.circular(8),
                          color: Colors.white,
            
                        ),
                        child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height:10),
                              Expanded(
                                child:RichText(
                                  text:TextSpan(
                                    children: [
                                      TextSpan(
                                        text:"From Tutor ",
                                    style:  GoogleFonts.poppins(                                
                                     fontSize:  15,
                                     fontWeight: FontWeight.w400,
                                     color: Colors.black,
                                
                                       )

                                      ),
                                    
                             TextSpan(
                                        text:data.teacher?.fullName,
                                    style:  GoogleFonts.poppins(                                
                                     fontSize:  15,
                                     fontWeight: FontWeight.w500,
                                     color: Colors.black,
                                
                                       )
                                    ),
                                TextSpan(
                                        text:" for ",
                                    style:  GoogleFonts.poppins(                                
                                     fontSize:  15,
                                     fontWeight: FontWeight.w400,
                                     color: Colors.black,
                                
                                       )
                                    ),
                                  TextSpan(
                                        text:data.enrrollmentform?.grade,
                                    style:  GoogleFonts.poppins(                                
                                     fontSize:  15,
                                     fontWeight: FontWeight.w500,
                                     color: Colors.black,
                                
                                       )
                                    ),
                             TextSpan(
                                        text:" and subjects ",
                                    style:  GoogleFonts.poppins(                                
                                     fontSize:  15,
                                     fontWeight: FontWeight.w400,
                                     color: Colors.black,
                                
                                       )
                                    ),
                             TextSpan(
                              
                                        text:data.enrrollmentform?.subjects?.join(','),
                                    style:  GoogleFonts.poppins(                                
                                     fontSize:  15,
                                     fontWeight: FontWeight.w500,
                                     color: Colors.black,
                                
                                       )
                                    ),
                             TextSpan(
                                    text:".",
                                    style:  GoogleFonts.poppins(                                
                                     fontSize:  15,
                                     fontWeight: FontWeight.w400,
                                     color: Colors.black,
                                
                                       )
                                    ),



                                    ]
                                  )
                                )
                                                            
                              ),
                            Row(children: [
                              Icon(Icons.mail,color:Palette.theme1,size: 18,),
                              SizedBox(width:8),
                              Text(data.message?? '',
                                  style:  GoogleFonts.poppins(

                                   fontSize:  14,
                                  //  height:  1.5,
                                   fontWeight: FontWeight.w400,
                                  //  color: Palette.theme1,

                                     )

                              ),
                              // SizedBox(width:80),
                              // IconButton(icon:Icon(Icons.delete_forever_rounded),
                              // color:Colors.red,
                              // iconSize: 30,
                              // onPressed:()=>_deleteNotification(data.id),
                              // )
                              ]),
                            SizedBox(height:2),
                            data.enrrollmentform?.confirmation == true?
                                                        Row(children: [
                              Icon(Icons.call,color:Palette.theme1,size: 18,),
                              SizedBox(width:8),

                                Text("Contact Tutor: ",
                                  style:  GoogleFonts.poppins(

                                   fontSize:  14,
                                   fontWeight: FontWeight.w400,

                                     )

                              ),

                              SizedBox(width:8),
                              Text(data.teacher?.phoneNumber?? '',
                                  style:  GoogleFonts.poppins(

                                   fontSize:  14,
                                  //  height:  1.5,
                                   fontWeight: FontWeight.w400,
                                  //  color: Palette.theme1,

                                     )

                              ),
                              ]):const SizedBox.shrink(),

                            Row(children: [
                              Icon(Icons.calendar_month,color:Palette.theme1,size: 18,),
                              SizedBox(width:6),
                              Text(' ${data.date?.year}-${data.date?.month.toString().padLeft(2, '0')}-${data.date?.day.toString().padLeft(2, '0')}',
                                  style:  GoogleFonts.poppins(

                                   fontSize:  14,
                                  //  height:  1.5,
                                   fontWeight: FontWeight.w400,
                                  //  color: Palette.theme1,

                                     )

                              ),
                              ]),

                              
                          
                          ],
                        )
                  );
                }
              
              )
            )
        ],),
      )
    );
  }


    


  }


