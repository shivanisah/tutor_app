
import 'package:flutter/material.dart';

class Search extends StatefulWidget{
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final search=TextEditingController();

  void dispose(){
    super.dispose();
    search.dispose();

  }

  @override
  Widget build(BuildContext context){
    return Container(
      margin:EdgeInsets.only(top:20,left:15,right:40,bottom:20),
      child: SizedBox(
          height:38,

          child:TextFormField(
            // showCursor:false,
              controller:search,
              decoration:InputDecoration(
                  hintText:"Search Subject...",
                  border:InputBorder.none,
                  contentPadding: EdgeInsets.only(left:13,right: 19,top:10,bottom: 7),
                  prefixIcon:Icon(Icons.search),
                  prefixIconColor:Colors.black ,
                  enabledBorder:OutlineInputBorder(
                      borderRadius:BorderRadius.circular(12),
                      borderSide:BorderSide(
                        color:Colors.black,
                      )
                  ),
                  focusedBorder:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:BorderSide(color:Colors.black)
                  )
              )
          )
      ),
    );

  }
}