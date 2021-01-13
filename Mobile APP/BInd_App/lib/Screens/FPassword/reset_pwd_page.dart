import 'package:UorMap/Screens/Login/login_page.dart';
import 'package:UorMap/page_tran.dart';
import 'package:flutter/material.dart';
import 'package:UorMap/Screens/FPassword/forg_pass_page.dart';
import 'package:UorMap/constanents.dart';

class ResetPwd extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: blackcolor,
      resizeToAvoidBottomPadding: false,
      body: RPWDBody(),
    );
  } 
}
class RPWDBody extends StatefulWidget
{
  @override
  _ResetPageState createState() => _ResetPageState();
}
class _ResetPageState extends State<RPWDBody>
{

  String password,conpassword,validationCode = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<State> _keyLoader = GlobalKey<State>();

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
              height: MediaQuery.of(context).size.height * 0.7,
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
                children: <Widget>[
                  _buildLogo(),
                  _buildcontainer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SingleChildScrollView(
          child: Text(
            "UOR NAVIGATION",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height/20,
                fontWeight: FontWeight.bold,
                color: blackcolor,
              ),
            ),
        ),
      ],
    );
  }

  Widget _buildcontainer()
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
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.white
              ),
              key: _formKey,
              child: SingleChildScrollView(  
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: MediaQuery.of(context).size.height / 30,),
                    _buildValidationCode(),
                    _buildPassword(),
                    _buildConPassword(),
                    _buildEnter(),
                    _buildCancel(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
 
  Widget _buildValidationCode()
  {
     return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height / 60),
        child: SingleChildScrollView(
          child: TextFormField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: Icon(
                  Icons.confirmation_number, 
                  color: firstColor,
                ),
                labelText: "Validation Code"
            ),
            validator: (String code){
              Pattern pattern = r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
              RegExp regex  = new RegExp(pattern);
              if(!regex.hasMatch(code))
                return "Invalid password";
              else
                return null;
            },
            onSaved: (code) => validationCode = code,
            textInputAction: TextInputAction.next,
          ),
        ),
    );
  }

  Widget _buildPassword()
  {
     return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height / 60),
        child: SingleChildScrollView(
          child: TextFormField(
            keyboardType: TextInputType.text,
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

  Widget _buildConPassword()
  {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height / 60),
        child: SingleChildScrollView(
          child: TextFormField(
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: Icon(
                  Icons.lock,
                  color: firstColor,
                ),
                labelText: "Confirm Password"
            ),
            validator: (String copwd){
              Pattern pattern = r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
              RegExp regex  = new RegExp(pattern);
              if(!regex.hasMatch(copwd))
                return "Invalid password";
              else
                return null;
            },
            onSaved: (copwd) => conpassword = copwd,
            textInputAction: TextInputAction.done,
          ),
        ),
    );
  }

  Widget _buildEnter()
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
            height: 1.4 * (MediaQuery.of(context).size.height / 20),
            width: 5 * (MediaQuery.of(context).size.width /10),
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 30,top: MediaQuery.of(context).size.height / 30),
            child: RaisedButton(
              elevation: 5.0,
              color: firstColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height / 30),
              ),
              onPressed: () => {
                ///if(_formKey.currentState.validate())
                ////{
                  //_formKey.currentState.save(),

                  _handleSubmitenter(context),
                //}
              },
              child: SingleChildScrollView(
                child: Text(
                  "Enter",
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.5,
                      fontSize: MediaQuery.of(context).size.height / 30,
                    ),
                  ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCancel()
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
            height: 1.4 * (MediaQuery.of(context).size.height / 20),
            width: 5 * (MediaQuery.of(context).size.width /10),
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 30),
            child: RaisedButton(
              elevation: 5.0,
              color: firstColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height / 30),
              ),
              onPressed: () => {
                _handleSubmitcancel(context),
              },
              child: SingleChildScrollView(
                child: Text(
                  "Cancel",
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.5,
                      fontSize: MediaQuery.of(context).size.height / 30,
                    ),
                  ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleSubmitenter(BuildContext context) async{
    try{
      Dialogs.showLoadingDialog(context,_keyLoader);
      await Future.delayed(Duration(seconds: 3,));
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();

      Navigator.push(context,MaterialPageRoute(builder: (context) => Login()));
    }
    catch(error){
      print(error);
    }
  }

  Future<void> _handleSubmitcancel(BuildContext context) async{
    try{
      Dialogs.showLoadingDialog(context,_keyLoader);
      await Future.delayed(Duration(seconds: 3,));
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();

      Navigator.push(context,MaterialPageRoute(builder: (context) => ForgPass()));
    }
    catch(error){
      print(error);
    }
  }
}