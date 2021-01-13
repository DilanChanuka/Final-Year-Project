import 'dart:async';
import 'dart:typed_data';
import 'package:location/location.dart';
import 'package:UorMap/Screens/Direction/Direction_page.dart';
import 'package:UorMap/Screens/Profile/PrifilePage.dart';
import 'package:UorMap/Screens/Welcome/welcome_page.dart';
import 'package:UorMap/page_tran.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:UorMap/constanents.dart';
import 'package:UorMap/Screens/Map/Display/Display_SideBar.dart';
import 'package:UorMap/Screens/Request/Location_shearing.dart';
import 'package:UorMap/Screens/Common/data.dart';
import 'package:UorMap/Screens/Request/ConvertData.dart';
import 'package:UorMap/Screens/Request/JsonBody.dart';
import 'package:UorMap/Screens/Map/Display/Notification.dart';
import 'package:UorMap/Screens/Map/Function/RealTimeULoc.dart';


List<dynamic> allfreandsLocation;
//0=>alldata List       
        //0=>username
        //1=>place location (LatLng)
//1=>400 


//if 200
//0=>allData
      //0=>routes point (LatLng)
      //1=>distence time
//1=>200
bool flage=false;
bool result=false;
List<String> directionQeue=new List<String>();
String distenceAndTime="";
bool isFrist=false;

class Get2UserPath extends StatefulWidget
{

  Get2UserPath(List<dynamic> freands)
  {
      allfreandsLocation=freands;
      if(freands[1]==200 &&freands[0][0]!=null){
          flage=true; //user for display path bitween tow user ..
          distenceAndTime=allfreandsLocation[0][1][1].toString()+"min("+allfreandsLocation[0][1][0].toString()+"m)";
          isFrist=true;
      }
          
  } 

  //Get2UserPath() : super();
  
  final String txt= "University Road Map";
  @override
  MainMapState createState() => MainMapState();

}
class MainMapState extends State<Get2UserPath>
{
  
  //Set<Marker> _marker={};
  Set<Polyline> _polyline={}; 
  GoogleMapController controller;
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  MapType _currentMapType = MapType.normal;
  List<Marker> allMarker = [];
  LatLng targetValue= LatLng(5.9382181, 80.576216);

  StreamSubscription _locationSubcription14;
  Location _locationTracker14= new Location();
  Marker currentlocationM14;
  Circle markerCircle14;
  bool  _changeSetting14;
  GoogleMapController mapcontroller14;

  @override
  void initState(){

    _getcurrentLocation();

    if(flage){
      createroutes();
      userPin();
    }
    else
      setallUserPin();

    super.initState();

  }

   Widget button(Function function,IconData icon)
  {
    return FloatingActionButton(
      heroTag: null,
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: Colors.blue,
      child: Icon(
        icon,
        size: 36.0,
      ),
      );
  }

  
    void createroutes()
    {
           
      if(allfreandsLocation[0][0]!=null)
      {     
        Polyline routes=Polyline(
          polylineId:PolylineId("routesBWFirends"),
          color:routeColor,
          width:routeWidth,
          points:allfreandsLocation[0][0] );

            _polyline.add(routes);
      }
    }

    void userPin()
    {
        if(allfreandsLocation[0][0][0]!=null)
        {
            allMarker.add(Marker(
            markerId:MarkerId("Destination"),
            infoWindow: InfoWindow(title:"Destination"),
            position:allfreandsLocation[0][0][allfreandsLocation[0][0].length-1]
             ));

            allMarker.add(Marker(
              markerId:MarkerId("Your_Posistion"),
              infoWindow: InfoWindow(title: "Your Location"),
              position: allfreandsLocation[0][0][0]
               ));
            targetValue=allfreandsLocation[0][0][0];
        }
          
    }
    

  void _onDirectionButtonPress()
  {
      if(directionQeue[0]!=null)
      {
          getFrendPath(directionQeue[0]);
          
          /*
        Future<Widget> res=showAlert(context,directionQeue[0]); 
                res.then((value) =>{
                      if(result)
                      {                   
                        getFrendPath(directionQeue[0]),   
                        result=false,              
                      }                                     
                  });

                  */
      }
  }
  
  void mapCreated(controller)
  {
    setState(() {
      controller = controller;
    });
  }
  
  void setallUserPin()
  {
      
      for(int i=0;i<allfreandsLocation[0].length;i++)
      {
          allMarker.add(Marker(
            markerId:MarkerId(allfreandsLocation[0][i][0]),
            infoWindow:InfoWindow(title: allfreandsLocation[0][i][0]),
            onTap: (){
                directionQeue.insert(0,allfreandsLocation[0][i][0]);
            },
            position:allfreandsLocation[0][i][1]));
      }
  }

