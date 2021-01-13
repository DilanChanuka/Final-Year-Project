import 'package:UorMap/page_tran.dart';
import 'package:flutter/material.dart';
import 'package:UorMap/Screens/Signup/signup_page.dart';
import 'package:UorMap/constanents.dart';

class TCPage extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: blackcolor,
        primaryColor: Colors.white,
      ), 
      home: TCBody(),
    );
  }
}
class TCBody extends StatefulWidget
{
  @override
  _TermConPageState createState() => _TermConPageState();
}
class _TermConPageState extends State<TCBody>
{
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            backgroundColor: firstColor,
            title: Text("Terms and Conditions",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height / 30,
              ),
            ),
            leading: IconButton(icon: Icon(
              Icons.arrow_back,
              size: MediaQuery.of(context).size.height / 20,
              color: mainColor,
            ),
             onPressed: () =>{
               Navigator.push(context,
              MaterialPageRoute(builder: (context)=>SignUp())),
             },
             ),
          ),
          body: Container(
            margin: EdgeInsets.all(MediaQuery.of(context).size.height / 300),
            padding: EdgeInsets.all(MediaQuery.of(context).size.height / 400),
            decoration: BoxDecoration(
              border: Border.all(color: colorborder),
            ),
            child: SingleChildScrollView(
              child: ClipRRect(
                borderRadius: BorderRadius.zero,
                child: Container(
                  height:MediaQuery.of(context).size.height * 1.4,
                  width:MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      SingleChildScrollView(
                        child: Text("AGREEMENT TO TERMS",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.height / 35,
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 60,),
                      SingleChildScrollView(
                        child: Text(" These Terms and Conditions constitute a legally binding agreement made between you,and Uor Map our,concerning your access to and use of our mobile application.You agree that by accessing the Application,you have read,understood,and agree to be bound by all of these Terms and Conditions use.IF YOU DO NOT AGREE WITH ALL OF THESE TERMS AND CONDITIONS,THEN YOU ARE EXPRESSLY PROHIBITED FROM USING THE APPLICATION AND YOU MUST DISCONTINUE USE IMMEDIATELY. ",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 200,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 40,
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 60,),
                      SingleChildScrollView(
                        child: Text("1. By using the site you represent and warrant that all registraion infromation you submit will be true,accurate,current,complete.",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 40,
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 60,),
                      SingleChildScrollView(
                        child: Text("2. You may be required to register with the site, You agree to keep your password confidential and will be responsible for all use of your account and password.We reserve the right to remove or change a user name you select if we determine in our sole discretion,that such user name is in appropriate,obscence or otherwise objectionable.",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 40,
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 60,),
                      SingleChildScrollView(
                        child: Text("3. If we terminate or suspend your account for any reason, you are prohibited from registering and creating a new account under your name,a fake or borrowed name.",
                          style: TextStyle( 
                            fontSize: MediaQuery.of(context).size.height / 40,
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 60,),
                      SingleChildScrollView(
                        child: Text("4. We can not gurantee the site will be available at all times.We may experience hardware,software or other problems or need to perform maintenance related to the site.",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 40,
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 60,),
                      SingleChildScrollView(
                        child: Text("5. In order to resolve a complaint regarding the site or to receive further information regarding use of the site, please contact us at.",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 40,
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 60,),
                      SingleChildScrollView(
                        child: Text("Phone No:- ",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 35,
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 60,),
                      SingleChildScrollView(
                        child: Text("Email address:- ",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 35,
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 60,),
                      SingleChildScrollView(
                        child: Text("Fax:- ",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 35,
                          ),
                        ),
                      ),

                    ], 
                    ),
                  ),
                ),
              ),
            ),
          ),
      ),
    );
  }
}