import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tutor_app/utils/colors.dart';

import '../../providers/auth_provider.dart';

class ResetPassword extends StatefulWidget{

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

TextEditingController emailcontroller = TextEditingController();

@override
  void dispose(){
    emailcontroller.dispose();
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
              "Forgot  Password",
                style:  GoogleFonts.poppins(
                fontSize:  30,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                color:  Color(0xff000000),
                  ),
            ),
            SizedBox(height:10), 
            Text("Please enter your email address to Reset password",
            style:GoogleFonts.poppins(
              fontSize: 12,
              color:Colors.black,
            ),
            ),
          SizedBox(height:30),
            TextFormField(
              controller:emailcontroller,
              decoration:InputDecoration(
                hintText:"Email",
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
                else if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
                     return ("Please enter a valid email");
                      }               
                      return null;
              }
            ),
            SizedBox(height:height*0.5),
            GestureDetector(
              onTap:(){
                if(formkey.currentState!.validate()){
                  provider.forgotPassword(context,emailcontroller.text.toString());
        
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
                    return  Center(child: CircularProgressIndicator(color:Colors.white),);
                    }
                    else{
               return Center(child: Text("Reset Password",style: TextStyle(color:Colors.white,fontSize:16),));
        
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
