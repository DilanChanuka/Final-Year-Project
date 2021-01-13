import 'package:UorMap/Screens/Map/Display/Notification.dart';
import 'package:UorMap/Screens/Map/Function/main_map.dart';
import 'package:UorMap/page_tran.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:UorMap/constanents.dart';
import 'package:UorMap/Screens/Common/data.dart';
import 'package:UorMap/Screens/Disition/disistionFunc.dart';
import 'package:UorMap/Screens/Map/Function/GetUser_Location.dart';
import 'package:UorMap/Screens/Map/Function/getCurrentLocation.dart';
import 'package:UorMap/Screens/Map/Function/RealTimeULoc.dart';

bool departmentFlage=false;
bool floorFlage=false;
bool vORfFlage=false;
bool currentLocation=false;
bool flage=false;
bool selectcurrentLocation=false;

Future<List<dynamic>> currentLat;
List<double> startLocation=new List<double>();
List<dynamic> userLocAndPolyline=new List<dynamic>();
List<dynamic> reqValue=new List<dynamic>();

class DirectionPage extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: colorwhite,
        backgroundColor: firstColor,
      ),
      home: Hpage(),
    );
  }
}
class Hpage extends StatefulWidget
{
  @override
  _MHPage createState() => _MHPage();
}

class _MHPage extends State<Hpage> {

  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  final GlobalKey<State> _loader = GlobalKey<State>();
  int itm = 0;
  String vlu = '';

  void getFloor(){
    setState(() {
      vlu = dselectedFloorName;
    });
  }

