import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:tutor_app/utils/colors.dart';

import '../../app_urls/app_urls.dart';
import '../../models/user_models/teacher_data.dart';
import '../../providers/auth_provider.dart';
import '../../providers/teacherProfileprovider.dart';


class TeacherCertificate extends StatefulWidget{
  final TeacherData teacher;
  TeacherCertificate(this.teacher,{super.key});


  @override
  State<TeacherCertificate> createState() => _TeacherCertificateState();
}

class _TeacherCertificateState extends State<TeacherCertificate> {





  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width =  MediaQuery.of(context).size.width;
    String? certificateUrl = widget.teacher.certificate;
    // print(AppUrl.baseUrl+certificateUrl!);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        
                iconTheme: IconThemeData(color: Palette.theme1),

        
      ),
      body:          
  
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height:20),
          Expanded(
            child:SfPdfViewer.network(
            AppUrl.baseUrl+certificateUrl!
            ),

            
              // SizedBox(height:height*0.5),
              // GestureDetector(
              //   onTap:(){
              //     // if(formkey.currentState!.validate()){
              //     //   teacherprofileProvider.teachercertificateUpdate(context,widget.profile.id,);
            
              //     // }
              //   },
                // child:Container(
                //   height:50,
                //   width:350,
                //   margin:EdgeInsets.all(5),
                //   decoration:BoxDecoration(
                //     borderRadius: BorderRadius.circular(6),
                //     color:Palette.theme1
                //   ),
                //   child:Consumer<AuthProvider>(
                //     builder:(context,provider,child){
                //       if(provider.loading){
                //       return  Center(child: CircularProgressIndicator(color:Colors.white),);
                //       }
                //       else{
                //  return Center(child: Text("Update",style: TextStyle(color:Colors.white,fontSize:16),));
            
                //       }
                //     }
                //   )
                  
                // )
              // )
            // ],),

          ),
        ],
      ),

    );

  }
 


}
