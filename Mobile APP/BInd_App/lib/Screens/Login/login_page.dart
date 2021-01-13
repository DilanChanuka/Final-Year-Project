import 'package:UorMap/Screens/Map/Function/main_map.dart';
import 'package:UorMap/page_tran.dart';
import 'package:flutter/material.dart';
import 'package:UorMap/Screens/Signup/signup_page.dart';
import 'package:UorMap/constanents.dart';
import 'package:UorMap/Screens/FPassword/forg_pass_page.dart';
import 'package:UorMap/Screens/Common/data.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:UorMap/Screens/Map/Display/Notification.dart';

class Login extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackcolor,
      resizeToAvoidBottomPadding: false,
      body: LBody(),
    );
  }

  void whenComplete(Future<Object> Function() param0) {}
}
class LBody extends StatefulWidget
{
    @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LBody>
{

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<State> _keyLoader = GlobalKey<State>();

  String username,password;
 Future<bool> myfuture;
  String url;
  /*Widget _buildLogo(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SingleChildScrollView(
          child: Text(
            "UOR NAVIGATION",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width/10,
                fontWeight: FontWeight.bold,
                color: blackcolor,
              ),
          ),
        ),
      ],
    );
  }*/
  Widget _buildUsernameRow() 
  {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height /60),
      child: SingleChildScrollView(
        child: TextFormField(
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.words,
          onChanged:(value)=>{
            username=value,
          },
          decoration: InputDecoration(
            prefixIcon: Icon(
                Icons.perm_identity,
                color: firstColor,
              ),
              labelText: "Username"
          ),
          textInputAction: TextInputAction.next,
          validator: (String name){
            Pattern pattern  =  r'^[A-Za-z0-9] + (? :[ _-][A-Za-z0-9]+)*$';
            RegExp regex = new RegExp(pattern);
              if(!regex.hasMatch(name))
                return "Inavalid username";
              else 
                return null;
          },
          onSaved: (name) => username = name,
        ),
      ),
    );
  }
  Widget _buildPasswordRow() 
  {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height / 60),
      child: SingleChildScrollView(
        child: TextFormField(
          keyboardType: TextInputType.text,
          onChanged: (value)=>{
            password=value,
          },
          obscureText: true,
          decoration: InputDecoration(
            prefixIcon: Icon(
                Icons.lock,
                color: firstColor,
              ),
              labelText: "Password"
          ),
          validator: (String pwd){
            Pattern pattern = r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
            RegExp regex  = new RegExp(pattern);
            if(!regex.hasMatch(pwd))
              return "Invalid password";
            else
              return null;
          },
          onSaved: (pwd) => password = pwd,
          textInputAction: TextInputAction.done,
        ),
      ),
    );
  }
  Widget buildForgetPasswordButton()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height / 20,
            margin: EdgeInsets.all(MediaQuery.of(context).size.height / 60),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height / 30)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
              color: mainColor,
              border: Border.all(color: colorborder),
            ),
            child: FlatButton(onPressed: () => {
              Navigator.push(context,
              MaterialPageRoute(builder: (context)=>ForgPass())),
            },
              child: SingleChildScrollView(
                child: Text("Forgotten your password?",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 22,
                    color: tridColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget buildLoginButton()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height / 30)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            height: 1.2 * (MediaQuery.of(context).size.height / 20),
            width: 5 * (MediaQuery.of(context).size.width /10),
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 30,top: MediaQuery.of(context).size.height / 30),
            child: RaisedButton(
              elevation: 5.0,
              color: firstColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height / 30),
              ),
              onPressed: ()async => {
      
                  url=port+"/IdentifyUser/"+username+"/"+password+"",
                  myfuture=authenticateUser(url),
                  myfuture.then((value) => {
                    if(value){
                        user=username,                     
                        Navigator.push(context,MaterialPageRoute(builder: (context) => MainMap())),
                    }
                    else{
                      showAlertLogin(context),
                    }
                      
                  }),         
             
              },
              child: SingleChildScrollView(
                child: Text(
                  "LOGIN",
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.5,
                      fontSize: MediaQuery.of(context).size.width / 20,
                    ),
                  ),
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget buildSignUpButton()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SingleChildScrollView(
          child: Container(
          height: MediaQuery.of(context).size.height / 20,
            padding: EdgeInsets.zero,
            margin: EdgeInsets.all(MediaQuery.of(context).size.height / 60),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height / 30)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
              color: mainColor,
              border: Border.all(color:  colorborder),
            ),
            child: FlatButton(
              onPressed: () => {
                Navigator.push(context,
              MaterialPageRoute(builder: (context)=>SignUp())),
              },
              child: SingleChildScrollView(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.width / 22,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: "Sign Up",
                        style: TextStyle(
                          color: firstColor,
                          fontSize: MediaQuery.of(context).size.width / 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildContainer()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SingleChildScrollView(
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(MediaQuery.of(context).size.height / 30),
            ),
            child: Container(
              height: MediaQuery.of(context).size.height*0.8,
              width: MediaQuery.of(context).size.width*0.8,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: SingleChildScrollView(
              child: Form(
                key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height / 20,),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SingleChildScrollView(
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: tridColor,
                            fontSize: MediaQuery.of(context).size.width / 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                  _buildUsernameRow(),
                  _buildPasswordRow(),
                  buildForgetPasswordButton(),
                  buildLoginButton(),
                  buildSignUpButton(),
                ],
              ),
            ),
            ),
            ),
          ),
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context)
  {
    return SafeArea( 
      child: Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: mainColor,
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height*0.7,
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(
                  color: firstColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(70),
                    bottomRight: const Radius.circular(70),
                  ),
                ),
              ),  
            ),
            SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 15,
                  ),
                  _buildContainer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSubmitloginMainmap(BuildContext context) async{
    try{
      Dialogs.showLoadingDialog(context,_keyLoader);
      await Future.delayed(Duration(seconds: 3,));
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();

      Navigator.push(context,MaterialPageRoute(builder: (context) => MainMap()));
    }
    catch(error){
      print(error);
    }
  }

  
     Future<bool> authenticateUser(String url) async
      {
          bool result2=false;
          try
          {
              var data=await http.post(url);
              if(data.statusCode==200)
              {
                 result2=true;   
              }
          
          }catch(error)
          {
              print(error);
          }
            
          
            return result2;
        }

  
}