
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tutor_app/models/user_models/studentmodel.dart';
import 'package:tutor_app/providers/student_provider.dart';
import 'package:tutor_app/student/updateaddressmap.dart';
import 'package:tutor_app/utils/colors.dart';

import '../../providers/auth_provider.dart';

class StudentProfileUpdate extends StatefulWidget{
  final Student profile;
  StudentProfileUpdate(this.profile,{super.key});

  @override
  State<StudentProfileUpdate> createState() => _StudentProfileUpdateState();
}

class _StudentProfileUpdateState extends State<StudentProfileUpdate> {

  TextEditingController pnameController=TextEditingController();
  TextEditingController pnumberController = TextEditingController();
  TextEditingController snameController = TextEditingController();
  TextEditingController snumberController = TextEditingController();
  TextEditingController sgenderController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  String gender = "Male";
  double? latitude;
  double? longitude;
  @override
  void initState(){
    pnameController.text = widget.profile.parents_name?? '';
    pnumberController.text = widget.profile.parents_number?? '';
    snameController.text = widget.profile.name?? '';
    snumberController.text = widget.profile.number?? '';
    sgenderController.text = widget.profile.gender?? '';
    addressController.text = widget.profile.address?? '';
    latitude = double.parse(widget.profile.latitude?? "0.0");
    longitude = double.parse(widget.profile.longitude?? "0.0");

    super.initState();

  }
  @override
  void dispose(){
    pnameController.dispose();
    pnumberController.dispose();
    snameController.dispose();
    snumberController.dispose();
    sgenderController.dispose();
    addressController.dispose();
    
    super.dispose();
  }
void _onMapPage() async{

  final initialLocation = {
    'latitude':latitude,
    'longitude':longitude
  };
  final selectedLocation = await Navigator.push(context,
  MaterialPageRoute(builder: (context) => StudentUpdateAddressMapPage(initialLocation),)
  );
  if(selectedLocation!=null){
    setState(() {
      addressController.text = selectedLocation['address'];
       latitude = selectedLocation['latitude'];
       longitude = selectedLocation['longitude'];
    });
  }
}


  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final studentprofileProvider = Provider.of<StudentProvider>(context);


    double height = MediaQuery.of(context).size.height;
    double width =  MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body:Container(
        margin:EdgeInsets.all(20),
        height:height,
        width:width,
        child:Form(key: formkey,
        child:SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            SizedBox(height:height*0.04),
            Text(
              "Update Your Personal Details",
                style:  GoogleFonts.poppins(
                fontSize:  20,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                color:  Color(0xff000000),
                  ),
            ),
          SizedBox(height:25),


                             Text(
               "Your Name",
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
                hintText:"Your Name",
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
               "Your Number",
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
                hintText:"Your Number",
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
                    else if(!RegExp(r'^\d{10}$').hasMatch(value)){
                              return "Please Enter a Valid 10-Digit Phone Number";
                    }else{
                      List<String> validStartingNumbers = ['98','97','96','95','94'];
                      String startingDigits = value.substring(0,2);
                      if(!validStartingNumbers.contains(startingDigits)){
                        return 'Enter valid number';
                      }
                    }
                    
                    return null;
                  },  
                    
                 ),
                SizedBox(height: 20),
                             Text(
               "Your Gender",
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
                      Text(
               "Address",
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
                suffix: Icon(Icons.place),
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
                 onTap:_onMapPage,   
                 ),
                SizedBox(height:20),
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
                    else if(!RegExp(r'^\d{10}$').hasMatch(value)){
                              return "Please Enter a Valid 10-Digit Phone Number";
                    }else{
                      List<String> validStartingNumbers = ['98','97','96','95','94'];
                      String startingDigits = value.substring(0,2);
                      if(!validStartingNumbers.contains(startingDigits)){
                        return 'Enter valid number';
                      }
                    }
                    
                    return null;
                  },  
                    
                 ),
                 SizedBox(height:20),

            GestureDetector(
              onTap:() async{

                if(formkey.currentState!.validate()){
                  studentprofileProvider.studentprofileUpdate(context,pnameController.text.toString(),pnumberController.text.toString(),
                  snameController.text.toString(),snumberController.text.toString(),sgenderController.text.toString(),
                  widget.profile.id!,latitude!,longitude!,addressController.text.toString()
                  );
        
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
               return Center(child: Text("Update",style: TextStyle(color:Colors.white,fontSize:16),));
        
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