  Future<String> createAlertDialog(BuildContext context) async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text("Select Department and Floor", 
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 20,
                fontWeight: FontWeight.bold,
                color: firstColor,
              ),
              textAlign: TextAlign.center,
            ),
            content: Form(

              child: SingleChildScrollView(
                child: Column(
                  //mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("Select Department",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width / 20,
                        ),
                    ),
                    Container(
                      //height: MediaQuery.of(context).size.height * 0.076,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: mainColor,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            DropdownButton(
                                isExpanded: true,
                                autofocus: true,
                                //hint: Text("Select Department"),
                                value: departmentvalue,
                                underline: Container(
                                  height: 3,
                                  color: firstColor,
                                ),
                                items: department.map((departmentvalue) {
                                  return DropdownMenuItem(
                                    value: departmentvalue,
                                    child: Text(departmentvalue,
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.width / 25,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String dp) {
                                  setState(() {
                                    dselectedDepartment = dp;
                                    departmentQ.insert(0,dselectedDepartment);
                                    departmentFlage=true;
                                  });
                                }
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 30,),
                    Text("Select Floor",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width / 20,
                        ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: mainColor,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
          
                            DropdownButton(
                                isExpanded: true,
                                autofocus: true,
                                //hint: Text("Select Floor"),
                                value: dselectedFloorName,
                                underline: Container(
                                  height: 3,
                                  color: firstColor,
                                ),
                                items: floor.map((value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value,
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.width / 25,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (fl) {
                                  setState(() {
                                    dselectedFloorName = fl;
                                    floorQ.insert(0,dselectedFloorName);
                                    floorFlage=true;
                                  });
                                }
                            ),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),

            actions: <Widget>[
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  getFloor();
                },
                child: Text("OK",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 22,
                    fontWeight: FontWeight.bold,
                    color: firstColor,
                  ),
                ),
              ),
            ],
          );
        },
        );
      },
    );
  }

 String location,destination;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: firstColor,
            title: Text("Inside University",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 20,
              ),
            ),
            actions: <Widget>[

             DropdownButton<int>(
               isDense: true,
                iconSize: MediaQuery.of(context).size.width / 10,
                iconEnabledColor: mainColor,
                dropdownColor: Colors.transparent,
                value: itm,
                items: [
                  DropdownMenuItem(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 4,
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height / 30)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.6),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(0, 3),
                          ),
                        ],
                        color: tridColor,
                        border: Border.all(color: blackcolor),
                      ),
                    child: Text("Out Side",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 20,
                        color: mainColor,
                        fontWeight: FontWeight.bold
                        ),
                    ),
                    ),
                    value: 0,
                  ),
                  DropdownMenuItem(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 4,
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height / 30)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.6),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(0, 3),
                          ),
                        ],
                        color: tridColor,
                        border: Border.all(color: blackcolor),
                      ),
                      child: Text("In Side",
                        textAlign: TextAlign.center,
                      style: TextStyle(
                        color: mainColor,
                        fontSize: MediaQuery.of(context).size.width / 20,
                        fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                      value: 1,
                      onTap: () async {
                        floorcontroller.clear();
                        groundselected = null;
                        firstselected = null;
                        secoundselected = null;
                        iffloorcontroller.clear();
                        ifgroundselected = null;
                        iffirstselected = null;
                        ifsecoundselected = null;
                        await createAlertDialog(context);
                      }
                  ),
                ],
                onChanged: (int value){
                  setState(() {
                    itm = value;
                  });
                },
              ),
              
            ],
          
            bottom: TabBar(
              indicatorWeight: 3,
              indicatorColor: mainColor,
              tabs:[
                Tab(
                  icon: Icon(Icons.directions_walk,
                  color: mainColor,
                  ),
                  child: Text("Walk",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 25,
                      color: mainColor,
                    ),
                  ),
                ),
                Tab(
                  icon: Icon(Icons.directions_car,
                  color: mainColor,
                ),
                  child: Text("Vehicle",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 25,
                      color: mainColor,
                    ),
                  ),
                ),
              ],
              
            ),
            leading: IconButton(icon: Icon(
              Icons.arrow_back,
              size: MediaQuery.of(context).size.width / 15,
              color: mainColor,
            ),
             onPressed: () =>
               _handleBack(context),
            ),
            ),
          body:
          TabBarView(
            children:[
              _tab2(),
              _tab1(),
            ],
          ),
        ),
      ),
    );
  }
  Widget _tab1()
  {
    if(itm == 0)
    {
      return SingleChildScrollView(
        child: _buildUserVehicleOutSide(),
      );
    }
    else
    {
      return IgnorePointer(
        child: SingleChildScrollView(
          child: _buildUserVehicleInSide(),
        ),
      );
    } 
  } 
  Widget _tab2()
  {
    if(itm == 0)
    {
      return SingleChildScrollView(
        child: _buildUserWalkOutSide(),
      );
    }
    else
    {
      return SingleChildScrollView(
        child: _buildUserWalkInSide(),
      );
    }
  }

  Widget _buildUserLocationVehicleOutSide()
  {
    return SingleChildScrollView(
      child: Container(
      height: 70.0,
      width: MediaQuery.of(context).size.width / 1.5,
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.all(Radius.circular(20.0)),
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
      child: TextFormField(
        readOnly: true,
        autofocus: true,
        autocorrect: true,
        decoration: InputDecoration(
          labelText: 'Enter Your Location',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(5),
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
                                  controller: vehicleoutUserLocselect,
                                  hintText: "Your Location",
                                  hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.width / 28,),
                                  enabled: true,
                                  items: vehicleoutUserLoc,
                                  onValueChanged: (value)
                                  {  
                                    setState(() {
                                     vehicleOUTdselectedStart = value;
                                      dvOr='v';

                                      startLocationQ.insert(0,vehicleOUTdselectedStart);
                                      vOfQ.insert(0,dvOr);
                                      vORfFlage=true;

                                      if(startLocationQ[0]=="Your Location")
                                            currentLocation=true;
                                    });
                                  },
                                ), 
                            ), 
                        ),      
                      
                      actions: [
                        FlatButton(
                          onPressed: (){Navigator.of(context).pop(vehicleOUTdselectedStart);},
                          child: Text("OK"),
                        ),
                      ],       
                    );
                  }
                );
              }
            );
          },
        controller: TextEditingController(text: vehicleOUTdselectedStart),
      ),
      ),
    );
  }
  Widget _buildUserLocationVehicleInSide()
  {
    return SingleChildScrollView(
      child: Container(
      height: 70.0,
      width: MediaQuery.of(context).size.width / 1.5,
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.all(Radius.circular(20.0)),
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
      child: TextFormField(
        readOnly: true,
        autofocus: true,
        autocorrect: true,
        decoration: InputDecoration(
          labelText: 'Enter Your Location',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(5),
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
                                  controller: vehicleinUserLocselect,
                                  hintText: "Your Location",
                                  hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.width / 28),
                                  enabled: true,
                                  items: vehicleinUserLoc,
                                  onValueChanged: (value)
                                  {  
                                    setState(() {
                                      vehicleINdselectedStart = value;
                                      dvOr='v';

                                      startLocationQ.insert(0,vehicleINdselectedStart);
                                      vOfQ.insert(0,dvOr);
                                      vORfFlage=true;

                                      if(startLocationQ[0]=="Your Location")
                                            currentLocation=true;
                                    });
                                  },
                                ), 
                            ),  
                        ),      
                      
                      actions: [
                        FlatButton(
                          onPressed: (){Navigator.of(context).pop(vehicleINdselectedStart);},
                          child: Text("OK"),
                        ),
                      ],       
                    );
                  }
                );
              }
            );
          },
        controller: TextEditingController(text: vehicleINdselectedStart),
      ),
      ),
    );
  }

  Widget _buildUserLocationWalkInSide()
  {
    if(vlu == "Ground floor")
    {
      return _groundw();
    }
    if(vlu == "First floor")
    {
      return _firstw();
    }
    else
    {
      return _secondw();
    }
  }
  Widget _groundw()
  {
    return SingleChildScrollView(
      child: Container(
      height: 70.0,
      width: MediaQuery.of(context).size.width / 1.5,
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.all(Radius.circular(20.0)),
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
      child: TextFormField(
        readOnly: true,
        autofocus: true,
        autocorrect: true,
        decoration: InputDecoration(
          labelText: 'Enter Your Location',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(5),
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
                                  controller: floorcontroller,
                                  hintText: "Your Location",
                                  hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.width / 28),
                                  enabled: true,
                                  items: walkoutStartiLoc,
                                  onValueChanged: (value)
                                  {  
                                    setState(() {
                                      walkINdselectedStart = value;
                                      dvOr='f';

                                      startLocationQ.insert(0,walkINdselectedStart);
                                      vOfQ.insert(0,dvOr);
                                      vORfFlage=true;

                                      if(startLocationQ[0]=="Your Location")
                                            currentLocation=true;;
                                    });
                                  },
                                ), 
                            ),  
                        ),      
                       
                      actions: [
                        FlatButton(
                          onPressed: (){Navigator.of(context).pop(walkINdselectedStart);},
                          child: Text("OK"),
                        ),
                      ],       
                    );
                  }
                );
              }
            );
          },
        controller: TextEditingController(text: walkINdselectedStart),
      ),
      ),
    );
  }
  Widget _firstw()
  {
    return SingleChildScrollView(
      child: Container(
      height: 70.0,
      width: MediaQuery.of(context).size.width / 1.5,
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.all(Radius.circular(20.0)),
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
      child: TextFormField(
        readOnly: true,
        autofocus: true,
        autocorrect: true,
        decoration: InputDecoration(
          labelText: 'Enter Your Location',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(5)
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
                                  controller: floorcontroller,
                                  hintText: "Your Location",
                                  hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.width / 28),
                                  enabled: true,
                                  items: walkoutStartiLoc,
                                  onValueChanged: (value)
                                  {  
                                    setState(() {
                                      walkINdselectedStart = value;
                                      dvOr='f';

                                      startLocationQ.insert(0,walkINdselectedStart);
                                      vOfQ.insert(0,dvOr);
                                      vORfFlage=true;

                                      if(startLocationQ[0]=="Your Location")
                                            currentLocation=true;
                                    });
                                  },
                                ), 
                            ),   
                        ),      
                      
                      actions: [
                        FlatButton(
                          onPressed: (){Navigator.of(context).pop(walkINdselectedStart);},
                          child: Text("OK"),
                        ),
                      ],       
                    );
                  }
                );
              }
            );
          },
        controller: TextEditingController(text: walkINdselectedStart),
      ),
      ),
    );
  }
  Widget _secondw()
  {
    return SingleChildScrollView(
      child: Container(
      height: 70.0,
      width: MediaQuery.of(context).size.width / 1.5,
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.all(Radius.circular(20.0)),
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
      child: TextFormField(
        readOnly: true,
        autofocus: true,
        autocorrect: true,
        decoration: InputDecoration(
          labelText: 'Enter Your Location',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(5)
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
                                  controller: floorcontroller,
                                  hintText: "Your Location",
                                  hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.width / 28),
                                  enabled: true,
                                  items: walkoutStartiLoc,
                                  onValueChanged: (value)
                                  {  
                                    setState(() {
                                      walkINdselectedStart = value;
                                      dvOr='f';

                                      startLocationQ.insert(0,walkINdselectedStart);
                                      vOfQ.insert(0,dvOr);
                                      vORfFlage=true;

                                      if(startLocationQ[0]=="Your Location")
                                            currentLocation=true;
                                    });
                                  },
                                ), 
                            ),                           
                        ),      
                      
                      actions: [
                        FlatButton(
                          onPressed: (){Navigator.of(context).pop(walkINdselectedStart);},
                          child: Text("OK"),
                        ),
                      ],       
                    );
                  }
                );
              }
            );
          },
        controller: TextEditingController(text: walkINdselectedStart),
      ),
      ),
    );
  }
  Widget _buildUserLocationWalkOutSide()
  {
    return SingleChildScrollView(
      child: Container(
      height: 70.0,
      width: MediaQuery.of(context).size.width / 1.5,
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.all(Radius.circular(20.0)),
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
      child: TextFormField(
        readOnly: true,
        autofocus: true,
        autocorrect: true,
        decoration: InputDecoration(
          labelText: 'Enter Your Location',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(5)
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
                                  controller: walkoutUserLocselect,
                                  hintText: "Your Location",
                                  hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.width / 28),
                                  enabled: true,
                                  items: walkoutStartiLoc,
                                  onValueChanged: (value)
                                  {  
                                    setState(() {
                                      walkOUTdselectedStart = value;
                                      dvOr='f';

                                      startLocationQ.insert(0,walkOUTdselectedStart);
                                      vOfQ.insert(0,dvOr);
                                      vORfFlage=true;

                                      if(startLocationQ[0]=="Your Location")
                                            currentLocation=true;
                                    });
                                  },
                                ), 
                            ),                           
                        ),      
                      
                      actions: [
                        FlatButton(
                          onPressed: (){Navigator.of(context).pop(walkOUTdselectedStart);},
                          child: Text("OK"),
                        ),
                      ],       
                    );
                  }
                );
              }
            );
          },
        controller: TextEditingController(text: walkOUTdselectedStart),
      ),
      ),
    );
  }
  Widget _buildDestinationVehicleInSide()
  {
    return SingleChildScrollView(
      child: Container(
      height: 70.0,
      width: MediaQuery.of(context).size.width / 1.5,
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.all(Radius.circular(20.0)),
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
      child: TextFormField(
        readOnly: true,
        autofocus: true,
        autocorrect: true,
        decoration: InputDecoration(
          labelText: 'Enter Destination',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(5)
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
                                  controller: vehicleinDestiLocselect,
                                  hintText: "Choose destination",
                                  hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.width / 28),
                                  enabled: true,
                                  items: vehicleinDestiLoc,
                                  onValueChanged: (value)
                                  {  
                                    setState(() {
                                      vehicleINdselectedStart = value;
                                      dvOr='v';

                                      startLocationQ.insert(0,vehicleINdselectedStart);
                                      vOfQ.insert(0,dvOr);
                                      vORfFlage=true;
                                    });
                                  },
                                ), 
                              ),                            
                        ),      
                       
                      actions: [
                        FlatButton(
                          onPressed: (){Navigator.of(context).pop(vehicleINdselectedStart);},
                          child: Text("OK"),
                        ),
                      ],       
                    );
                  }
                );
              }
            );
          },
        controller: TextEditingController(text: vehicleINdselectedStart),
      ),
      ),
    );
  }
  
  Widget _buildDestinationVehicleOutSide()
  {
    return SingleChildScrollView(
      child: Container(
      height: 70.0,
      width: MediaQuery.of(context).size.width / 1.5,
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.all(Radius.circular(20.0)),
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
      child: TextFormField(
        readOnly: true,
        autofocus: true,
        autocorrect: true,
        decoration: InputDecoration(
          labelText: 'Enter Destination',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(5)
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
                                  controller: vehicleoutDestiLocselect,
                                  hintText: "Choose destination",
                                  hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.width / 28),
                                  enabled: true,
                                  items: vehicleoutDestiLoc,
                                  onValueChanged: (value)
                                  {  
                                    setState(() {
                                      vehicleOUTdselectedDestination = value;                                   
                                      endLocationQ.insert(0,vehicleOUTdselectedDestination);
                                      dvOr='v';
                                      vOfQ.insert(0,dvOr);
                                    });
                                  },
                                ), 
                            ),                             
                        ),      
                      
                      actions: [
                        FlatButton(
                          onPressed: (){Navigator.of(context).pop(vehicleOUTdselectedDestination);},
                          child: Text("OK"),
                        ),
                      ],       
                    );
                  }
                );
              }
            );
          },
        controller: TextEditingController(text: vehicleOUTdselectedDestination),
      ),
      ),
    );
  }

  Widget _buildDestinationWalkInSide()
  {
    if(vlu == "Ground floor")
    {
      return _ifgroundw();
    }
    if(vlu == "First floor")
    {
      return _iffirstw();
    }
    else
    {
      return _ifsecondw();
    }
  }
  Widget _ifgroundw()
  {
    return SingleChildScrollView(
      child: Container(
      height: 70.0,
      width: MediaQuery.of(context).size.width / 1.5,
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.all(Radius.circular(20.0)),
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
      child: TextFormField(
        readOnly: true,
        autofocus: true,
        autocorrect: true,
        decoration: InputDecoration(
          labelText: 'Enter Destination',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(5)
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
                                  controller: iffloorcontroller,
                                  hintText: "Choose destination",
                                  hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.width / 28),
                                  enabled: true,
                                  items: ifground,
                                  onValueChanged: (value)
                                  {  
                                    setState(() {
                                      walkINdselectedDestination = value;
                                      endLocationQ.insert(0,walkINdselectedDestination);

                                      dvOr='f';
                                      vOfQ.insert(0,dvOr);
                                    });
                                  },
                                ), 
                            ),                           
                        ),      
                      
                      actions: [
                        FlatButton(
                          onPressed: (){Navigator.of(context).pop(walkINdselectedDestination);},
                          child: Text("OK"),
                        ),
                      ],       
                    );
                  }
                );
              }
            );
          },
        controller: TextEditingController(text: walkINdselectedDestination),
      ),
      ),
    );
  }
  Widget _iffirstw()
  {
    return SingleChildScrollView(
      child: Container(
      height: 70.0,
      width: MediaQuery.of(context).size.width / 1.5,
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.all(Radius.circular(20.0)),
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
      child: TextFormField(
        readOnly: true,
        autofocus: true,
        autocorrect: true,
        decoration: InputDecoration(
          labelText: 'Enter Destination',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(5)
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
                                  controller: iffloorcontroller,
                                  hintText: "Choose destination",
                                  hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.width / 28),
                                  enabled: true,
                                  items: iffirst,
                                  onValueChanged: (value)
                                  {  
                                    setState(() {
                                      walkINdselectedDestination = value;
                                      endLocationQ.insert(0,walkINdselectedDestination);

                                      dvOr='f';
                                      vOfQ.insert(0,dvOr);
                                    });
                                  },
                                ), 
                            ),                             
                        ),      
                       
                      actions: [
                        FlatButton(
                          onPressed: (){Navigator.of(context).pop(walkINdselectedDestination);},
                          child: Text("OK"),
                        ),
                      ],       
                    );
                  }
                );
              }
            );
          },
        controller: TextEditingController(text: walkINdselectedDestination),
      ),
      ),
    );
  }
  Widget _ifsecondw()
  {
    return SingleChildScrollView(
      child: Container(
      height: 70.0,
      width: MediaQuery.of(context).size.width / 1.5,
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.all(Radius.circular(20.0)),
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
      child: TextFormField(
        readOnly: true,
        autofocus: true,
        autocorrect: true,
        decoration: InputDecoration(
          labelText: 'Enter Destination',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(5)
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
                                  controller: iffloorcontroller,
                                  hintText: "Choose destination",
                                  hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.width / 28),
                                  enabled: true,
                                  items: ifsecound,
                                  onValueChanged: (value)
                                  {  
                                    setState(() {
                                      walkINdselectedDestination = value;
                                      endLocationQ.insert(0,walkINdselectedDestination);

                                      dvOr='f';
                                      vOfQ.insert(0,dvOr);
                                    });
                                  },
                                ), 
                            ),                           
                        ),      
                       
                      actions: [
                        FlatButton(
                          onPressed: (){Navigator.of(context).pop(walkINdselectedDestination);},
                          child: Text("OK"),
                        ),
                      ],       
                    );
                  }
                );
              }
            );
          },
        controller: TextEditingController(text: walkINdselectedDestination),
      ),
      ),
    );
  }
  Widget _buildDestinationWalkOutSide()
  {
    return SingleChildScrollView(
      child: Container(
      height: 70.0,
      width: MediaQuery.of(context).size.width / 1.5,
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.all(Radius.circular(20.0)),
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
      child: TextFormField(
        readOnly: true,
        autofocus: true,
        autocorrect: true,
        decoration: InputDecoration(
          labelText: 'Enter Destination',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(5)
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
                                  controller: walkoutDestiLocselect,
                                  hintText: "Choose destination",
                                  hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.width / 28),
                                  enabled: true,
                                  items: walkoutDestiLoc,
                                  onValueChanged: (value)
                                  {  
                                    setState(() {
                                      walkOUTdselectedDestination = value;
                                      endLocationQ.insert(0,walkOUTdselectedDestination);

                                      dvOr='f';
                                      vOfQ.insert(0,dvOr);
                                    });
                                  },
                                ), 
                            ),                           
                        ),      
                       
                      actions: [
                        FlatButton(
                          onPressed: (){Navigator.of(context).pop(walkOUTdselectedDestination);},
                          child: Text("OK"),
                        ),
                      ],       
                    );
                  }
                );
              }
            );
          },
        controller: TextEditingController(text: walkOUTdselectedDestination),
      ),
      ),
    );
  }
  
  Widget buildEnterButtonVehicleInSide()
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

	           
              arr.insert(0,startLocationQ[0]),
              arr.insert(1,endLocationQ[0]), 

              //add department  value for quere
              if(departmentFlage)
              {
                  arr.insert(2,departmentQ[0]),
              }
              else
                  arr.insert(2,""),
              
              //add floor value for floor Quere
              if(floorFlage)
              {
                  arr.insert(3,floorQ[0])
              }
              else
                  arr.insert(3,""),

              //add vOrF   value for vOrF quere
              if(vORfFlage)
              {
                  arr.insert(4,vOfQ[0])
              }
              else
                  arr.insert(4,"v"),
              
              if(currentLocation){
                  
                  selectcurrentLocation=true,     

                   // startTimeout(),
                                flage=true,
                                arr.removeAt(0),
                                arr.insert(0,reqValue),
                                arr.insert(5,1), //1 =>> user wants to current location
                                //currentLocation=false,
                                disitionFunc(context,_loader, arr),
                      /*
                          currentLat=getcurrentLocation154(),
                          //0=>user location LatLng
                          //1=>google map polyline
                          currentLat.then((value) => {
                                userLocAndPolyline=value,
                                //reqValue.add(userLocAndPolyline[0]),
                                reqValue.add(userLocAndPolyline),
                                flage=true,
                                arr.removeAt(0),
                                arr.insert(0,reqValue),
                                arr.insert(5,1), //1 =>> user wants to current location
                                currentLocation=false,
                                disitionFunc(context,_loader, arr),
                          }),   

                          */                                                                
              }
              else{
                    arr.insert(5,0), //0==>> user not want current location
              },
                      
               if(!selectcurrentLocation)
              {
                  disitionFunc(context,_loader, arr),             
                  //messageBox(context, "", message),
              }
              
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
  Widget buildEnterButtonVehicleOutSide()
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
              //_handleSubmitaddsearch(context),
              vehicleoutUserLocselect.clear(),
              vehicleoutUserLocselected = null,
              vehicleoutDestiLocselect.clear(),
              vehicleoutDestiLocselected = null,
              vehicleOUTdselectedStart = null,/////////////////////////////
              vehicleOUTdselectedDestination = null,

              arr.insert(0,startLocationQ[0]),
              arr.insert(1,endLocationQ[0]), 

              //add department  value for quere
              if(departmentFlage)
              {
                  arr.insert(2,departmentQ[0]),
              }
              else
                  arr.insert(2,""),
              
              //add floor value for floor Quere
              if(floorFlage)
              {
                  arr.insert(3,floorQ[0])
              }
              else
                  arr.insert(3,""),

              //add vOrF   value for vOrF quere
              if(vORfFlage)
              {
                  arr.insert(4,'v')
              }
              else
                  arr.insert(4,"v"),
              
              if(currentLocation){
                  
                  selectcurrentLocation=true,     

                    //startTimeout(),
                                flage=true,
                                arr.removeAt(0),
                                arr.insert(0,reqValue),
                                arr.insert(5,1), //1 =>> user wants to current location
                                //currentLocation=false,
                                disitionFunc(context,_loader, arr),
                      /*
                          currentLat=getcurrentLocation154(),
                          //0=>user location LatLng
                          //1=>google map polyline
                          currentLat.then((value) => {
                                userLocAndPolyline=value,
                                //reqValue.add(userLocAndPolyline[0]),
                                reqValue.add(userLocAndPolyline),
                                flage=true,
                                arr.removeAt(0),
                                arr.insert(0,reqValue),
                                arr.insert(5,1), //1 =>> user wants to current location
                                currentLocation=false,
                                disitionFunc(context,_loader, arr),
                          }),   

                          */                                                                   
              }
              else{
                    arr.insert(5,0), //0==>> user not want current location
              },
                      
              if(!selectcurrentLocation)
              {
                  disitionFunc(context,_loader, arr),             
                  //messageBox(context, "", message),
              }             


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

  Widget buildEnterButtonWalkInSide()
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
              //_handleSubmitaddsearch(context),
              floorcontroller.clear(),
              groundselected = null,
              firstselected = null,
              secoundselected = null,
              iffloorcontroller.clear(),
              ifgroundselected = null,
              iffirstselected = null,
              ifsecoundselected = null,

              
              arr.insert(0,startLocationQ[0]),
              arr.insert(1,endLocationQ[0]), 

              //add department  value for quere
              if(departmentFlage)
              {
                  arr.insert(2,departmentQ[0]),
              }
              else
                  arr.insert(2,""),
              
              //add floor value for floor Quere
              if(floorFlage)
              {
                  arr.insert(3,floorQ[0])
              }
              else
                  arr.insert(3,""),

              //add vOrF   value for vOrF quere
              if(vORfFlage)
              {
                  arr.insert(4,"f")
              }
              else
                  arr.insert(4,"f"),
              
              if(currentLocation){


                  
                  selectcurrentLocation=true,     

                    //startTimeout(),
                                flage=true,
                                arr.removeAt(0),
                                arr.insert(0,reqValue),
                                arr.insert(5,1), //1 =>> user wants to current location
                                //currentLocation=false,
                                disitionFunc(context,_loader, arr),
                      /*
                          currentLat=getcurrentLocation154(),
                          //0=>user location LatLng
                          //1=>google map polyline
                          currentLat.then((value) => {
                                userLocAndPolyline=value,
                                //reqValue.add(userLocAndPolyline[0]),
                                reqValue.add(userLocAndPolyline),
                                flage=true,
                                arr.removeAt(0),
                                arr.insert(0,reqValue),
                                arr.insert(5,1), //1 =>> user wants to current location
                                currentLocation=false,
                                disitionFunc(context,_loader, arr),
                          }),   

                          */                

              }
              else{
                    arr.insert(5,0), //0==>> user not want current location
              },
                      
               if(!selectcurrentLocation)
              {
                  disitionFunc(context,_loader, arr),             
                  //messageBox(context, "", message),
              }            
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
  Widget buildEnterButtonWalkOutSide()
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
              //_handleSubmitaddsearch(context),
              walkoutUserLocselect.clear(),
              walkoutUserLocselected = null,
              walkoutDestiLocselect.clear(),
              walkoutDestiLocselected = null,

               arr.insert(0,startLocationQ[0]),
              arr.insert(1,endLocationQ[0]), 

              //add department  value for quere
              if(departmentFlage)
              {
                  arr.insert(2,departmentQ[0]),
              }
              else
                  arr.insert(2,""),
              
              //add floor value for floor Quere
              if(floorFlage)
              {
                  arr.insert(3,floorQ[0])
              }
              else
                  arr.insert(3,""),

              //add vOrF   value for vOrF quere
              if(vORfFlage)
              {
                  arr.insert(4,"f")
              }
              else
                  arr.insert(4,"f"),
              
              if(currentLocation){
                  
                  selectcurrentLocation=true,     

                    startTimeout(),
                                flage=true,
                                arr.removeAt(0),
                                arr.insert(0,reqValue),
                                arr.insert(5,1), //1 =>> user wants to current location
                                //currentLocation=false,
                                disitionFunc(context,_loader, arr),
                      /*
                          currentLat=getcurrentLocation154(),
                          //0=>user location LatLng
                          //1=>google map polyline
                          currentLat.then((value) => {
                                userLocAndPolyline=value,
                                //reqValue.add(userLocAndPolyline[0]),
                                reqValue.add(userLocAndPolyline),
                                flage=true,
                                arr.removeAt(0),
                                arr.insert(0,reqValue),
                                arr.insert(5,1), //1 =>> user wants to current location
                                currentLocation=false,
                                disitionFunc(context,_loader, arr),
                          }),   

                          */                                                      
              }
              else{
                    arr.insert(5,0), //0==>> user not want current location
              },
                      
              if(!selectcurrentLocation)
              {
                  disitionFunc(context,_loader, arr),             
                  //messageBox(context, "", message),
              }
                 

             

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

  Widget _buildUserVehicleOutSide()
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
                        child:ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(MediaQuery.of(context).size.height / 30),
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.height*0.2,//
                            width: MediaQuery.of(context).size.width*0.96,
                            decoration: BoxDecoration(
                              color: mainColor,
                            ),
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  _buildUserLocationVehicleOutSide(),
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
                            height: MediaQuery.of(context).size.height*0.2,//
                            width: MediaQuery.of(context).size.width* 0.96,
                            decoration: BoxDecoration(
                              color: mainColor,
                            ),
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  _buildDestinationVehicleOutSide(),
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
                            height: MediaQuery.of(context).size.height*0.23,//
                            width: MediaQuery.of(context).size.width*0.96,
                            decoration: BoxDecoration(
                              color: mainColor,
                            ),
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  buildEnterButtonVehicleOutSide(),
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
  Widget _buildUserVehicleInSide()
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
                        child:ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(MediaQuery.of(context).size.height / 30),
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.height*0.2,//
                            width: MediaQuery.of(context).size.width*0.96,
                            decoration: BoxDecoration(
                              color: mainColor,
                            ),
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  _buildUserLocationVehicleInSide(),
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
                            height: MediaQuery.of(context).size.height*0.2,//
                            width: MediaQuery.of(context).size.width* 0.96,
                            decoration: BoxDecoration(
                              color: mainColor,
                            ),
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  _buildDestinationVehicleInSide(),
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
                            height: MediaQuery.of(context).size.height*0.23,//
                            width: MediaQuery.of(context).size.width*0.96,
                            decoration: BoxDecoration(
                              color: mainColor,
                            ),
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  buildEnterButtonVehicleInSide(),
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

  Widget _buildUserWalkOutSide()
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
                        child:ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(MediaQuery.of(context).size.height / 30),
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.height*0.2,//
                            width: MediaQuery.of(context).size.width*0.96,
                            decoration: BoxDecoration(
                              color: mainColor,
                            ),
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  _buildUserLocationWalkOutSide(),
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
                            height: MediaQuery.of(context).size.height*0.2,//
                            width: MediaQuery.of(context).size.width* 0.96,
                            decoration: BoxDecoration(
                              color: mainColor,
                            ),
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  _buildDestinationWalkOutSide(),
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
                            height: MediaQuery.of(context).size.height*0.23,//
                            width: MediaQuery.of(context).size.width*0.96,
                            decoration: BoxDecoration(
                              color: mainColor,
                            ),
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  buildEnterButtonWalkOutSide(),
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
  Widget _buildUserWalkInSide()
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
                        child:ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(MediaQuery.of(context).size.height / 30),
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.height*0.2,//
                            width: MediaQuery.of(context).size.width*0.96,
                            decoration: BoxDecoration(
                              color: mainColor,
                            ),
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  _buildUserLocationWalkInSide(),
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
                            height: MediaQuery.of(context).size.height*0.2,//
                            width: MediaQuery.of(context).size.width* 0.96,
                            decoration: BoxDecoration(
                              color: mainColor,
                            ),
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  _buildDestinationWalkInSide(),
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
                            height: MediaQuery.of(context).size.height*0.23,//
                            width: MediaQuery.of(context).size.width*0.96,
                            decoration: BoxDecoration(
                              color: mainColor,
                            ),
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  buildEnterButtonWalkInSide(),
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

  Future<void> _handleSubmitaddsearch(BuildContext context) async{
    try{
      Dialogs.showLoadingDialog(context,_keyLoader);
      await Future.delayed(Duration(seconds: 3,));
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();

      //Navigator.push(context,MaterialPageRoute(builder: (context) => AddSearch()));
    }
    catch(error){
      print(error);
    }
  }
}

