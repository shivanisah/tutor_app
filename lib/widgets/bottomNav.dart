import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';


class BottomNavigationBar extends StatefulWidget{
  @override
  State<BottomNavigationBar> createState() => _BottomNavigationBar();
}

class _BottomNavigationBar extends State<BottomNavigationBar> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(

       bottomNavigationBar:CurvedNavigationBar(
        backgroundColor: Colors.deepPurple,
        color:Colors.deepPurple,
        animationDuration: Duration(milliseconds: 300),
        items: [
        Icon(Icons.home,color:Colors.white),
        Icon(Icons.favorite,color:Colors.white),
        Icon(Icons.settings,color:Colors.white),


        

       ],)


    );



    


  }

}