   Future<void> _getcurrentLocation() async{
   // final GoogleMapController controller = await _controller.future;
   // controller.animateCamera(CameraUpdate.newCameraPosition(initialLocation),);

       try
        {
          
            targetValue=LatLng(currentLat2,currentLng2);
            Uint8List imageData=await getmarker();

           // var location=await _locationTracker.getLocation();
            updateLocationAndCircle(currentLat2,currentLng2, imageData);

            if(_locationSubcription14!=null)
                _locationSubcription14.cancel();

             _changeSetting14=await _locationTracker14.changeSettings();
                if(_changeSetting14)
                {

                    _locationTracker14.onLocationChanged.listen((LocationData currentLoc){

                        if(mapcontroller14!=null){
                        mapcontroller14.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
                          bearing: 1.12455,
                          target: LatLng(currentLoc.latitude,currentLoc.longitude),
                          tilt: 0,
                          zoom: 18.0)));
                          print(currentLoc.latitude);
                          updateLocationAndCircle(currentLoc.latitude,currentLoc.longitude, imageData);
                          
                      }
                    });
                }
            
        }
        catch(error)
        {

        }

  }

   void updateLocationAndCircle(double lat,double lng,Uint8List imageData)
    {
        LatLng latlng=LatLng(lat,lng);
        this.setState(() {
          currentlocationM14=Marker(
            markerId:MarkerId("userLocation"),
            position: latlng,
            draggable: false,
            flat: true,
            zIndex: 2,
            anchor: Offset(0.5,0.5),
            icon: BitmapDescriptor.fromBytes(imageData));
        });

         markerCircle14=Circle(
           circleId:CircleId("userclicle"),
           radius:15.0,
           zIndex: 1,
           strokeColor:Colors.blue,
           fillColor: Colors.blue.withAlpha(70),
           center: latlng );
    }

     Future<Uint8List> getmarker() async
    {
        ByteData bytedata=await DefaultAssetBundle.of(context).load('assets/currentLocationPin.png');
        return bytedata.buffer.asUint8List();
    }



  void getFrendPath(String seconduser)
  {

      List<String> user2=new List<String>();
      List<dynamic> pathlocation=new List<dynamic>();
      user2=[user,seconduser];
      String url=getPathRequest(user2);
      Future<dynamic> myfuture=getjsonvalue(url);
      myfuture.then((jsonplaceholder) => {
        if(isjsonResponseOk)
        {
          isjsonResponseOk=false,
          directionQeue.removeAt(0),
          pathlocation=getPathBwTowUser(jsonplaceholder),
          //0=>location (LatLng)
          //1=>time and distence
          //2=>200
          pathlocation.add(200),
          _loadinggetpath(context,pathlocation),
        }
          
      });
      
  }

  @override
  Widget build(BuildContext context) {

    if(!isFrist)
    {
         return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.txt,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 20,
            color: Colors.white,
          ),
          ),
          backgroundColor: firstColor,
        ),
        drawer:getSideBar(context, _keyLoader),
        body: Stack(
          children: <Widget>[

            Container(
              height: MediaQuery.of(context).size.height - 50.0,
              width: MediaQuery.of(context).size.width,
              child: 
              GoogleMap(
                  initialCameraPosition: CameraPosition(
                  target:targetValue,
                  zoom: 17.5, 
                  ), 
                  polylines: _polyline,
                  markers: Set.from(allMarker),
                  onMapCreated: mapCreated,
                  circles: Set.of((markerCircle14!=null)?[markerCircle14]:[]),
                ),
            ),

            
          
            Container(
               padding:EdgeInsets.all(16.0),
                child:Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    children: <Widget>[
                      button(_onDirectionButtonPress,Icons.directions),
                      SizedBox(height: 16.0)
                    ],
                  ),
                ),
            ),
             
          ],
        ),
      ),
    );
  }
  else
  {
       return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.txt,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 20,
            color: Colors.white,
          ),
          ),
          backgroundColor: firstColor,
        ),
        drawer:getSideBar(context, _keyLoader),
        body: Stack(
          children: <Widget>[

            Container(
              height: MediaQuery.of(context).size.height - 50.0,
              width: MediaQuery.of(context).size.width,
              child: 
              GoogleMap(
                  initialCameraPosition: CameraPosition(
                  target:targetValue,
                  zoom: 17.5, 
                  ), 
                  polylines: _polyline,
                  myLocationButtonEnabled: true,
                  markers: Set.from(allMarker),
                  onMapCreated: mapCreated,
                  circles: Set.of((markerCircle14!=null)?[markerCircle14]:[]),
                ),
            ),


              Container(
                padding: EdgeInsets.all(10.0),
                child: FractionallySizedBox(
                  widthFactor: 0.55,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: RaisedButton(
                      onPressed:null,
                      color: Colors.blue,
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:<Widget> [
                          Icon(Icons.directions_walk,
                          color: Colors.white),
                          Text(distenceAndTime,
                          style: TextStyle(color: Colors.white),textScaleFactor: 1.3,),
                          

                        ],
                      ) , ),
                  ),
                ),
              ),
              



            Container(
               padding:EdgeInsets.all(16.0),
                child:Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    children: <Widget>[
                      button(_onDirectionButtonPress,Icons.directions),
                      SizedBox(height: 16.0)
                    ],
                  ),
                ),
            ),
             
          ],
        ),
      ),
    );
  }
   
  }
  
  
  
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

   Future<void> _loadinggetpath(BuildContext context,List<dynamic> geolocation) async{
    try{
      Dialogs.showLoadingDialog(context,_keyLoader);
      await Future.delayed(Duration(seconds: 3,));
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();

      Navigator.push(context,MaterialPageRoute(builder: (context) =>Get2UserPath(geolocation)));
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

  Future<void> _handleManageFriends(BuildContext context) async{
    try{
      Dialogs.showLoadingDialog(context,_keyLoader);
      await Future.delayed(Duration(seconds: 3,));
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();

     // Navigator.push(context,MaterialPageRoute(builder: (context) => Managefriends()));
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
}