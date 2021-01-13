import 'package:UorMap/Screens/Direction/Direction_page.dart';
import 'package:UorMap/Screens/Common/data.dart';
import 'package:UorMap/Screens/LocationShare/manage_friends_page.dart';
import 'package:UorMap/Screens/Profile/PrifilePage.dart';
import 'package:UorMap/Screens/Welcome/welcome_page.dart';
import 'package:UorMap/page_tran.dart';
import 'package:flutter/material.dart';
import 'package:UorMap/constanents.dart';
import 'package:UorMap/Screens/Request/ConvertData.dart';
import 'package:UorMap/Screens/Request/Location_shearing.dart';
import 'package:UorMap/Screens/Request/JsonBody.dart';

Widget getSideBar(BuildContext context,GlobalKey _keyLoader)
{
    
    
  
  Future<void> _handleSubmitsearch(BuildContext context) async{
    try{
      Dialogs.showLoadingDialog(context,_keyLoader);
      await Future.delayed(Duration(seconds: 3,));
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();

      Navigator.push(context,MaterialPageRoute(builder: (context) => DirectionPage()));
    }
    catch(error){
      print(error);
    }
  }

  Future<void> _handleSubmitaddsearch(BuildContext context) async{
    try{
      Dialogs.showLoadingDialog(context,_keyLoader);
      await Future.delayed(Duration(seconds: 3,));
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();

      Navigator.push(context,MaterialPageRoute(builder: (context) => DirectionPage()));
    }
    catch(error){
      print(error);
    }
  }

  Future<void> _handleSubmitwelcome(BuildContext context) async{
    try{
      Dialogs.showLoadingDialog(context,_keyLoader);
      await Future.delayed(Duration(seconds: 3,));
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();

      Navigator.push(context,MaterialPageRoute(builder: (context) => WelcomePage()));
    }
    catch(error){
      print(error);
    }
  }

  Future<void> _handleManageFriends(BuildContext context,GlobalKey _lorder,List<dynamic> response) async{
    try{
      Dialogs.showLoadingDialog(context,_keyLoader);
      await Future.delayed(Duration(seconds: 3,));
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();

      Navigator.push(context,MaterialPageRoute(builder: (context) => Managefriends(response)));
    }
    catch(error){
      print(error);
    }
  }

  Future<void> _handleSetProfile(BuildContext context) async{
    try{
      Dialogs.showLoadingDialog(context,_keyLoader);
      await Future.delayed(Duration(seconds: 3,));
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();

      Navigator.push(context,MaterialPageRoute(builder: (context) => ProfilePage()));
    }
    catch(error){
      print(error);
    }
  }



return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text(user), 
                  accountEmail: Text(useremail),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: mainColor,
                    child: Text("A"),
                  ),
                  decoration: BoxDecoration(
                    color: firstColor,
                  ),
                ),

                ListTile(
                  title: Text("Sign Out",style: TextStyle(fontSize: MediaQuery.of(context).size.width / 20),),
                  leading: Icon(Icons.exit_to_app,color: blackcolor,), 
                  onTap: () => {
                       user="",
                       useremail="",
                      _handleSubmitwelcome(context),
                  }),

                ListTile(
                  title: Text("Profile",style: TextStyle(fontSize: MediaQuery.of(context).size.width / 20,),),
                  leading: Icon(Icons.person,color: blackcolor,),
                  onTap: (){
                    _handleSetProfile(context);
                  },
                ),

                ListTile(
                  title: Text("Manage Friends",style: TextStyle(fontSize: MediaQuery.of(context).size.width / 20),),
                  leading: Icon(Icons.contacts,color: blackcolor,),
                  onTap: (){

                    //get Request
                    String url=getManageFirendRequest(user);
                    List<dynamic> allReasponse=new List<dynamic>();
                    Future<String> myfuture=getjsonvalue(url);
                    myfuture.then((response) =>{
                        allReasponse=getManageFirend(response),
                       _handleManageFriends(context, _keyLoader,allReasponse),
                     });

                  },
                ),

                ListTile(
                  title: Text("Settings",style: TextStyle(fontSize: MediaQuery.of(context).size.width / 20),),
                  leading: Icon(Icons.settings,color: blackcolor,),
                  onTap: (){},
                ),

                ListTile(
                  title: Text("Help and feedback",style: TextStyle(fontSize: MediaQuery.of(context).size.width / 20),),
                  leading: Icon(Icons.help,color: blackcolor,),
                  onTap: (){},
                ),

              ],
            ),
          );



}

