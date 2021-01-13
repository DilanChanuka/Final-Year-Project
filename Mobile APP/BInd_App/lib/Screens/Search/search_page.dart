import 'package:UorMap/Screens/Map/Function/main_map.dart';
import 'package:UorMap/Screens/Map/Function/search_map_show_page.dart';
import 'package:UorMap/page_tran.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:UorMap/constanents.dart';
import 'package:UorMap/Screens/Common/data.dart';
import 'package:UorMap/Screens/Disition/disistionFunc.dart';

class SearchPage extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Spage(),
    );
  }
}
class Spage extends StatefulWidget 
{
  @override
  _MHPage createState() => _MHPage();
}
class _MHPage extends State<Spage>
{

  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  final GlobalKey<State> _loader = GlobalKey<State>();
  String location,destination;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            backgroundColor: firstColor,
            title: Text("Search Any Place",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 20,
              ),
            ),
            leading: IconButton(icon: Icon(
              Icons.arrow_back,
              size: MediaQuery.of(context).size.width / 15,
              color: mainColor,
            ),
             onPressed: () =>
               _handleBack(context),
            )
          ),
          body: SingleChildScrollView(
             child: _buildUser(),
          ),
      ),
    );
  }
 
  Widget _buildDestination()
  {
    return SingleChildScrollView(        
      child: Container(
        height: 70.0,
        width: MediaQuery.of(context).size.width / 1.5,
        decoration: BoxDecoration(
          boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
          ],
            color: colorwhite,
            border: Border.all(color: colorborder),
        ),
          child: SingleChildScrollView(
            child: TextFormField(
              readOnly: true,
              autocorrect: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(5),
                border: InputBorder.none,
                labelText: 'Enter Place Name',
              ),
                onTap: (){
                  return showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder: (context, setState) {
                          return AlertDialog(
                            content: SingleChildScrollView(
                              physics: ClampingScrollPhysics(),
                                child: Container(  
                                    child: DropDownField(
                                      required: true,
                                      itemsVisibleInDropdown: 6,
                                      controller: placeNameSelect,
                                      hintText: "Choose Place",
                                      hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.width / 28),
                                      enabled: true, 
                                      items: placeName,
                                      onValueChanged: (value)
                                      {  
                                        setState(() {
                                      dselectedDestination = value;
                                  });
                                },
                              ), 
                            ),
                          ),      
             
                        actions: [
                          FlatButton(
                          onPressed: (){Navigator.of(context).pop(dselectedDestination);},
                          child: Text("OK"),
                        ),
                      ],       
                    );
                  }
                );
              }
            );
          },
        controller: TextEditingController(text: dselectedDestination),
      ),
    ),
    ),
    );
  }
  Widget buildEnterButton()
  {
    return SingleChildScrollView(
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
            height: (MediaQuery.of(context).size.height / 12),
            width: 5 * (MediaQuery.of(context).size.width /10),
            child: RaisedButton(
              elevation: 5.0,
              color: firstColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height / 30),
              ),
              onPressed: () => {
		            serachPlace(context,_loader,dselectedDestination)
               // placeNameselected = null,
               // placeNameSelect.clear(),
                //_handleSubmitsearch(context),
              },
              child: SingleChildScrollView(
                child: Text(
                  "Enter",
                  style: TextStyle(
                    color: mainColor,
                    letterSpacing: 1.5,
                    fontSize: MediaQuery.of(context).size.width / 20,
                  ),
                ),
              ),
            ),
          ),
    );
  }
  Widget _buildUser()
  {
    return SingleChildScrollView(
        child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    SizedBox(height: MediaQuery.of(context).size.height / 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height / 30)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: SingleChildScrollView(
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(MediaQuery.of(context).size.height / 30),
                            ),
                            child: Container(
                            height: MediaQuery.of(context).size.height * 0.56,
                            width: MediaQuery.of(context).size.width * 0.96,
                            decoration: BoxDecoration(
                              color: mainColor,
                            ),
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    _buildDestination(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height / 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height / 30)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: SingleChildScrollView(
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(MediaQuery.of(context).size.height / 30),
                              ),
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.22 ,
                                width: MediaQuery.of(context).size.width * 0.96,
                                decoration: BoxDecoration(
                                  color: mainColor,
                                ),
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        buildEnterButton(),
                                      ],
                                    ),
                                  ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                ],
              ),
        ),
    );
  }

  Future<void> _handleBack(BuildContext context) async{
    try{
      Dialogs.showLoadingDialog(context,_keyLoader);
      await Future.delayed(Duration(seconds: 2,));
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();

      Navigator.push(context,MaterialPageRoute(builder: (context) => MainMap()));
    }
    catch(error){
      print(error);
    }
  }

  Future<void> _handleSubmitsearch(BuildContext context) async{
    try{
      Dialogs.showLoadingDialog(context,_keyLoader);
      await Future.delayed(Duration(seconds: 2,));
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();

      Navigator.push(context,MaterialPageRoute(builder: (context) => Search()));
    }
    catch(error){
      print(error);
    }
  }
}

String dselectedStart="";
String dselectedDestination = "";
String dvOr="";
String dselectedFloorName= "Ground floor";
String dselectedDepartment="";