String vehicleOUTdselectedStart="";
String vehicleOUTdselectedDestination = "";
String vehicleINdselectedStart="";
String vehicleINdselectedDestination = "";

String walkINdselectedStart="";
String walkINdselectedDestination = "";
String walkOUTdselectedStart="";
String walkOUTdselectedDestination = "";

String dvOr="";
String dselectedFloorName= "Ground floor";
String dselectedDepartment="";

//List<String> arr=[start,destinationLoc,dselectedDepartment,dselectedFloorName,dvOr];
List<dynamic> arr=new List<dynamic>();

List<String> startLocationQ=new List<String>();
List<String> endLocationQ=new List<String>();
List<String> departmentQ=new List<String>();
List<String> floorQ=new List<String>();
List<String> vOfQ=new List<String>();

final walkoutUserLocselect = TextEditingController();
final walkoutDestiLocselect = TextEditingController();
final vehicleoutUserLocselect = TextEditingController();
final vehicleoutDestiLocselect = TextEditingController();
final vehicleinUserLocselect = TextEditingController();
final vehicleinDestiLocselect = TextEditingController();
final placeNameSelect = TextEditingController();

String floorvalue  = "";
String departmentvalue ="Computer Science Department";
final groundf = TextEditingController();
final firstf = TextEditingController();
