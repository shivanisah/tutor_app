import 'package:flutter/material.dart';
import 'package:tutor_app/tutorDrawer/mainPageDrawer.dart';


class DrawerTest extends StatefulWidget{
  @override
  State<DrawerTest> createState() => _DrawerTest();
}

class _DrawerTest extends State<DrawerTest> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer:TutorMainPageDrawer(),
      appBar: AppBar(),
    );



    


  }

}
