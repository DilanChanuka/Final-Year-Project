import 'package:UorMap/Screens/Signup/signup_page.dart';
import 'package:flutter/material.dart';  
import 'package:fluttertoast/fluttertoast.dart';
import 'package:UorMap/Screens/Common/data.dart';
import 'package:UorMap/Screens/Map/Display/Display_2User_Path.dart';


void showMessage(int placeid)
{
    String floorName=getFloorName(placeid);
    if(floorName.length>0)
    {
        Fluttertoast.showToast(
          msg:" Your destination floor is \n "+floorName ,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP_LEFT,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.amber,
          textColor: Colors.black );
    }

}

void showGetPlaceMessage(int floorid)
{

    String floorname=floorName(floorid);
    if(floorname.length>0)
    {
        Fluttertoast.showToast(
          msg:" Your destination floor is \n "+floorname ,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP_LEFT,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.amber,
          textColor: Colors.black );
    }

}

void  message(String message)
{
   
   
        Fluttertoast.showToast(
          msg:" Your destination is \n "+message ,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP_LEFT,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.amber,
          textColor: Colors.black );
    

}

void setMessage(String message)
{
   
   
        Fluttertoast.showToast(
          msg:message ,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP_LEFT,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.amber,
          textColor: Colors.black );
    

}

Future<Widget> showAlert(BuildContext context,String name) async
{
   return showDialog(
    context:context,
    builder:(BuildContext context){
       return AlertDialog(
        title:Text("Message"),
        content:Text("Do You Want to get Path for "+name+"..?"),
        actions: <Widget>[
          FlatButton(
            onPressed:(){
                Navigator.pop(context);
                result=true;
            },
            child:Text("Yes")),

          FlatButton(
            onPressed:(){
                Navigator.pop(context);
                result=false;
          },
          child:Text("NO"))  
        ],
      );
    });
}

Future<Widget> showAlertLogin(BuildContext context) async
{
   return showDialog(
    context:context,
    builder:(BuildContext context){
       return AlertDialog(
        title:Text("Notice"),
        content:Text("Invalidate Ditails.\n Please Try again"),
        actions: <Widget>[
          FlatButton(
            onPressed:(){
                Navigator.pop(context);
            },
            child:Text("Ok")), 
        ],
      );
    });

}
Future<Widget> messageBox(BuildContext context,String title,String message) async
{
   return showDialog(
    context:context,
    builder:(BuildContext context){
       return AlertDialog(
        title:Text(title),
        content:Text(message),
        actions: <Widget>[
          FlatButton(
            onPressed:(){
                sinUpflage=true;
                Navigator.pop(context);
            },
            child:Text("Ok")), 
        ],
      );
    });


}


Future<Widget> showMessages(BuildContext context,String message) async
{
   return showDialog(
    context:context,
    builder:(BuildContext context){
       return AlertDialog(
        title:Text("warnning"),
        content:Text(message),
        actions: <Widget>[
          FlatButton(
            onPressed:(){
                Navigator.pop(context);
            },
            child:Text("Ok")), 
        ],
      );
    });


}
String getFloorName(int placeid)
{
    String name="";
    if(firstFloor.contains(placeid))
        name="First Floor";
    else if(secondFloor.contains(placeid))
        name="Second Floor";
    else
        name="Ground Floor";

    return name;
}

String floorName(int floorid) //get floor name using floor id (0 /1 /2)
{
    String name="";
    if(floorid==1)
        name="First Floor";
    else if(floorid==2)
        name="Second Floor";
    else
        name="Ground Floor";

    return name;
}