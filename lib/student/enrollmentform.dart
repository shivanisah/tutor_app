import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tutor_app/models/user_models/studentmodel.dart';
import 'package:tutor_app/utils/colors.dart';

import '../../providers/auth_provider.dart';
import '../models/user_models/teacher_data.dart';
import '../shared_preferences.dart/user_preferences.dart';


class StudentEnrollDataForm extends StatefulWidget{
    final Student profile;
  StudentEnrollDataForm(this.profile,{super.key});

  @override
  State<StudentEnrollDataForm> createState() => _StudentEnrollDataForm();
}

class _StudentEnrollDataForm extends State<StudentEnrollDataForm> {

  final FocusNode dateFocusNode = FocusNode();
// late Student profile;

  TextEditingController pnameController=TextEditingController();
  TextEditingController pnumberController = TextEditingController();
  TextEditingController snameController = TextEditingController();
  TextEditingController snumberController = TextEditingController();
  TextEditingController sgenderController = TextEditingController();
  String gender = "Male";
  DateTime currentDate = DateTime.now();
  String? finalselectedDate;
  DateTime? userSelectedDate;

    datePicker(context) async{

      final currentFocus = FocusScope.of(context);
      currentFocus.unfocus();
       userSelectedDate = await 
      showDatePicker(context: context, 
      initialDate: currentDate, 
      firstDate: DateTime.now(),
      lastDate: DateTime(2025)
      );

      currentFocus.requestFocus(dateFocusNode);
      if(userSelectedDate == null){
        return;

      }
      else{
        setState(() {
          currentDate = userSelectedDate!;
          finalselectedDate = 
          "${currentDate.year}-${currentDate.month}-${currentDate.day}";
          // print("Date...............................................................................");
          print(finalselectedDate);
          // onSelect(userSelectedDate);
        });
      }
    }


  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  double? latitude;
  double? longitude;

  @override
  void initState(){
    pnameController.text = widget.profile.parents_name!;
    pnumberController.text = widget.profile.parents_number!;
    snameController.text = widget.profile.name!;
    snumberController.text = widget.profile.number!;
    gender = widget.profile.gender!;
    
    super.initState();

  }
  final userPreferences = UserPreferences();
  String user_type = '';

  int? studentId;
  bool isLoading = true;
  // @override 
  // void initState(){
  //   super.initState();
  //   fetchData();
    
  // }
  //   @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   fetchData();
  //   // profile = ModalRoute.of(context)!.settings.arguments as Student;
  // }


//   Future<void>  fetchData()async{
//     try{
//     final studentProfileProvider = Provider.of<StudentProvider>(context);
//           final student = await userPreferences.getUser();
//     if (student != null) {
//       setState(() {
//         studentId = student.id!;
//       });
//       } else {
//       setState(() {
//         studentId = null;
//       });
//     }
//     await studentProfileProvider.fetchStudentProfile(studentId!);
// Student? studentProfile = studentProfileProvider.studentProfile;
// print("Student Profile Data: $studentProfile");

//       pnameController.text = studentProfile?.parents_name ?? '';
//       pnumberController.text = studentProfile?.parents_number ?? '';
//       snameController.text = studentProfile?.name ?? '';
//       snumberController.text = studentProfile?.number ?? '';
//       gender = studentProfile?.gender ?? '';


//     }catch(error){

//     }finally{
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }


