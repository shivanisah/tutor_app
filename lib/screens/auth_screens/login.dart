import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutor_app/FirstScreen/appBar.dart';

import '../../providers/auth_provider.dart';


class Login extends StatefulWidget{
  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {


  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isObscure = true;
  bool _isObscure2 = true;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();


@override
void dispose(){
  emailController.dispose();
  passwordController.dispose();
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
  final provider = Provider.of<AuthProvider>(context,listen: false);


double width = MediaQuery.of(context).size.width;
double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar:PreferredSize(
        preferredSize:const Size.fromHeight(60),
        child:AppB(),
      ),
      body:Container(  
      
        height:height,
        width:width,    
        margin:EdgeInsets.all(20),
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [            
              SizedBox(height:20),
              Center(
                child: Text("Login", 
                // textAlign: TextAlign.right,
                style:TextStyle(fontSize:20 )),
              ),
                 SizedBox(height: 20),
                     TextFormField(              
                controller:emailController,
                decoration:InputDecoration(             
                border:InputBorder.none,  
                labelText:"Email",
                labelStyle: TextStyle(color:Colors.black),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red,),
                  borderRadius:BorderRadius.circular(12),
                ),
                focusedErrorBorder: OutlineInputBorder
                (borderSide:BorderSide(color:Colors.red),
                borderRadius:BorderRadius.circular(12),
                ),
                enabledBorder:OutlineInputBorder(                 
                    borderRadius:BorderRadius.circular(12),
                    borderSide:BorderSide(color: Color.fromARGB(255, 0, 0, 0)), 
                  ),
                  focusedBorder:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:BorderSide(color:Colors.black)
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
                    SizedBox(height:20),
              TextFormField(    
                obscureText:_isObscure,          
                controller:passwordController,
                decoration:InputDecoration(   
                suffixIcon: IconButton(
                  icon:Icon(_isObscure?
                  Icons.visibility_off:Icons.visibility),
                  onPressed:(){
                    setState((){
                      _isObscure=!_isObscure2;
          
                    });
                  }
                  ),
          
                
                border:InputBorder.none,  
                labelText:"Password",
                labelStyle: TextStyle(color:Colors.black),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red,),
                  borderRadius:BorderRadius.circular(12),
                ),
                focusedErrorBorder: OutlineInputBorder
                (borderSide:BorderSide(color:Colors.red),
                borderRadius:BorderRadius.circular(12),
                ),
                enabledBorder:OutlineInputBorder(                 
                    borderRadius:BorderRadius.circular(12),
                    borderSide:BorderSide(color: Color.fromARGB(255, 0, 0, 0)), 
                  ),
                  focusedBorder:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:BorderSide(color:Colors.black)
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
                        Center(
                  child:      MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0))),
                                elevation: 5.0,
                                height: 40,
                                onPressed: () {
                                  if(_formkey.currentState!.validate()){
                                      provider.userLogin(context,emailController.text.toString(), passwordController.text.toString());
                                  }
                                   
                                },

                                child: provider.loading?CircularProgressIndicator():Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                color: Colors.white,
                              ),
                        ),

                    
            ],),
          ),
        ),
      )      
    );
  }

}
