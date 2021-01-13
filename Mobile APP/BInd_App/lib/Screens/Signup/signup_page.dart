import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:UorMap/Screens/Common/data.dart';
import 'package:UorMap/page_tran.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:UorMap/Screens/Login/login_page.dart';
import 'package:UorMap/constanents.dart';
import 'package:UorMap/Screens/Term&Con/term_con_page.dart';
import 'package:UorMap/Screens/Map/Display/Notification.dart';


bool sinUpflage=false;

class SignUp  extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackcolor,
      resizeToAvoidBottomPadding: false,
      body: SBody(),
    );
  }
}
class SBody extends StatefulWidget
{
    @override
  _SignUpPageState createState() => _SignUpPageState();
}
class _SignUpPageState extends State<SBody> 
{
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String username,upassword,uemail,id,fty,type;
  String jsonbody;
  var data;
  Future<dynamic> response;
  bool checkB = false;
  bool first = true;

  Widget _buildUsernameRow() // user name 
  {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height / 300),
        child: SingleChildScrollView(
          child: TextFormField(
            keyboardType: TextInputType.name,
            onChanged:(value){
                setState(() {
                  username=value;
                });
            },
            textCapitalization: TextCapitalization.words,
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
  Widget _buidemailRow() // user email
  {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height / 300),
        child: SingleChildScrollView(
          child: TextFormField(
            autofocus: true,
           
            autocorrect: true,
            keyboardType: TextInputType.name,
           onChanged: (value){
              setState(() {
                uemail = value;
              });
            },
            decoration: InputDecoration(
              prefixIcon: Icon(
                  Icons.email,
                  color: firstColor,
                ),
                labelText: "Email",
                hintText: "abc@gmail.com",
            ),
            textInputAction: TextInputAction.next,
            validator: (String eml) => EmailValidator.validate(eml)? null:"Invalid email address",
            onSaved: (eml) => uemail = eml,
          ),
        ),
      );
  }
  Widget _buildPasswordRow() // user password 
  {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height / 300),
        child: SingleChildScrollView(
          child: TextFormField(
            keyboardType: TextInputType.text,
            obscureText: true,
            onChanged: (value){
              setState(() {
                upassword = value;
              });
            },
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
            onSaved: (pwd) => upassword = pwd,
            textInputAction: TextInputAction.done,
          ),
        ),
      );
  }
  Widget buildAgreeButton() // Terms and Conditions
  {
    
    return Row(
     // mainAxisAlignment: MainAxisAlignment.start,
     // crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SingleChildScrollView(
          child: Checkbox(
            checkColor: mainColor,
            activeColor: firstColor,
            value: this.first, 
            onChanged: (bool value){
              setState(() {
                this.first = value;
              });
            }
            ),
        ),
        SingleChildScrollView(
          child: Text("I agree with ",
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 25,
          ),
          ),
        ),
        SingleChildScrollView(
          child: InkWell(
            child: Text("Terms & Conditions",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width / 25,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
            ),
            onTap: () =>{
              Navigator.push(context,
              MaterialPageRoute(builder: (context)=>TCBody())),
            },
          ),
        ),
      ],
    );
  }
  Widget buildSignUpButton()
  {
    return Center(
        child: SingleChildScrollView(
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
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 60),
            child: RaisedButton(
              elevation: 5.0,
              color: firstColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height / 30),
              ),
              onPressed: ()async => {

                jsonbody=getJsonBody(username,uemail,upassword,fty,type),
                data=await http.post(
                  port+"/RegisterUser",
                  headers: {"Content-Type": "application/json"},
                  body: jsonbody,
                ),

                if(data.statusCode==200 || data.statusCode==201){
                       messageBox(context,"Congradulation","Registation succesfull .."),
                       if(sinUpflage){
                            _handleSubmitmmap(context),
                            sinUpflage=false,
                       }
                          
                }                
                
              },
              child: SingleChildScrollView(
                child: Text(
                  "SIGNUP",
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
    );
  }
  Widget buildLoginButton()
  {
    return Center(
        child: SingleChildScrollView(
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
              border: Border.all(color: colorborder),
            ),
            child: FlatButton(
              onPressed: () => {
                Navigator.push(context,
                MaterialPageRoute(builder: (context)=>Login())),
              },
              child: SingleChildScrollView(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "I'm already a member",
                        style: TextStyle(
                          color: blackcolor,
                          fontSize: MediaQuery.of(context).size.width / 22,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ),
      ),
    );
  }
  Widget _buildContainer()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SingleChildScrollView(
                        child: Text(
                          "SIGNUP",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width / 10,
                            color: tridColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildUsernameRow(),
                      _buidemailRow(),
                      _buildPasswordRow(),
                      _submitFaculty(),
                      _userType(),
                      buildAgreeButton(),
                      buildSignUpButton(),
                      buildLoginButton(),
                    ],
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
  Widget _submitFaculty(){
    return SingleChildScrollView(
      child: Center(
        child: Container(
          padding: EdgeInsets.all(2),
          height: MediaQuery.of(context).size.height / 13,
          width: MediaQuery.of(context).size.width  * 0.7,
          decoration: BoxDecoration(
            color: colorwhite,
            border: Border.all(color: colorborder),
          ),
          child: SingleChildScrollView(
            child: Container(
	      height: MediaQuery.of(context).size.height / 15,
              child: DropdownButton(
                underline: SizedBox(),
                value: fty,
                items: faculty
                .map((fty) => DropdownMenuItem(
                  child: SingleChildScrollView(
                    child: Text(fty,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 22,
                      ),
                    ),
                  ),
                  value: fty,
                )).toList(),
                onChanged: (String vl){
                  setState(() {
                    fty = vl;
                  });
                },
                autofocus: true,
                isExpanded: true,
                hint: Text("Select Faculty",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 22,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget _userType(){
    return SingleChildScrollView(
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height / 12.5,
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: BoxDecoration(
            color: colorwhite,
            border: Border.all(color: colorborder),
          ),
          child: SingleChildScrollView(
	    child: Container(
              height: MediaQuery.of(context).size.height / 15,
            child: Row(
              children: [
                Radio(
                  value: 0, 
                  groupValue: rdValue, 
                  onChanged: handleRadioValueChange,
                ),
                SingleChildScrollView(
                  child:Text("Staff Member",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 25,
                    ),
                  ),
                ),
                Radio(
                  value: 1, 
                  groupValue: rdValue, 
                  onChanged: handleRadioValueChange,
                ),
                SingleChildScrollView(
                  child: Text("Student",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 25,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }

  Future<void> _handleSubmitmmap(BuildContext context) async{
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

  
  String getJsonBody(String userName,String usermail,String userpwd,String faculty,String type)
  {
      
      Map data={
          'username':userName,
          'email':usermail,
          'type':type,
          'faculty':faculty,
          'password':userpwd
      };

      String body=json.encode(data);

      return "["+body+"]";
  }

  int rdValue;
  void handleRadioValueChange(int value){
    //0=>stafe member
    //1=>student
    setState(() {
      rdValue = value;
      if(value==1)
          type="staff member";
      else
          type="student";

      switch(rdValue){
        case 0:
          break;
        case 1:
          break;
      }
    });
  }
}