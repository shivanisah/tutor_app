import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tutor_app/utils/colors.dart';

import '../../providers/auth_provider.dart';

class PasswordVerify extends StatefulWidget{

  @override
  State<PasswordVerify> createState() => _PasswordVerifyState();
}

class _PasswordVerifyState extends State<PasswordVerify> {

TextEditingController passwordcontroller = TextEditingController();
TextEditingController codecontroller = TextEditingController();
bool _isObscure = true;

@override
  void dispose(){
    passwordcontroller.dispose();
    codecontroller.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context,listen:false);

    double height = MediaQuery.of(context).size.height;
    double width =  MediaQuery.of(context).size.width;

    return Scaffold(
      body:Container(
        margin:EdgeInsets.all(20),
        height:height,
        width:width,
        child:Form(key: formkey,
        child:SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            SizedBox(height:height*0.09),
            Text(
              "Reset  Password",
                style:  GoogleFonts.poppins(
                fontSize:  30,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                color:  Color(0xff000000),
                  ),
            ),
            // SizedBox(height:10), 
            // Text("Please enter your email address to Reset password",
            // style:GoogleFonts.poppins(
            //   fontSize: 12,
            //   color:Colors.black,
            // ),
            // ),
                   SizedBox(height: 20),
                               Text(
                 'Code',
                 style:  GoogleFonts.poppins(
        
                fontSize:  15,
                    height:  1.5,
                  color:  Colors.black,
        
                  )
              ),           
                SizedBox(height:4),
            TextFormField(
              controller:codecontroller,
              decoration:InputDecoration(
                hintText:"Verify code",
                hintStyle:TextStyle(color:Colors.black,fontWeight:FontWeight.w400),
                  fillColor: Color.fromARGB(255, 234, 235, 236),
                filled:true,
                border:InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderRadius:BorderRadius.circular(6),
                  borderSide:BorderSide(color:Color.fromARGB(255, 234, 235, 236),)
                  ),
        
                  focusedBorder:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide:BorderSide(color:Palette.theme1),
                  ),
                  errorBorder:OutlineInputBorder(
                    borderRadius:BorderRadius.circular(6),
                    borderSide:BorderSide(color:Colors.red),
                  ),
                  focusedErrorBorder:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide:BorderSide(color:Colors.red)
                  )
              ),
              validator:(value){
                if(value == null || value.isEmpty){
                    return 'This field is required';
                }
                      return null;
              }
            ),
                 SizedBox(height: 15),
                Text(
                 'Password ',
                 style:  GoogleFonts.poppins(
                fontSize:  15,        
                height:  1.5,
                color:  Colors.black,
        
                  )
              ),   
              SizedBox(height:4) ,       
        
        
                TextFormField(    
                  obscureText:_isObscure,          
                  controller:passwordcontroller,
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
                  hintText:"New Password",
                  hintStyle: TextStyle(color:Colors.black,fontWeight:FontWeight.w400),
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
                      borderSide:BorderSide(color: Color.fromARGB(255, 234, 235, 236)), 
                    ),
                    focusedBorder:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide:BorderSide(color:Palette.theme)
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
        
            SizedBox(height:height*0.38),
            GestureDetector(
              onTap:(){
                if(formkey.currentState!.validate()){
                    provider.resetPasswordVerify(context, passwordcontroller.text.toString(), codecontroller.text);
        
                }
              },
              child:Container(
                height:50,
                width:350,
                margin:EdgeInsets.all(5),
                decoration:BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color:Palette.theme1
                ),
                child:Consumer<AuthProvider>(
                  builder:(context,provider,child){
                    if(provider.loading){
                      return Center(child: CircularProgressIndicator(color:Colors.white),);
                    }
                    else{
                      return  Center(child: Text("Done",style: TextStyle(color:Colors.white,fontSize:22),));
        
                    }
                  }
                )
                
              )
            )
          ],),
        )
        ),

      )

    );

  }

}