@override
void dispose(){
  pnameController.dispose();
  pnumberController.dispose();
  snameController.dispose();
  snumberController.dispose();
  sgenderController.dispose();

  super.dispose();
}
  @override
  Widget build(BuildContext context) {
  final userPreferences = UserPreferences();
    int? userId;
    String? student_email;

    // Retrieve the id value from UserPreferences
    userPreferences.getUser().then((teacher) {
      // ignore: unnecessary_null_comparison
      if (teacher != null) {
        setState(() {
          userId = teacher.id;
          student_email = teacher.email;
        });
      }
    });  

  final arguments = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
  final teacher = arguments['teacher'] as TeacherData;
  final selectedStartTimeSlot = arguments['selectedstartTimeSlot'] as String?;
  final selectedEndTimeSlot = arguments['selectedendTimeSlot'] as String?;
  final provider = Provider.of<AuthProvider>(context,listen: false);


double width = MediaQuery.of(context).size.width;
double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar:AppBar(),
      // appBar:PreferredSize(
      //   preferredSize:const Size.fromHeight(60),
      //   child:AppB(),
      // ),
      body:
//       FutureBuilder<void>(
//         future:fetchData(),
//         builder: (context, snapshot) {
//           if(snapshot.connectionState == ConnectionState.waiting){
//             return Center(child:CircularProgressIndicator());
//           }else if(snapshot.hasError){
//             return Text('Error: ${snapshot.error}');
//           }else{
//             final studentProfileProvider = Provider.of<StudentProvider>(context);
//             Student? studentProfile = studentProfileProvider.studentProfile;
//           pnameController.text = studentProfile?.parents_name?? '';
//     pnumberController.text = studentProfile?.parents_number?? '';
//     snameController.text = studentProfile?.name?? '';
//     snumberController.text = studentProfile?.number?? '';
//     gender = studentProfile?.gender?? '';
// return 

//           }
//         }),

      Container(  
        
          height:height,
          width:width,    
          margin:EdgeInsets.all(20),
          child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [            
                SizedBox(height:40),
      
                Text("Personal Info", 
                // textAlign: TextAlign.right,
                style:  GoogleFonts.poppins(
      
                fontSize:  25,
                  fontWeight:  FontWeight.w500,
                  height:  1.5,
                color:  Color(0xff000000),
      
                )                
                ),
              SizedBox(height:6),
                Text("Please enter your personal details ",style:  GoogleFonts.poppins(
      
                fontSize:  12,
                    // fontWeight:  FontWeight.w600,
                    height:  1.5,
                  color:  Color(0xff000000),
      
                  )),
                // Text("we can know you better.",style:  GoogleFonts.poppins(
      
                // fontSize:  12,
                //     // fontWeight:  FontWeight.w600,
                //     height:  1.5,
                //   color:  Color(0xff000000),
      
                //   )),         
      
      
                   SizedBox(height: 20),
                               Text(
                 'Parents Name',
                 style:  GoogleFonts.poppins(
      
                fontSize:  15,
                    // fontWeight:  FontWeight.w600,
                    height:  1.5,
                  color:  Colors.black,
      
                  )
              ),           
                SizedBox(height:4),
                       TextFormField(              
                  controller:pnameController,
                  decoration:InputDecoration(             
                  border:InputBorder.none,  
                  hintText:"Parent's Name",
                  hintStyle: TextStyle(color:Colors.black,fontWeight:FontWeight.w400 
                  ),
                  fillColor: Color.fromARGB(255, 234, 235, 236),
                  filled: true,
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
               
                  validator: (value) {
                      if (value == null || value.isEmpty) {
                       return 'This field is required';
                      }
                      return null;
                    },  
                      
                   ),
      
                                    SizedBox(height: 20),
                               Text(
                 'Parents Number',
                 style:  GoogleFonts.poppins(
      
                fontSize:  15,
                    // fontWeight:  FontWeight.w600,
                    height:  1.5,
                  color:  Colors.black,
      
                  )
              ),           
                SizedBox(height:4),
                       TextFormField(  
                        keyboardType: TextInputType.number,            
                  controller:pnumberController,
                  decoration:InputDecoration(             
                  border:InputBorder.none,  
                  hintText:"Parent's Number",
                  hintStyle: TextStyle(color:Colors.black,fontWeight:FontWeight.w400 
                  ),
                  fillColor: Color.fromARGB(255, 234, 235, 236),
                  filled: true,
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
               
                  validator: (value) {
                      if (value == null || value.isEmpty) {
                       return 'This field is required';
                      }
                      else if(!RegExp(r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$').hasMatch(value)){
                                return "Please Enter a Valid Phone Number";
                      }
                      else 
                      return null;
                    },  
                      
                   ),
                   SizedBox(height: 20),
                               Text(
                 "Student's Name",
                 style:  GoogleFonts.poppins(
      
                fontSize:  15,
                    // fontWeight:  FontWeight.w600,
                    height:  1.5,
                  color:  Colors.black,
      
                  )
              ),           
                SizedBox(height:4),
                       TextFormField(              
                  controller:snameController,
                  decoration:InputDecoration(             
                  border:InputBorder.none,  
                  hintText:"Student's Name",
                  hintStyle: TextStyle(color:Colors.black,fontWeight:FontWeight.w400 
                  ),
                  fillColor: Color.fromARGB(255, 234, 235, 236),
                  filled: true,
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
               
                  validator: (value) {
                      if (value == null || value.isEmpty) {
                       return 'This field is required';
                      }
                      return null;
                    },  
                      
                   ),
                   SizedBox(height: 20),
                               Text(
                 "Student's Number",
                 style:  GoogleFonts.poppins(
      
                fontSize:  15,
                    // fontWeight:  FontWeight.w600,
                    height:  1.5,
                  color:  Colors.black,
      
                  )
              ),           
                SizedBox(height:4),
                       TextFormField(   
                        keyboardType: TextInputType.number,           
                  controller:snumberController,
                  decoration:InputDecoration(             
                  border:InputBorder.none,  
                  hintText:"Student's Number",
                  hintStyle: TextStyle(color:Colors.black,fontWeight:FontWeight.w400 
                  ),
                  fillColor: Color.fromARGB(255, 234, 235, 236),
                  filled: true,
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
               
                  validator: (value) {
                      if (value == null || value.isEmpty) {
                       return 'This field is required';
                      }
                      else if(!RegExp(r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$').hasMatch(value)){
                                return "Please Enter a Valid Phone Number";
                      }
                      else 
                      return null;
                    },  
                      
                   ),
                  SizedBox(height: 20),
                               Text(
                 "Student's Gender",
                 style:  GoogleFonts.poppins(
      
                fontSize:  15,
                    height:  1.5,
                  color:  Colors.black,
      
                  )
              ),  
              SizedBox(height:4),
              Row(children: [
                Radio(
                  groupValue: gender,
                value:"Male",
                
                onChanged: (value){
                  setState(() {
                    gender = value.toString();
                  });
                },
              
                ),
                Text("Male"),
                SizedBox(width:30),
              Radio(
                groupValue: gender,
                value:"Female",
                onChanged: (value){
                  setState(() {
                    gender = value.toString();
                  });
                },
      
                ),
                Text("Female")
      
              ],),
              //Address

              //DatePicker
                  SizedBox(height: 16), 
                  Text("To Join Tuition",
                  style:  GoogleFonts.poppins(
      
                  fontSize:  15,
                  height:  1.5,
                  color:  Colors.black,
      
                  )
                  ),
                  SizedBox(height:5),
                  TextFormField(  
                  readOnly: true,
                  onTap:(){
                   datePicker(context);
                  } ,
                  decoration:InputDecoration(             
                  border:InputBorder.none,  
                  hintText:userSelectedDate!= null? finalselectedDate:
                  // "${currentDate.year}-${currentDate.month}-${currentDate.day}":
                  
                  "Pick Date",
                  hintStyle: TextStyle(color:Colors.black),
                  fillColor: Palette.fillcolor,
                  filled: true,
                  suffixIcon: IconButton(icon: Icon(Icons.calendar_month),onPressed:(){datePicker(context);}),
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
      
       
              SizedBox(height:20),
                      GestureDetector(
                                        onTap: ()  {
                                    // if (_formkey.currentState!.validate()) {
                                    //    // Set the loading state to true
      
                                      
                                    //     provider.studentEnrollment(
                                    //       context,
                                    //       pnameController.text.toString(),
                                    //       pnumberController.text.toString(),
                                    //       snameController.text.toString(),
                                    //       snumberController.text.toString(),
                                    //       gender,
                                    //       teacher.grade.toString(),
                                    //       teacher.teaching_location?? ''.toString(),
                                    //       teacher.subjects!,
                                    //       teacher.email,
                                    //       teacher.fullName,
                                    //       teacher.id,
                                    //       student_email!,
                                    //       userId!,
                                    //       finalselectedDate!,
                                    //       // selectedTimeSlot!,
                                    //       selectedStartTimeSlot?? '',
                                    //       selectedEndTimeSlot?? '',
                                        
      
                                    //     );
                                    // }
                                      },
                                        child: Container(
                                          height:50,
                                          width:350,
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(6),
                                          // border: Border.all(width: 0.7,color: Colors.black),
                                            color: Palette.theme1
                                          ),
                                          child:
                                  Consumer<AuthProvider>(
                                                builder: (context, provider,child) {
                                                  if (provider.loading) {
                                                    return Center(child: CircularProgressIndicator(color: Colors.white));
                                                  } else {
                                                    return Center(child: Text('Proceed', style: TextStyle(color: Colors.white, fontSize: 16)));
                                                  }
                                                },
                                              ),                                      ),
                                      ),
                      
              ],),
            ),
          ),
        ),
      );      
    
  }

}
