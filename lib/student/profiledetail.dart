import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tutor_app/FirstScreen/Home.dart';
import 'package:tutor_app/providers/student_provider.dart';
import 'package:tutor_app/student/updateprofile.dart';
import 'package:tutor_app/utils/colors.dart';
import '../shared_preferences.dart/user_preferences.dart';





class StudentProfileDetailPage extends StatefulWidget{
  @override
  State<StudentProfileDetailPage> createState() => _StudentProfileDetailPageState();
}

class _StudentProfileDetailPageState extends State<StudentProfileDetailPage> {


    final userPreferences = UserPreferences();
    String user_type = '';

  int? studentId;
  bool isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchData();
  }

  Future<void>  fetchData()async{
    try{
    final studentProfileProvider = Provider.of<StudentProvider>(context);
    studentId = ModalRoute.of(context)!.settings.arguments as int;
    await studentProfileProvider.fetchStudentProfile(studentId!);

    }catch(error){

    }finally{
      setState(() {
        isLoading = false;
      });
    }
  }

 

  @override
  Widget build(BuildContext context) {

      userPreferences.getUser().then((teacher) {
      setState(() {
          user_type = teacher.user_type?? '';
      });
    });  


  final studentProfileProvider = Provider.of<StudentProvider>(context);
  final profile = studentProfileProvider.studentProfile;

  // double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.height;

  // print('Image URL: ${profile!.image}');


  return Scaffold(

    backgroundColor: Color(0xFFF5F7F9),
    appBar: AppBar(
      backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            leading:IconButton(icon:Icon(Icons.arrow_back),
            onPressed:() {
              Navigator.push(context,MaterialPageRoute(builder: (context) => Home(),
              settings:RouteSettings(arguments:user_type)
              ));
            },
            )
    ),
    body:SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height:20),
            Text("Profile Details",
                style:  GoogleFonts.poppins(
                fontSize:  23,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                color: Palette.theme1,
                  ),

                      ),

               Container(
                margin:EdgeInsets.only(left:14,top:20,bottom:10,right:14),
                padding:EdgeInsets.only(top:10,left:10,bottom:10),
                // height:height*0.3,
                width:width,
                decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(8),
                  color: Colors.white,           
                    ),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      isLoading?Center(child:CircularProgressIndicator()):profile==null?Text("Profile Not Found"):

                        SizedBox(height:2),
              Text("Name",
                style:  GoogleFonts.poppins(
                fontSize:  16,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                color: const Color.fromARGB(221, 83, 79, 79),
                  ),
              ),
              Text(profile?.name?? '',
                style:  GoogleFonts.poppins(
                fontSize:  16,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                color: Colors.black,
                  ),
              ),
                            SizedBox(height:14),
              Text("Gender",
                style:  GoogleFonts.poppins(
                fontSize:  16,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                color: const Color.fromARGB(221, 83, 79, 79),
                  ),
              ),
              Text(profile?.gender?? '',
                style:  GoogleFonts.poppins(
                fontSize:  16,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                color: Colors.black,
                  ),
              ),


              SizedBox(height:14),
              Text("Contact Number",
                style:  GoogleFonts.poppins(
                fontSize:  16,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                color: const Color.fromARGB(221, 83, 79, 79),
                  ),
              ),
              Row(
                children: [
                  Text(profile?.number?? '',
                    style:  GoogleFonts.poppins(
                    fontSize:  16,
                    fontWeight:  FontWeight.w500,
                    height:  1.5,
                    color: Colors.black,
                      ),
                  ),
                  SizedBox(width:width*0.23),
                  GestureDetector(child:Icon(Icons.edit,color:Palette.theme1),
                  onTap:(){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>StudentProfileUpdate(profile!)
                    ));
                  }
                  )
                ],
              ),
              SizedBox(height:14),
              Text("Email",
                style:  GoogleFonts.poppins(
                fontSize:  16,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                color: const Color.fromARGB(221, 83, 79, 79),
                  ),
              ),
              Text(profile?.email?? '',
                style:  GoogleFonts.poppins(
                fontSize:  16,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                color: Colors.black,
                  ),
              ),
              SizedBox(height:14),
              Text("Parents Name",
                style:  GoogleFonts.poppins(
                fontSize:  16,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                color: const Color.fromARGB(221, 83, 79, 79),
                  ),
              ),
              Text(profile?.parents_name?? '',
                style:  GoogleFonts.poppins(
                fontSize:  16,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                color: Colors.black,
                  ),
              ),
              SizedBox(height:14),
              Text("Parents Number",
                style:  GoogleFonts.poppins(
                fontSize:  16,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                color: const Color.fromARGB(221, 83, 79, 79),
                  ),
              ),
              Text(profile?.parents_number?? '',
                style:  GoogleFonts.poppins(
                fontSize:  16,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                color: Colors.black,
                  ),
              ),
              SizedBox(height:14),
              Text("Address",
                style:  GoogleFonts.poppins(
                fontSize:  16,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                color: const Color.fromARGB(221, 83, 79, 79),
                  ),
              ),
              Text(profile?.address?? '',
                style:  GoogleFonts.poppins(
                fontSize:  16,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                color: Colors.black,
                  ),
              ),



 
                    ],)
                  ),
    


        ],
      ),
    )
  );

  }


    


  }


