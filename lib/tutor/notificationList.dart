import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tutor_app/models/user_models/teachernotification.dart';
import 'package:tutor_app/tutor/update/tutorCertificateUpdate.dart';
import 'package:tutor_app/utils/colors.dart';

import '../models/user_models/teacher_data.dart';
import '../providers/teacherProfileprovider.dart';

class TeacherNotificationList extends StatefulWidget{
    final TeacherData profile;
  TeacherNotificationList(this.profile,{super.key});

  @override
  State<TeacherNotificationList> createState() => _TeacherNotificationListState();
}

class _TeacherNotificationListState extends State<TeacherNotificationList> {

int? teacherId;
bool loading = true;

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    fetchData();
  }

  Future<void> fetchData() async{

    try{
    final provider = Provider.of<TeacherProfileProvider>(context,listen:false);
    teacherId = ModalRoute.of(context)!.settings.arguments as int;

    await provider.fetchnotificationList(teacherId!);

    }catch(e){

    }finally{
      setState(() {
        loading = false;
      });
    }
    
  }
 List<TeacherNotification> sortNotification(List<TeacherNotification> datalists) {
    datalists.sort((a, b) {
      final aDateTime = DateTime(a.date!.year, a.date!.month, a.date!.day);
      final bDateTime = DateTime(b.date!.year, b.date!.month, b.date!.day);
      return bDateTime.compareTo(aDateTime);
    });

    return datalists;
  }  

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TeacherProfileProvider>(context);
    final datalist =  provider.notificationlist;
    final sortedNotification = sortNotification(datalist);

    // print(datalist);

    return Scaffold(
      backgroundColor: Color(0xFFF5F7F9),
      appBar: AppBar(backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Palette.theme1),
      
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
                itemCount: sortedNotification.length,
                itemBuilder: (context,index){
                  final data = sortedNotification[index];
                  return 
                  
                   Container(
                    margin:EdgeInsets.only(left:20,top:10,bottom:10,right:20),
                    padding:EdgeInsets.only(top:6,left:10,bottom:6,right:3),
                    // height:120,
                        decoration: BoxDecoration(
                          borderRadius:BorderRadius.circular(8),
                          color: Colors.white,
            
                        ),
                        child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // SizedBox(height:4),
                            Row(children: [
                              // SizedBox(width:5),
                              // Icon(Icons.mail,color:Palette.theme1,size: 18,),
                              SizedBox(width:2),
                              Expanded(
                                child: Text(data.message?? '',
                                    style:  GoogleFonts.poppins(
                                                          
                                     fontSize:  16,
                                    //  height:  1.5,
                                     fontWeight: FontWeight.w400,
                                    //  color: Palette.theme1,
                                                          
                                       )
                                                          
                                ),
                              ),
                              // SizedBox(width:80),
                              // IconButton(icon:Icon(Icons.delete_forever_rounded),
                              // color:Colors.red,
                              // iconSize: 30,
                              // onPressed:()=>_deleteNotification(data.id),
                              // )
                              ]),
                            SizedBox(height:1),
                  data.previewCertificate == true? GestureDetector(
                onTap:(){
                Navigator.push(context,MaterialPageRoute(builder: (context) => TeacherUpdateCertificate(widget.profile),),
                );

                                                            },
                child: Text("View your Certificate",
                style:  GoogleFonts.poppins(
                fontSize:  15,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                color: Palette.theme1,
                  ),
              ),

              ):SizedBox.shrink(),

                            Row(children: [
                              // SizedBox(width:5),
                              // Icon(Icons.calendar_month,color:Palette.theme1,size: 18,),
                              // SizedBox(width:6),
                              Text(' ${data.date?.year}-${data.date?.month.toString().padLeft(2, '0')}-${data.date?.day.toString().padLeft(2, '0')}',
                                  style:  GoogleFonts.poppins(

                                   fontSize:  14,
                                  //  height:  1.5,
                                   fontWeight: FontWeight.w500,
                                   color: const Color.fromARGB(221, 83, 79, 79),

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


