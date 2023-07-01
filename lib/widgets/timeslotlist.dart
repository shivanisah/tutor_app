import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tutor_app/models/user_models/timeSlotmodel.dart';
import 'package:tutor_app/providers/timeSlot_provider.dart';
import 'package:tutor_app/utils/colors.dart';
import 'package:http/http.dart' as http;





class TimeSlotList extends StatefulWidget{
  @override
  State<TimeSlotList> createState() => _TimeSlotList();
}

class _TimeSlotList extends State<TimeSlotList> {
  int? teacherId;
  bool isLoading = false;
  List<int> disabledSlots = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final timeSlotProvider = Provider.of<TimeSlotProvider>(context, listen: false);
    teacherId = ModalRoute.of(context)!.settings.arguments as int;
    timeSlotProvider.TimeSlots(teacherId!);
  }



  Future<void> disableSlot(TimeSlot timeslot, bool disable) async {
    setState(() {
      isLoading = true;
    });
        try{
    final url = Uri.parse('http://192.168.1.72:8000/timeslotdisable/${timeslot.id}');
    final response = await http.post(url,
    );

    if (response.statusCode == 200) {

      setState(() {
              timeslot.setDisable(disable);
              // disabledSlots.add(timeslot.id?? 0);

            }); 
    final snackBar = SnackBar(content: Text('Slot Disabled'),backgroundColor: Palette.theme1,);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

         } 
         
         else {
      throw Exception('Failed to disable slot');
    }
  }catch(error){

  }finally{
    setState(() {
      isLoading = false;
    });
  }


  }
 

  @override
  Widget build(BuildContext context) {

  final timeSlotProvider = Provider.of<TimeSlotProvider>(context);
  final timeslots = timeSlotProvider.timeSlots;

    return Container(
      
      
   child:   Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [
        SizedBox(height:40),
          Padding(
            padding: const EdgeInsets.only(left:15.0,bottom:9),
            child: Text(
               'Your Available Slots',
               style:  GoogleFonts.poppins(
                
              fontSize:  25,
                  fontWeight:  FontWeight.w500,
                  height:  1.0,
                color:  Color(0xff000000),
                
                )
            ),
          ),
          Container(
      
            child: ListView.builder(
              shrinkWrap: true,
              physics:NeverScrollableScrollPhysics(),
              itemCount: timeslots.length,
              itemBuilder: (context, index) {
                final timeslot = timeslots[index];
                
                return
                 Container(
                  margin:EdgeInsets.only(left:20,top:10,bottom:10,right:20),
                  padding:EdgeInsets.only(top:20),
                  height:60,
                  
                      decoration: BoxDecoration(
                        borderRadius:BorderRadius.circular(6),
                                                    boxShadow:[
                                  BoxShadow(
                                    color: Color.fromARGB(255, 188, 187, 187),
      
                                    blurRadius:3,
                                    offset:Offset(0,3),
                                  ),
                                  BoxShadow(
                                    color:Colors.white,
                                    offset:Offset(-3,0),
                                  ),
                                  BoxShadow(
                                      color:Colors.white,
                                    offset:Offset(3,0),
                                  ),
                                ]
      
                      ),
                      child:Column(
                        children: [
                          Row(children: [

                            SizedBox(width:5),
                            Icon(Icons.timer_sharp,size:20,color:Palette.theme1),
                            SizedBox(width:20),
                            Text('${timeslot.startTime} - ${timeslot.endTime}'), 
                             
                          SizedBox(width:60),
                          timeslot.disable == false
                                ?GestureDetector(
                                  onTap: () {
                                 disableSlot(timeslot, true);
                                 print("time..................................");
                                 print(timeslot.disable);

                                  },
                                  child: Text("Disable",style:  GoogleFonts.poppins(
                
              
                  fontWeight:  FontWeight.w500,
                  height:  1.0,
                color: Palette.theme1,
                
                )
                     ),
                                    
                                  ):Text("Disabled",style:  GoogleFonts.poppins(               
                  fontWeight:  FontWeight.w500,
                  height:  1.0,
                color: Palette.theme1,
                
                ))

                          ],),

                        ],
                      )
                );
                
              },
            ),
            
          ),
        ],
      ),
    );
  }


    


  }


