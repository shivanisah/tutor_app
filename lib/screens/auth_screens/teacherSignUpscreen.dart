import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tutor_app/FirstScreen/appBar.dart';

import '../../providers/auth_provider.dart';


class TutorRegistration extends StatefulWidget{
  @override
  State<TutorRegistration> createState() => _TutorRegistrationState();
}

class _TutorRegistrationState extends State<TutorRegistration> {
  final List<String> items = [
 'Science','Maths','Nepali','English','Java','Python','C++','DotNet','Dart',
 'science','maths','nepali','english','java','python','c++','dotNet','dart'
];
final Map<String, List<String>> gradeSubjectMap = {
    "Grade 1": ["Math", "English", "Science"],
    "Grade 2": ["Math", "English", "Social Studies"],
    "Grade 3": ["Math", "English", "Science", "Social Studies"],
  };
  String selectedGrade = "Grade 1"; // default selection
  List<String> availableSubjects = []; // to be populated dynamically based on selected grade
  List<String> selectedSubjects = []; // to store selected subjects

List<String> selectedItems = [];


  TextEditingController name=TextEditingController();
  TextEditingController number=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController address=TextEditingController(); 
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController =TextEditingController();
  bool _isObscure = true;
  bool _isObscure2 = true;

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
    availableSubjects = gradeSubjectMap[selectedGrade]!;
  }
  @override
  Widget build(BuildContext context) {
  final provider = Provider.of<AuthProvider>(context,listen: false);

final color = Colors.blue;
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
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [            
              SizedBox(height:20),
              Center(
                child: Text("Register as a Tutor", 
                // textAlign: TextAlign.right,
                style:TextStyle(fontSize:20 )),
              ),
              SizedBox(height:10),

              //image ........................................................

                          Center(
                            child: Stack(
                                                children: [
                                                  // buildImage(),
                                                  ClipOval(
                        child:    SizedBox(
                           width:128,
                                                    height:128,
                          child: AspectRatio(
                                      aspectRatio: 1.0,
                              child:_image!=null?Image.file(_image,fit:BoxFit.cover,
                                                    width:128,
                                                    height:128,
                                                    alignment: Alignment.topCenter,
                                                    ) :
                              
                            
                                                    Image.asset('assets/images/d1.jpg',                                     
                                                     fit:BoxFit.cover,
                                                    width:128,
                                                    height:128,
                                                    alignment: Alignment.topCenter,
                                                  ),
                                                ),
                                           ),
                                                  ),
                                                  Positioned(
                            bottom:0,
                            right:4,
                            child: buildEditIcon(color)
                            ),
                                                  ]
                                                  ),
                          ),
              SizedBox(height: 20,),
              TextFormField(              
                controller:name,
                decoration:InputDecoration(             
                border:InputBorder.none,  
                labelText:"Enter your full name",
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
                    }
                    return null;
                  },  
                 ),
                 SizedBox(height: 20),
                     TextFormField(              
                controller:email,
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
              
               SizedBox(height: 20),
               TextFormField( 
                keyboardType:TextInputType.number,             
                controller:number,
                decoration:InputDecoration( 
                  alignLabelWithHint: true,            
                border:InputBorder.none,  
                hintText:"Phone number",
                hintStyle: TextStyle(color:Colors.black),
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
                    }
                    else if(!RegExp(r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$').hasMatch(value)){
                              return "Please Enter a Valid Phone Number";
                    }
                    else 
                    return null;
                  },  
                 ),
                
                  SizedBox(height: 20), 
                                TextFormField(              
                controller:address,
                decoration:InputDecoration(             
                border:InputBorder.none,  
                hintText:"Enter your address",
                hintStyle: TextStyle(color:Colors.black),
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
                    }
                    return null;
                  },  
                 ),
               
          
            SizedBox(height: 20),      
            
              
                    Container(
            height:60,
            // color:Color.fromRGBO(0, 0, 0, 1),
            child: InputDecorator(
              decoration:InputDecoration(border:OutlineInputBorder(
                
                borderRadius: BorderRadius.circular(12),
                    borderSide:BorderSide(color:Color.fromARGB(255, 29, 28, 28)), 
              )
              
              
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton( 
                   
                  isExpanded: true,
                  hint: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'Select Subjects',
                      style: TextStyle(
                        color:Colors.black,
                        fontSize: 16,
                        // color: Theme.of(context).hintColor,
                      ),
                    ),
                  ),
                  items: items.map((item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      //disable default onTap to avoid closing menu when selecting an item
                      enabled: false,
                      child: StatefulBuilder(
                        builder: (context, menuSetState) {
                          final _isSelected = selectedItems.contains(item);
                          return InkWell(
                            onTap: () {
                              _isSelected
                                      ? selectedItems.remove(item)
                                      : selectedItems.add(item);
                              //This rebuilds the StatefulWidget to update the button's text
                              setState(() {});
                              //This rebuilds the dropdownMenu Widget to update the check mark
                              menuSetState(() {});
                            },
                            child: Container(
                              height: double.infinity,
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                children: [
                                  _isSelected
                                          ? const Icon(Icons.check_box_outlined)
                                          : const Icon(Icons.check_box_outline_blank),
                                  const SizedBox(width: 16),
                                  Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }).toList(),
                  //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                  value: selectedItems.isEmpty ? null : selectedItems.last,
                  onChanged: (value) {},
                  selectedItemBuilder: (context) {
                    return items.map(
                              (item) {
                        return Container(
                          alignment: AlignmentDirectional.center,
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            selectedItems.join(', '),
                            style: const TextStyle(
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 1,
                          ),
                        );
                      },
                    ).toList();
                    
                  },
                  // buttonStyleData: const ButtonStyleData(
                  //   height: 40,
                  //   width: 140,
                  // ),
                  // menuItemStyleData: const MenuItemStyleData(
                  //   height: 40,
                  //   padding: EdgeInsets.zero,
                  // ),
                ),
                
              ),
            ),
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
                hintText:"Password",
                hintStyle: TextStyle(color:Colors.black),
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
              TextFormField(    
                obscureText:_isObscure2,          
                controller:confirmpasswordController,
                decoration:InputDecoration(   
                suffixIcon: IconButton(
                  icon:Icon(_isObscure?
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
                              if (confirmpasswordController.text !=
                                  passwordController.text) {
                                return "Password did not match";
                              } else {
                                return null;
                              }
                            },
            
                 ),
//Grades and Subjects ............................................................................................
Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Grade",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: selectedGrade,
              items: gradeSubjectMap.keys
                  .map<DropdownMenuItem<String>>((String grade) {
                return DropdownMenuItem<String>(
                  value: grade,
                  child: Text(grade),
                );
              }).toList(),
              onChanged: (String? grade) {
                setState(() {
                  selectedGrade = grade!;
                  availableSubjects = gradeSubjectMap[selectedGrade]!;
                  selectedSubjects.clear(); // clear previously selected subjects
                });
              },
            ),
            SizedBox(height: 16.0),
            Text(
              "Select Subjects",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Wrap(
              children: availableSubjects
                  .map<Widget>((String subject) => CheckboxListTile(
                        title: Text(subject),
                        value: selectedSubjects.contains(subject),
                        onChanged: (bool? selected) {
                          setState(() {
                            if (selected!) {
                              selectedSubjects.add(subject);
                            } else {
                              selectedSubjects.remove(subject);
                            }
                          });
                        },
                      ))
                  .toList(),
            ),
            // SizedBox(height: 16.0),
            // ElevatedButton(
            //   onPressed: () {
            //     // Handle submit button click
            //     print("Selected Grade: $selectedGrade");
            //     print("Selected Subjects: $selectedSubjects");
            //   },
            //   child: Text("Submit"),
            // ),
          ],
        ),
      






          SizedBox(height:20),
                        Center(
                          child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20.0))),
                                  // elevation: 5.0,
                                  height: 40,
                                  onPressed: (){
                                  try{
                            if(_image!=null){
                                imageFile =  File(_image.path);

                        }  
                        // else{
                        //    imgUrl = "";


                        // }
                                      if(_formKey.currentState!.validate()){
                                       provider.userSignup(context,name.text.toString(),number.text.toString(),email.text.toString(),address.text.toString(), 
                                       passwordController.text.toString(), confirmpasswordController.text.toString(),imageFile,
                                       selectedGrade,selectedSubjects
                                       );
                        
                                    }
                                    }catch (e){
                                           SnackBar( content: Text(e.toString()), ) ;   }

                                  },        
                                      
                                  child: provider.signUpLoading?CircularProgressIndicator():Text(
                                    "Register",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  color:Color.fromARGB(255, 58, 93, 153),
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