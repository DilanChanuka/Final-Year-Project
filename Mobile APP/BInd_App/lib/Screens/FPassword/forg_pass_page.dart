import 'package:UorMap/page_tran.dart';
import 'package:flutter/material.dart';
import 'package:UorMap/Screens/FPassword/reset_pwd_page.dart';
import 'package:UorMap/constanents.dart';
import 'package:email_validator/email_validator.dart';

class ForgPass extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackcolor,
      resizeToAvoidBottomPadding: false,
      body: FBody(),
    );
  }
}
class FBody extends StatefulWidget
{
    @override
  _ForgPassPageState createState() => _ForgPassPageState();
}
class _ForgPassPageState extends State<FBody>
{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  String email;
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
                children: <Widget>[
                  _buildLogo(),
                  _buildContainer(),
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
                color: Colors.black,
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    SizedBox(height: MediaQuery.of(context).size.height / 30),
                    SingleChildScrollView(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                        
                          Container(
                            width: MediaQuery.of(context).size.height * 0.4,
                            padding: EdgeInsets.all(MediaQuery.of(context).size.height / 150),
                            margin: EdgeInsets.all(MediaQuery.of(context).size.height / 40),
                            decoration: BoxDecoration(
                              border: Border.all(color: colorborder),
                            ),
                            child: SingleChildScrollView(           
                              child: Text("To reset your password,submit your email address below.If we can find yor,an email will be send to your email address,with instruction how to get access again.",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 6,
                              //textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SingleChildScrollView(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: MediaQuery.of(context).size.height / 10),
                          Container(
                            //width: MediaQuery.of(context).size.height / 3,
                            child: SingleChildScrollView(
                              child: Text("Search by email",
                              textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: tridColor,
                                  decoration: TextDecoration.underline,
                                  fontSize: MediaQuery.of(context).size.height / 30,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buidemailRow(),
                    buildSearchButton(),
                  ],
                ),
              ),
              ),
              ),
            ),
          ),
          ),
      ],
    );
  }

  Widget _buidemailRow() // user email
  {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height / 60),
        child: SingleChildScrollView(
          child: TextFormField(
            keyboardType: TextInputType.name,
            /*onChanged: (value){
              setState(() {
                email = value;
              });
            },*/
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
            onSaved: (eml) => email = eml,
          ),
        ),
      );
  }

  Widget buildSearchButton()
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
            margin: EdgeInsets.all(MediaQuery.of(context).size.height / 30),
            child: RaisedButton(
              elevation: 5.0,
              color: firstColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height / 30),
              ),
              onPressed: () => {
                if(_formKey.currentState.validate())
                {
                  _formKey.currentState.save(),

                  _handleSubmitsearch(context), 
                }
              },
              child: SingleChildScrollView(
                child: Text(
                  "Search",
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

  Future<void> _handleSubmitsearch(BuildContext context) async{
    try{
      Dialogs.showLoadingDialog(context,_keyLoader);
      await Future.delayed(Duration(seconds: 3,));
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();

      Navigator.push(context,MaterialPageRoute(builder: (context) => ResetPwd()));
    }
    catch(error){
      print(error);
    }
  }

}