import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tutor_app/FirstScreen/appBar.dart';
import 'package:tutor_app/screens/auth_screens/login.dart';
import 'package:tutor_app/utils/colors.dart';

import '../../Apis/fetchClassSubject.dart';
import '../../models/user_models/searchmodel.dart';
import '../../providers/auth_provider.dart';


class TutorRegistration extends StatefulWidget{
  @override
  State<TutorRegistration> createState() => _TutorRegistrationState();
}

class _TutorRegistrationState extends State<TutorRegistration> {


  List<ClassSubject> _classSubjects = [];
  ClassSubject? _selectedClassSubject;
  List<String> _selectedSubjects = [];


  TextEditingController name=TextEditingController();
  TextEditingController number=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController address=TextEditingController(); 
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController =TextEditingController();
  bool _isObscure = true;
  bool _isObscure2 = true;
  bool _isChecked = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

bool loading = false;
File? imageFile;
  var _image;
  final picker = ImagePicker();
  Future _pickImageCamera() async {
  loading=true;
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _image = pickedImageFile;
      loading=false;
    });   
  }
@override
void dispose(){
  name.dispose();
  number.dispose();
  email.dispose();
  address.dispose();
  passwordController.dispose();
  confirmpasswordController.dispose();
  super.dispose();
}
  @override
  void initState() {
    super.initState();
    fetchClassSubjects().then((classSubjects) {
      setState(() {
        _classSubjects = classSubjects;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
  final provider = Provider.of<AuthProvider>(context,listen: false);

final color = Colors.blue;
double width = MediaQuery.of(context).size.width;
double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar:AppBar(),
      // appBar:PreferredSize(
      //   preferredSize:const Size.fromHeight(60),
      //   child:AppB(),
      // ),
      body:Container(  
      
        height:height,
        width:width,    
        margin:EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [            
              SizedBox(height:20),
              Text("Sign up", 
              // textAlign: TextAlign.right,
              style:TextStyle(fontSize:25 )),
              SizedBox(height:10),

              //image ........................................................

                        //   Center(
                        //     child: Stack(
                        //                         children: [
                        //                           // buildImage(),
                        //                           ClipOval(
                        // child:    SizedBox(
                        //    width:128,
                        //                             height:128,
                        //   child: AspectRatio(
                        //               aspectRatio: 1.0,
                        //       child:_image!=null?Image.file(_image,fit:BoxFit.cover,
                        //                             width:128,
                        //                             height:128,
                        //                             alignment: Alignment.topCenter,
                        //                             ) :
                              
                            
                        //                             Image.asset('assets/images/d1.jpg',                                     
                        //                              fit:BoxFit.cover,
                        //                             width:128,
                        //                             height:128,
                        //                             alignment: Alignment.topCenter,
                        //                           ),
                        //                         ),
                        //                    ),
                        //                           ),
                        //                           Positioned(
                        //     bottom:0,
                        //     right:4,
                        //     child: buildEditIcon(color)
                        //     ),
                        //                           ]
                        //                           ),
                        //   ),
              SizedBox(height:6),
              Text("Please enter your personal information so "),
              Text("we can know you better."),         
              SizedBox(height: 20,),
              Text("Your Name *"),
              SizedBox(height:5),
              TextFormField(              
                controller:name,
                decoration:InputDecoration(             
                border:InputBorder.none,  
                hintText:"Full Name",
                hintStyle: TextStyle(color:Colors.black),
                fillColor:Color.fromARGB(255, 234, 235, 236),
                filled:true,
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
                    borderSide:BorderSide(color: Color.fromARGB(255, 234, 235, 236)), 
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
                 Text("Email Address*"),
                 SizedBox(height:5),
                     TextFormField(              
                controller:email,
                decoration:InputDecoration(             
                border:InputBorder.none,  
                hintText:"Email",
                hintStyle: TextStyle(color:Colors.black),
                fillColor: Palette.fillcolor,
                filled:true,
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
                    }else if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
            return ("Please enter a valid email");
                    }
          
                    
                    return null;
                  },  
                 ),
              
               SizedBox(height: 20),
               Text("Your Number *"),
               SizedBox(height:5),
               TextFormField( 
                keyboardType:TextInputType.number,             
                controller:number,
                decoration:InputDecoration( 
                  alignLabelWithHint: true,            
                border:InputBorder.none,  
                hintText:"Phone number",
                hintStyle: TextStyle(color:Colors.black),
                fillColor: Palette.fillcolor,
                filled:true,
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
                  Text("Education Certificate *"),
                  SizedBox(height:5),
                                TextFormField(              
                controller:address,
                decoration:InputDecoration(             
                border:InputBorder.none,  
                hintText:"Upload Certificate",
                hintStyle: TextStyle(color:Colors.black),
                fillColor: Palette.fillcolor,
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
             
                // validator: (value) {
                //     if (value == null || value.isEmpty) {
                //      return 'This field is required';
                //     }
                //     return null;
                //   },  
                 ),
                //  SizedBox(height:20),
                //  Text("Grade and Subjects *"),
                //  SizedBox(height:5),
   //...........................class and subjects............................................//
        //    Column(
          
                
        //   children: [
        //     Container(
        //       width:350,
        //       height:50,
        //       // margin: EdgeInsets.only(top:10),
        //       decoration: 
        //       BoxDecoration(
        //       color: Palette.fillcolor,
        //       borderRadius: BorderRadius.circular(6),
        //       border: Border.all(color:Palette.fillcolor),
        //                       //             boxShadow:[
        //                       //   BoxShadow(
        //                       //     color: Colors.grey,
    
        //                       //     blurRadius:5,
        //                       //     offset:Offset(0,0.5),
        //                       //   ),
        //                       //   BoxShadow(
        //                       //     color:Colors.white,
        //                       //     offset:Offset(-0.5,0),
        //                       //   ),
        //                       // ]
    
        //        ),
        //       child: Align(
        //         alignment: AlignmentDirectional.center,
        //         child: DropdownButton<ClassSubject>(
        //           value: _selectedClassSubject,
        //           hint: Text('Select class',style:TextStyle(color:Colors.black)),
        //           onChanged: (ClassSubject? newValue) {
        //             setState(() {
        //               _selectedClassSubject = newValue;
        //               _selectedSubjects.clear();
        //             });
        //           },
                  
        //           items: _classSubjects.map<DropdownMenuItem<ClassSubject>>((ClassSubject classSubject) {
        //             return DropdownMenuItem<ClassSubject>(
        //               value: classSubject,
        //               child: Text(classSubject.className),
        //             );
        //           }).toList(),
        //           style: TextStyle(color: Colors.black, fontSize: 19),
        //           icon: Icon(Icons.arrow_drop_down,size: 30,),
        //           underline: SizedBox(),      
        //         ),
        //       ),
        //     ),
        //     SizedBox(height: 4),
        //     if (_selectedClassSubject != null)
        //       Column(
        //         children: _selectedClassSubject!.subjects.map<Widget>((subject) {
        //           return ListTile(
        //             title: Text(subject),
        //             leading: Theme(
        //               data: ThemeData(
        //             // unselectedWidgetColor: Colors.grey, // Color when checkbox is not selected
        //             checkboxTheme: CheckboxThemeData(
        //               fillColor: MaterialStateProperty.all<Color>(Palette.theme1), // Color when checkbox is selected
        //              ),
        //                 ),
        //               child: Checkbox(
        //                 value: _selectedSubjects.contains(subject),
        //                 onChanged: (bool? value) {
        //                   setState(() {
        //                     if (value == true) {
        //                       _selectedSubjects.add(subject);
        //                     } else {
        //                       _selectedSubjects.remove(subject);
        //                     }
        //                   });
        //                 },
        //               ),
        //             ),
        //           );
        //         }).toList(),
        //       ),
        //   ]
        // ),
              
              
                    SizedBox(height:20),
                    Text("Password"),
                    SizedBox(height:5),
              TextFormField(    
                obscureText:_isObscure,          
                controller:passwordController,
                decoration:InputDecoration(   
                suffixIcon: IconButton(
                  icon:Icon(_isObscure?
                  Icons.visibility_off:Icons.visibility),
                  onPressed:(){
                    setState((){
                      _isObscure=!_isObscure;
          
                    });
                  }
                  ),
          
                
                border:InputBorder.none,  
                hintText:"Password",
                hintStyle: TextStyle(color:Colors.black),
                fillColor: Palette.fillcolor,
                filled:true,
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
                              RegExp regex = new RegExp(r'^.{6,}$');
                              if (value!.isEmpty) {
                                return "Password cannot be empty";
                              }
                              if (!regex.hasMatch(value)) {
                                return ("please enter valid password min. 6 character");
                              } else {
                                return null;
                              }
                            },
            
                 ),
          
                 SizedBox(height:20),
                 Text("Confirm Password"),
                 SizedBox(height:5),
                 TextFormField(    
                 obscureText:_isObscure2,          
                 controller:confirmpasswordController,
                decoration:InputDecoration(   
                suffixIcon: IconButton(
                  icon:Icon(_isObscure2?
                  Icons.visibility_off:Icons.visibility),
                  onPressed:(){
                    setState((){
                      _isObscure2=!_isObscure2;
          
                    });
                  }
                  ),
          
                
                border:InputBorder.none,  
                hintText:"Confirm Password",
                hintStyle: TextStyle(color:Colors.black),
                fillColor: Palette.fillcolor,
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
                              if (confirmpasswordController.text !=
                                  passwordController.text) {
                                return "Password did not match";
                              } else {
                                return null;
                              }
                            },
            
                 ),
      
//.......................................................................

                  SizedBox(height:30),
                  Row(children: [
                  Container(
                    height:20,
                    width:20,
                    child: Checkbox(value: _isChecked, onChanged: (value){
                      setState(() {
                        _isChecked = value! ;
                      });
                    }),
                  ),
                  // Container(height:20,width:20,color:Palette.theme1),
                  SizedBox(width:10),
                    Column(children: [
                  Text("By tapping continue, you accept the"),
                  Text("Terms of service and privacy policy of"),
                  Text("Tutor App"),

                    ],)
                  ],),

                       SizedBox(height:30),
                        Container(
                          width:350,
                          child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6))),
                                  // elevation: 5.0,
                                  
                                  height: 50,
                                  onPressed: (){
                                  try{
                            if(_image!=null){
                                imageFile =  File(_image.path);
                        
                          }  

                                      if(_formKey.currentState!.validate()){
                                       provider.teacherSignup(context,name.text.toString(),number.text.toString(),email.text.toString(), 
                                       passwordController.text.toString(), confirmpasswordController.text.toString(),imageFile,
                                      //  _selectedClassSubject?.className??'',_selectedSubjects
                                       );
                          
                                    }

                                    }catch (e){
                                           SnackBar( content: Text(e.toString()), ) ;}
                        
                                  },        
                                      
                                  child: provider.signUpLoading?Visibility(
                                    maintainSize: true,
                                    maintainAnimation: true,
                                    maintainState: true,
                                    visible:true,
                                    
                                    child: CircularProgressIndicator(color: Colors.white,)):
                                  Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color:Colors.white,
                                    ),
                                  ),
                                  color:Palette.theme1,
                                ),
                        ),
              SizedBox(height:20),
                               Center(
                   child: RichText(
                     text: TextSpan(
                         style: TextStyle(color: Colors.black),
                         children: <TextSpan>[
                           TextSpan(text: "Already have an account? ",
                           style:GoogleFonts.poppins(

                          fontSize:  15,
                          fontWeight:  FontWeight.w400,
                          // height:  1.5,
                          color:  Color.fromARGB(255, 134, 148, 162),

                          )
                           ),
                           TextSpan(text: 'Log In',
                           recognizer:TapGestureRecognizer()..onTap = () =>
                           Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>Login(),)),
                           style:GoogleFonts.poppins(

                          fontSize:  15,
                          fontWeight:  FontWeight.w600,
                          // height:  1.5,
                          color:  Palette.theme1,

                )
                            ),
                         ],
                     ),
                   ),
                 ),

                    
            ],),
          ),
        ),
      )      
    );
  }


  Widget buildEditIcon(Color color)=>
      buildCircle(
        color:Colors.white,
        all:3,
        child: InkWell(
          onTap:()=>{
             _pickImageCamera(),
          },
          child: buildCircle(
            color:color,
            all:8,
            child: Icon(
              Icons.add_a_photo,
        
              size:20,
              color:Colors.white,
            
            ),
                      
        
          ),
        ),
      );


 Widget buildCircle({
  required Widget child,
  required double all,
  required Color color,
 })=>ClipOval(
   child: Container(
    color:color,
    child:child,
    padding:EdgeInsets.all(all),
    
    ),
 );     
}