import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:tutor_app/utils/colors.dart';

import '../../app_urls/app_urls.dart';
import '../../models/user_models/teacher_data.dart';
import '../../providers/teacherProfileprovider.dart';


class TeacherUpdateCertificate extends StatefulWidget{
  final TeacherData profile;
  TeacherUpdateCertificate(this.profile,{super.key});


  @override
  State<TeacherUpdateCertificate> createState() => _TeacherUpdateCertificateState();
}

class _TeacherUpdateCertificateState extends State<TeacherUpdateCertificate> {

File? _certificateFile;
String? _certificateFilePath;
  final picker = ImagePicker();

// Future _pickCertificate()async{
//   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//   if(pickedFile !=null){
//     setState(() { _certificateFile = File(pickedFile.path);
//     _certificateFilePath = pickedFile.path;
//     }
//     );
//   }


// }

Future _pickCertificate() async {
  try {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx'],
    );

    if (result != null) {
      PlatformFile file = result.files.single;
      setState(() {
        _certificateFile = File(file.path!);
        print(_certificateFile);
        _certificateFilePath = file.name;
        print(_certificateFilePath);
      });
    }
  } catch (e) {
    print("Error picking certificate file: $e");
  }
}

void _showCertificateDialog(BuildContext context){

  showDialog(
      context:context,
      builder:(BuildContext context){
            final teacherprofileProvider = Provider.of<TeacherProfileProvider>(context);

        return AlertDialog(
          title:Text("Upload Certificate"),
          content:Text("Uplaod your Education certificate in pdf format"),
          actions: [
                TextFormField(  
                readOnly: true,
                onTap: _pickCertificate,
                decoration:InputDecoration(             
                border:InputBorder.none,  
                hintText:_certificateFilePath!=null? 
                _certificateFilePath:            
                "Upload Certificate",
                hintStyle: TextStyle(color:Colors.black),
                fillColor: Palette.fillcolor,
                filled: true,
                suffixIcon: IconButton(icon: Icon(Icons.attach_file),onPressed: _pickCertificate,),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red,),
                  borderRadius:BorderRadius.circular(6),
                ),
                focusedErrorBorder: OutlineInputBorder
                (borderSide:BorderSide(color:Colors.red),
                borderRadius:BorderRadius.circular(6),
                ),
                enabledBorder:OutlineInputBorder(                 
                    borderRadius:BorderRadius.circular(6),
                    borderSide:BorderSide(color: Palette.fillcolor), 
                  ),
                  focusedBorder:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide:BorderSide(color:Palette.theme1)
                  )
                    
                ),            
                 ),

            Row(
              children: [
                ElevatedButton(onPressed: (){
                  teacherprofileProvider.teachercertificateUpdate(context,widget.profile.id, _certificateFile);
                  Navigator.of(context).pop();


                },
                child:Text("Upload"),
                ),
                            TextButton(onPressed: (){
                                Navigator.of(context).pop();

            },
            child:Text("Cancel"),
            )

              ],
            ),

          ],
        );
      }
  );
}


  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // final teacherprofileProvider = Provider.of<TeacherProfileProvider>(context);
    // double height = MediaQuery.of(context).size.height;
    // double width =  MediaQuery.of(context).size.width;
    String? certificateUrl = widget.profile.certificate;
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCertificateDialog(context),
        child: Icon(MdiIcons.fileUploadOutline),
        backgroundColor: Palette.theme1,
      ),

    );

  }
 
 void _updateCertificate(BuildContext context){


 }
}
