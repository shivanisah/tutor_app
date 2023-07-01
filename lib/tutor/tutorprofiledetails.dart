import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tutor_app/models/user_models/timeSlotmodel.dart';
import 'package:tutor_app/providers/timeSlot_provider.dart';
import 'package:tutor_app/utils/colors.dart';
import 'package:http/http.dart' as http;

import '../providers/teacherProfileprovider.dart';





class TutorProfileDetailPage extends StatefulWidget{
  @override
  State<TutorProfileDetailPage> createState() => _TutorProfileDetailPage();
}

class _TutorProfileDetailPage extends State<TutorProfileDetailPage> {
  int? teacherId;
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final teacherProfileProvider = Provider.of<TeacherProfileProvider>(context, listen: false);
    teacherId = ModalRoute.of(context)!.settings.arguments as int;
    teacherProfileProvider.fetchTeacherProfile(teacherId!);
  }



 

  @override
  Widget build(BuildContext context) {

  final teacherProfileProvider = Provider.of<TeacherProfileProvider>(context);
  final profile = teacherProfileProvider.teacherProfile;
  print("Profile Details");
  print(profile!.fullName);

  return Scaffold(
    appBar: AppBar(),
    body:Container(
      margin:EdgeInsets.only(top: 60,left:30,right:30),
      child:Column(children: [
        Text('${profile.fullName}'),
        Text('${profile.phoneNumber}'),
        Text('${profile.email}'),
        Text('${profile.gender}'),
        Text('${profile.education}'),
        Text('${profile.teaching_experience}'),
        Text('${profile.address}'),

      ],)
    )
  );

  }


    


  }


