/*

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_interfaces/Screens/Common/data.dart';
import 'dart:async';
import 'package:map_interfaces/constanents.dart';
import 'package:map_interfaces/page_tran.dart';
import 'package:map_interfaces/Screens/Profile/PrifilePage.dart';
import 'package:map_interfaces/Screens/Map/Display/Display_SideBar.dart';


const String KEY=GOOGL_KEY;
const double CAMERA_ZOOM = 17.5;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;

List<dynamic> location;
//0=>geolocation (LatLng)
//1=>distence_Time

List<double> camaraLocation=new List<double>();
int floorID=0;

BitmapDescriptor sourceIcon;
BitmapDescriptor destinationIcon;

class DrawBwTowUserpath extends StatefulWidget
{


  DrawBwTowUserpath(List<dynamic> data)
  {   
      location=data;
  }

  final String txt= "UOR";
  @override
  
  State<StatefulWidget> createState(){
        return _DrawState();
  }

}
class Floor
{
  int id;
  String name;

  Floor(this.id,this.name);

  static List<Floor> getFloor(){
    return <Floor>[
    
      Floor(0, 'Ground Floor'),
      Floor(1, 'First Floor'),
      Floor(2, 'Second Floor'),
    ];
  
  
  }
}
class _DrawState extends State<DrawBwTowUserpath>
{
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  //List<Floor> _floor = Floor.getFloor();
  //List<DropdownMenuItem<Floor>> _dropdownMenuitem;
  //Floor _selectedFloor; 

    //this will hold marker
  Set<Marker> _marker={};
  Set<Polyline> _polyline={}; 
    

  GoogleMapController mapcontroller;
  Completer<GoogleMapController> _controller=Completer();
    
    //for my custom icon
    BitmapDescriptor sourceIcon;
    BitmapDescriptor destinationIcon;

  
    String key=KEY;

   void customMapPing() async{
      sourceIcon =await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/destination_PIn.png');

      destinationIcon=await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5,size: Size(0.5, 0.5)),
        'assets/userPin.png');
    }
     
    void _onMapCreated(GoogleMapController controller)
    {
        _controller.complete(controller);   
    }

    void createroutes()
    {
        List<LatLng> geolocation=new List<LatLng>();
        int n=location[0].length;
        for(int i=0;i<n;i++)
        {
            geolocation.add(LatLng(location[0][i][0],location[0][i][1]));
        }

        Polyline routes=Polyline(
          polylineId:PolylineId("routesBWFirends"),
          color:routeColor,
          width:routeWidth,
          points:geolocation );

          if(geolocation!=null)
            _polyline.add(routes);
    }

    void userPin()
    {
        _marker.add(Marker(
          markerId:MarkerId("Destination"),
          infoWindow: InfoWindow(title:"DEstination"),
          position:LatLng(location[0][0],location[0][1])
        ));
    }
    

@override
void initState()
{
 // _dropdownMenuitem = buildDropdownMenuItems(_floor).cast<DropdownMenuItem<Floor>>();
  //_selectedFloor = _dropdownMenuitem[floorID].value;
  customMapPing();
  createroutes();
  userPin();
  super.initState();
}

List<DropdownMenuItem<Floor>> buildDropdownMenuItems(List floors){
  List<DropdownMenuItem<Floor>> items = List();
  for(Floor floor in floors){
    items.add(
      DropdownMenuItem(
        value: floor, // have to change default selected floor value acoding to relevent floor
        child: Text(floor.name,style: TextStyle(fontSize: 25.0),),
        
      ),
    );
  }

  return items;
}

onChangeDropdwonItem(Floor selectedFloor){
  setState(() 
  {

  });
}

  static LatLng _center =LatLng(location[0][0],location[0][1]);
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;

static CameraPosition initialLocation = CameraPosition(
    bearing: CAMERA_BEARING,
    target:LatLng(location[0][0],location[0][1]),
    tilt: CAMERA_TILT,
    zoom: CAMERA_ZOOM,
  );

  Future<void> _goToPosition() async{
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(initialLocation),);
  }


  _onCamMove(CameraPosition position)
  {
    _lastMapPosition = position.target;
  }

  _onMapTypeButtonPressed()
  {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal 
      ? MapType.satellite 
      : MapType.normal;
    });
  }


   _onSearchButtonPress()
  {
     
  }

  _onDirectionButtonPress()
  {
     
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
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      home: Scaffold(    
          
        appBar: AppBar(
          title: Text(widget.txt,
          style: TextStyle(
            color: Colors.white,
          ),
          ),
          backgroundColor: firstColor,
          /*actions: <Widget>[
             SizedBox(width: 60.0,),
               DropdownButton(
                  iconSize: 25.0,
                  iconEnabledColor: mainColor,
                  value: _selectedFloor,
                  items: _dropdownMenuitem, 
                  onChanged: onChangeDropdwonItem,
                  ),
          ],
          */
        ),
        drawer:getSideBar(context, _keyLoader),
       
        body: Stack(
          children: <Widget>[
            
            Container(
              child:
              GoogleMap(                
                onMapCreated: _onMapCreated,
                initialCameraPosition:initialLocation,
                polylines:_polyline,
                markers:_marker,             
                mapType: MapType.normal,
                onCameraMove: _onCamMove,
                myLocationButtonEnabled: true,

              ),
            ),
                     
              Container(
               padding: EdgeInsets.all(10.0),
               child: Align(
                 alignment: Alignment.topLeft,
                 child: Column(
                   children: [
                     RaisedButton( 
                      onPressed:(){},
                     
                     )
                   ],
                 ),
                 ),
              ),

            
              
              Container(
                padding:EdgeInsets.all(16.0),
                child:Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    children: <Widget>[
                      button(_onMapTypeButtonPressed(), Icons.map),
                      SizedBox(height: 16.0),

                      button(_goToPosition, Icons.location_searching),
                      SizedBox(height: 16.0,),

                      button(_onSearchButtonPress,Icons.search),
                      SizedBox(height: 16.0),

                      button(_onDirectionButtonPress,Icons.directions),
                      SizedBox(height: 16.0)
                    ],
                  ),
                ),
              )
            
            
          ],
        ),
      ),
    );
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
    
     Future<void> _handleSubmitwelcome(BuildContext context) async{
    try{
      Dialogs.showLoadingDialog(context,_keyLoader);
      await Future.delayed(Duration(seconds: 3,));
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();

      //Navigator.push(context,MaterialPageRoute(builder: (context) => WelcomePage()));
    }
    catch(error){
      print(error);
    }
  }

}

*/