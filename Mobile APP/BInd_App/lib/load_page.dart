/*import 'dart:async';
import 'package:flutter/material.dart';
import 'package:map_interfaces/Screens/Welcome/welcome_page.dart';
import 'package:map_interfaces/constanents.dart';

class Uor extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: mainColor,
        backgroundColor: Colors.white70,
        brightness: Brightness.light,
      ),
      home: Body(),
    );
  }
}
class Body extends StatefulWidget
{
  @override
  _DBody createState() => _DBody();
}
class _DBody extends State<Body>
{

  void initState(){
    super.initState();

    Timer(
      Duration(seconds: 2), 
      () => Navigator.push(
        context,MaterialPageRoute(
          builder: (context) => WelcomePage(),
          ),
        ),
    );
    //Future.delayed(Duration(seconds: 2)).then((_) => _displaySnackbar);
  }
  /*void get _displaySnackbar 
  {
    _scafflodKey.currentState.showSnackBar(
      SnackBar(
        duration: Duration(
          seconds: 5,
          ),
        content: Text("Your open UOR road map..."),
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: <Widget>[
          Container(
            child: Column (
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/images/1.png',
                  width: 150.0,
                  height: 400.0,
                ),
                //SpinKitFadingCircle(color: Colors.brown,),
              ],
            ),
          ),
        ],
      ), 
    );
  }
}*/