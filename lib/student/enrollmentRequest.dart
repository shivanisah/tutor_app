import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tutor_app/utils/colors.dart';

import '../../providers/auth_provider.dart';
import '../models/user_models/teacher_data.dart';
import '../shared_preferences.dart/user_preferences.dart';
import 'addressmap.dart';


class StudentEnrollmentRequest extends StatefulWidget{

  @override
  State<StudentEnrollmentRequest> createState() => _StudentEnrollmentRequest();
}

class _StudentEnrollmentRequest extends State<StudentEnrollmentRequest> {

  final FocusNode dateFocusNode = FocusNode();

  TextEditingController sgenderController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String requestfor = "self";
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
      final userPreferences = UserPreferences();
    String user_type = '';

  int? studentId;
  bool isLoading = true;




@override
void dispose(){
  sgenderController.dispose();
  addressController.dispose();

  super.dispose();
}
double? latitude;
double? longitude;
void _onMapPage() async{
  final selectedLocation = await Navigator.push(context,
  MaterialPageRoute(builder: (context) => StudentAddressMapPage(),)
  );
  if(selectedLocation!=null){
    setState(() {
      addressController.text = selectedLocation['address'];
       latitude = selectedLocation['latitude'];
       longitude = selectedLocation['longitude'];
       print(latitude);
       print(longitude);
    });
  }
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
  final selectedClass = arguments['selectedClass'] as String?;
  final selectedSubjects = arguments['selectedSubject'];
  final selectedslotid = arguments['selectedslotid'];

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
      
                Text("Info", 
                // textAlign: TextAlign.right,
                style:  GoogleFonts.poppins(
      
                fontSize:  25,
                  fontWeight:  FontWeight.w500,
                  height:  1.5,
                color:  Color(0xff000000),
      
                )                
                ),
              SizedBox(height:6),
                Text("Please enter additional details ",style:  GoogleFonts.poppins(
      
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
              //                  Text(
              //    "Request for",
              //    style:  GoogleFonts.poppins(
      
              //   fontSize:  15,
              //       height:  1.5,
              //     color:  Colors.black,
      
              //     )
              // ),  
              // SizedBox(height:4),
              // Row(children: [
              //   Radio(
              //     groupValue: requestfor,
              //   value:"self",
                
              //   onChanged: (value){
              //     setState(() {
              //       requestfor = value.toString();
              //     });
              //   },
              
              //   ),
              //   Text("Self"),
              //   SizedBox(width:30),
              // Radio(
              //   groupValue: requestfor,
              //   value:"others",
              //   onChanged: (value){
              //     setState(() {
              //       requestfor = value.toString();
              //     });
              //   },
      
              //   ),
              //   Text("Others")
      
              // ],),
              //address
                        Text(
               "Address *",
               style:  GoogleFonts.poppins(

              fontSize:  15,
                  // fontWeight:  FontWeight.w600,
                  height:  1.5,
                color:  Colors.black,

                )
            ),           

            SizedBox(height:4),
                TextFormField(              
                controller:addressController,
                decoration:InputDecoration(             
                border:InputBorder.none,  
                hintText:"Address",
                hintStyle: TextStyle(color:Colors.black,fontWeight:FontWeight.w400 
                ),
                fillColor: Color.fromARGB(255, 234, 235, 236),
                filled: true,
                suffixIcon: Icon(Icons.place),
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
                 onTap:_onMapPage,   
                 ),


              //DatePicker
                  SizedBox(height: 16), 
                  Text("To Join Tuition *",
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
                // validator: (value) {
                //     if (value == null || value.isEmpty) {
                //      return 'This field is required';
                //     }
                //     return null;
                //   },  
                   ),
      
       
                      SizedBox(height:20),
                      GestureDetector(
                                    onTap: ()  {


                               if(_formkey.currentState!.validate()) {
                                  // print(addressController.text.toString());
                                  // if(userSelectedDate==null ){
                                  //     Flushbar(borderRadius: BorderRadius.circular(8),
                                  //     margin: EdgeInsets.all(12),
                                  //     duration: Duration(seconds:3),
                                  //     flushbarPosition: FlushbarPosition.TOP,
                                  //     backgroundColor: const Color.fromARGB(255, 140, 54, 48),
                                  //     message:"Please pick the date for Joining Tuition"
                                  //     ).show(context);
                                      
                                  //   }


                                      
                                        provider.studentEnrollmentrequest(
                                          context,
                                          requestfor,
                                          selectedClass.toString(),
                                          teacher.teaching_location?? ''.toString(),
                                          selectedSubjects,
                                          teacher.email,
                                          teacher.fullName,
                                          teacher.id,
                                          student_email!,
                                          userId!,
                                          finalselectedDate!,
                                          // selectedTimeSlot!,
                                          selectedStartTimeSlot?? '',
                                          selectedEndTimeSlot?? '',
                                          addressController.text.toString(),
                                          selectedslotid,
                                          
                                        
      
                                        );
                                    }
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
