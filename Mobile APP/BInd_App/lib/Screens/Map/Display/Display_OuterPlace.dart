import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:UorMap/Screens/Common/data.dart';
import 'package:UorMap/Screens/Common/placeLatLng.dart';
import 'package:UorMap/Screens/Direction/Direction_page.dart';
import 'package:UorMap/Screens/Map/Display/Display_getfloor.dart';
import 'dart:async';
import 'package:UorMap/constanents.dart';
import 'package:UorMap/Screens/Map/Display/Display_SideBar.dart';
import 'package:UorMap/Screens/Map/Display/Display_2User_Path.dart';
import 'package:UorMap/page_tran.dart';
import 'package:UorMap/Screens/Request/ConvertData.dart';
import 'package:UorMap/Screens/Map/Function/RealTimeULoc.dart';
import 'package:UorMap/Screens/Request/Location_shearing.dart';
import 'package:UorMap/Screens/Request/JsonBody.dart';


const String KEY=GOOGL_KEY;
const double CAMERA_ZOOM = 18;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;

int floorID=0;
String placeName1;
BitmapDescriptor destinationPIN;
List<double> markerLocation=new List<double>();
Set<Marker> _marker={};

class DisplayOuterPlace extends StatefulWidget
{

  DisplayOuterPlace(String placeNameSelected)
  {
    
      placeName1=placeNameSelected;
      markerLocation=placeLatLng[placeNameSelected];
  }

  final String txt= "Search Any place";

  @override 
  State<StatefulWidget> createState(){
        return _DrawState();
  }

}

class _DrawState extends State<DisplayOuterPlace>
{

  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  List<Floor> _floor = Floor.getFloor();
  List<DropdownMenuItem<Floor>> _dropdownMenuitem;
  Floor _selectedFloor; 
  Map<MarkerId,Marker> markers=<MarkerId,Marker>{};
  final MarkerId markerId = MarkerId("serchPlace");

  GoogleMapController mapcontroller;
  Completer<GoogleMapController> _controller=Completer();
    
    //for my custom icon
    BitmapDescriptor sourceIcon;
    BitmapDescriptor destinationIcon;


    void _onMapCreated(GoogleMapController controller)
    {
        _controller.complete(controller);  

        //Create a new marker
        final Marker marker=Marker(
          markerId:markerId,
          position: LatLng(markerLocation[0],markerLocation[1]),
          infoWindow: InfoWindow(title: placeName1),
          );


        setState(() {
          markers[markerId]=marker;
        });
       // setMapPin();
    }

    void setMapPin(){

        _marker.add(Marker(
          markerId:MarkerId("place"),
          position: LatLng(markerLocation[0],markerLocation[1]),
          infoWindow: InfoWindow(title:placeName1)));
    }

    void customMapPing() async{
      destinationPIN =await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/destination_PIn.png');
    }
   

    

@override
void initState()
{

  // customMapPing();
   super.initState();
}



  static LatLng _center =LatLng(markerLocation[0],markerLocation[1]);
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;

final CameraPosition initialLocation = CameraPosition(
    bearing: CAMERA_BEARING,
    target:LatLng(markerLocation[0],markerLocation[1]),
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
   
      //in this i have to tern on user location system
      
      List<dynamic> frendData=new List<dynamic>();
      List<dynamic> frendList=new List<dynamic>();
      String url=getFirendLocationRequest(user);
      Future<dynamic> myfuture=getjsonvalue(url);
      myfuture.then((jsonresponse) => {
            frendList=getUserLocations(jsonresponse),
            frendData.add(frendList),
            frendData.add(400),//this use for inform frend location 
            _loadingshireLocation(context,frendData),
      });

  }

  _onAddMarkerButtonPressed()
  {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: "Your posistion",
          //snippet: "snippet",
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  _onSearchButtonPress()
  {
      markerLocation.clear();
      Navigator.pop(context);
      
  }

  _onDirectionButtonPress()
  {
      markerLocation.clear();
      Navigator.push(
        context,
        MaterialPageRoute(builder:(context)=>DirectionPage()));
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
          actions: <Widget>[
             SizedBox(width: 60.0,),
            
          ],
        ),
        drawer:getSideBar(context, _keyLoader),
        
        body: Stack(
          children: <Widget>[

            GoogleMap(
                
                onMapCreated: _onMapCreated,
                initialCameraPosition:initialLocation,  
                markers: Set<Marker>.of(markers.values),        
                mapType:_currentMapType,
                onCameraMove: _onCamMove,
                myLocationButtonEnabled: true,

              ),

              Padding(
                padding: EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    children: <Widget>[
                      button(_onMapTypeButtonPressed, Icons.person_pin),
                      SizedBox(height: 16.0, 
                      ),
                      button(_onAddMarkerButtonPressed, Icons.add_location),
                      SizedBox(
                        height: 16.0,
                      ),
                      button(_goToPosition, Icons.location_searching),
                      SizedBox(height: 16.0),
                      button(_onSearchButtonPress, Icons.search),
                      SizedBox(height: 16.0),
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
  

       Future<void> _loadingshireLocation(BuildContext context,List<dynamic> firends) async{
    try{
      Dialogs.showLoadingDialog(context,_keyLoader);
      await Future.delayed(Duration(seconds: 3,));
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();

      Navigator.push(context,MaterialPageRoute(builder: (context) => Get2UserPath(firends)));
    }
    catch(error){
      print(error);
    }
  }


}