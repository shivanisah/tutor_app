import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tutor_app/utils/colors.dart';

import '../../app_urls/app_urls.dart';
import '../../models/user_models/teacher_data.dart';
import '../../providers/auth_provider.dart';
import '../../providers/teacherProfileprovider.dart';

class TeacherProfileUpdate extends StatefulWidget{
  final TeacherData profile;
  TeacherProfileUpdate(this.profile,{super.key});

  @override
  State<TeacherProfileUpdate> createState() => _TeacherProfileUpdateState();
}

class _TeacherProfileUpdateState extends State<TeacherProfileUpdate> {

TextEditingController phonecontroller = TextEditingController();
File? imageFile;
bool loading = false;
LatLng? _selectedLatLng;

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
  void initState(){
    phonecontroller.text = widget.profile.phoneNumber;
    super.initState();
    print('Image URL: ${widget.profile.image}');

  }
  @override
  void dispose(){
    phonecontroller.dispose();
    super.dispose();
  }


  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TeacherData profile = ModalRoute.of(context)!.settings.arguments as TeacherData;
    final teacherprofileProvider = Provider.of<TeacherProfileProvider>(context);

String imageUrl = widget.profile.image ?? "assets/images/teacherimg.png";


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

              //image ........................................................

                          Center(
                            child: Stack(
                                                children: [
                                                  // buildImage(),
                                                  
                                                  ClipOval(
                            child:    SizedBox(
                            width:145,
                                                    height:145,
                            child: AspectRatio(
                                      aspectRatio: 1.0,
                        
                             child:_image!=null?Image.file(_image,fit:BoxFit.fitWidth,
                                                    width:145,
                                                    height:145,
                                                    alignment: Alignment.topCenter,
                                                    ) :   
                                               widget.profile.image!=null?                       
                                              Image.network(AppUrl.baseUrl+imageUrl,
                                                  fit:BoxFit.cover,
                                                    width:160,
                                                    height:160,
                                                    alignment: Alignment.topCenter,

                                                               ):
                                                               Image.asset( "assets/images/teacherimg.png",
                                                    fit:BoxFit.cover,
                                                    width:128,
                                                    height:128,
                                                    alignment: Alignment.topCenter,

                                                )
                      
                                                ),
                                           ),
                                                  ),
                                                  Positioned(
                            bottom:0,
                            right:4,
                            child: buildEditIcon(const Color.fromARGB(255, 13, 68, 114))
                            ),
                                                  ]
                                                  ),
                          ),
              SizedBox(height:19),

              Text(
               'Phone Number',
               style:  GoogleFonts.poppins(

              fontSize:  17,
              height:  1.5,
              color:  Colors.black,

                )
            ),           
              SizedBox(height:4),

            TextFormField(
              
              controller:phonecontroller,
              keyboardType: TextInputType.number,
              decoration:InputDecoration(
                hintText:widget.profile.phoneNumber,
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
            SizedBox(height:20),

              Text(
               'To change your Location...',
               style:  GoogleFonts.poppins(

              fontSize:  17,
                  height:  1.5,
                color:  Colors.black,

                )
            ), 
            Text(
               'Point the location on google map and click update button',
               style:  GoogleFonts.poppins(

              fontSize:  15,
                  height:  1.5,
                color:  Colors.black,

                )
            ), 
            SizedBox(height:10),          
          

            Container(
              height:350,
              child:GoogleMap(
                initialCameraPosition:CameraPosition(
                  target:LatLng(
                    double.parse(widget.profile.latitude?? "26.4837"),
                    double.parse(widget.profile.longitude?? "87.2834"),
                    ),
                    
                    zoom:15,
                ),
                onTap:_onMapTap,
                markers:_selectedLatLng!=null
                ?{
                  Marker(
                    markerId:MarkerId('selected_location'),
                    position:_selectedLatLng!,
                    infoWindow: InfoWindow(title: "Current",
                    ),
                   icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),

                  )
                } :{
                  Marker(
                    markerId:MarkerId(""),
                    position:LatLng(
                    double.parse(widget.profile.latitude?? "26.4837"),
                    double.parse(widget.profile.longitude?? "87.2834"),
                    ),
                    infoWindow: InfoWindow(title: "Current",
                    ),
                   icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),

                  )

                },
                myLocationButtonEnabled: true,
              )

            ),
            SizedBox(height:height*0.1),

            GestureDetector(
              onTap:() async{
                double? updatedLatitude = double.parse(widget.profile.latitude?? "26.4837");

                double? updatedLongitude = double.parse(widget.profile.longitude?? "87.2834");
                String? address = widget.profile.address?? '';
                      if(_image!=null){
                 imageFile =  File(_image.path);
                       
                }  
                if(_selectedLatLng !=null){
                 updatedLatitude = _selectedLatLng!.latitude;
                 updatedLongitude = _selectedLatLng!.longitude;
                print(updatedLatitude);
                print(updatedLongitude);
                
                try{
                  List<Placemark> placemarks = await placemarkFromCoordinates(
                      updatedLatitude,updatedLongitude
                  );
                  // ignore: unnecessary_null_comparison
                  if(placemarks!=null && placemarks.isNotEmpty){
                    Placemark placemark = placemarks[0];
                    print(placemark);
                    if(placemark.subLocality!=null && placemark.subLocality!.trim().isNotEmpty){
                     address ='${placemark.subLocality}, ${placemark.locality}';

                    }else{
                    address = placemark.locality;
                    }
                  }else{
                    print("Address not found");
                  }
                }catch(e){
                  print("Error fetching address: $e");
                }
                

                }

                if(formkey.currentState!.validate()){
                  teacherprofileProvider.teacherprofileUpdate(context,phonecontroller.text.toString(),widget.profile.id,_image,updatedLatitude,
                  updatedLongitude,address?? ''
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

  void _onMapTap(LatLng latLng){
    setState(() {
      _selectedLatLng = latLng;
      print("Selected:$_selectedLatLng");
    });
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

