import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:UorMap/Screens/Common/data.dart';
import 'package:UorMap/Screens/Map/Logic/PlaceInOut.dart';
import 'dart:async';
import 'package:UorMap/constanents.dart';
import 'package:UorMap/Screens/Map/Display/Notification.dart';
import 'package:UorMap/Screens/Request/JsonBody.dart';
import 'package:UorMap/Screens/Search/search_page.dart';
import 'package:UorMap/Screens/Map/Display/Display_SideBar.dart';
import 'package:UorMap/Screens/Map/Display/Display_2User_Path.dart';
import 'package:UorMap/page_tran.dart';
import 'package:UorMap/Screens/Request/ConvertData.dart';
import 'package:UorMap/Screens/Map/Function/RealTimeULoc.dart';
import 'package:UorMap/Screens/Request/Location_shearing.dart';

const String KEY=GOOGL_KEY;
const double CAMERA_ZOOM = ZOOM;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;

List<dynamic> geolocation;
//0=> polyline
//1=.marker
List<dynamic> alldata;
      //0=>outer routes
      //1=>floor routes
      //      0=>ground floor
      //      0=>first floor
      //      0=>second floor
      //2=>stair routes
      //      0=>stair 01
      //      0=>stair 12
      //3=>floor cordinates
      //      0=>ground floor
      //      1=>first floor
      //      2=>second floor
int floorID=0;
String startFName;
BitmapDescriptor userDestination;
BitmapDescriptor userLocation;

class DrawPlaceInOut extends StatefulWidget
{

  DrawPlaceInOut(List<dynamic> data,int selectedfloorID,String startPlaceName)
  {   
      floorID=selectedfloorID;
      startFName=startPlaceName;
      geolocation=placeInout(data,selectedfloorID,startPlaceName);
      alldata=data;

      if(selectedfloorID!=0)
          message("Outer Place ...");
      
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
class _DrawState extends State<DrawPlaceInOut>
{
   final GlobalKey<State> _keyLoader = GlobalKey<State>();
  List<Floor> _floor = Floor.getFloor();
  List<DropdownMenuItem<Floor>> _dropdownMenuitem;
  Floor _selectedFloor; 

  Marker currentlocationM2;
  StreamSubscription _locationSubcription2;
  Location _locationTracker2= new Location();
  Circle markerCircle2;
  bool  _changeSetting2;

  GoogleMapController mapcontroller;
  Completer<GoogleMapController> _controller=Completer();
    
    //for my custom icon
    BitmapDescriptor sourceIcon;
    BitmapDescriptor destinationIcon;

    void _onMapCreated(GoogleMapController controller)
    {
        _controller.complete(controller);  
    }

   void customMapPing() async{
      userDestination =await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/destination_PIn.png');

      userLocation=await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5,size: Size(0.5, 0.5)),
        'assets/userPin.png');
    }

@override
void initState()
{
  _dropdownMenuitem = buildDropdownMenuItems(_floor).cast<DropdownMenuItem<Floor>>();
  _selectedFloor = _dropdownMenuitem[floorID].value;
  customMapPing();
  super.initState();
}

List<DropdownMenuItem<Floor>> buildDropdownMenuItems(List floors){
  List<DropdownMenuItem<Floor>> items = List();
  for(Floor floor in floors){
    items.add(
      DropdownMenuItem(
        value: floor, // have to change default selected floor value acoding to relevent floor
        
        child: Container(
          width: 110.0,
          height: 30.0,
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0), ),
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
          child: Text(floor.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: mainColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        
      ),
    );
  }

  return items;
}

onChangeDropdwonItem(Floor selectedFloor){
  setState(() 
  {
    _selectedFloor = selectedFloor;
    geolocation.clear();
    geolocation=placeInout(alldata,_selectedFloor.id,startFName);
    if(_selectedFloor.id!=0)
        message("Outer Place ...");
  });
}

  static LatLng _center =LatLng(alldata[0][0].latitude,alldata[0][1].longitude);
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;

static CameraPosition initialLocation = CameraPosition(
    bearing: CAMERA_BEARING,
    target:LatLng(alldata[0][0].latitude,alldata[0][1].longitude),
    tilt: CAMERA_TILT,
    zoom: CAMERA_ZOOM,
  );


  void updateLocationAndCircle(double lat,double lng,Uint8List imageData)
    {
        LatLng latlng=LatLng(lat,lng);
        this.setState(() {
          currentlocationM2=Marker(
            markerId:MarkerId("userLocation"),
            position: latlng,
            draggable: false,
            flat: true,
            zIndex: 2,
            anchor: Offset(0.5,0.5),
            icon: BitmapDescriptor.fromBytes(imageData));
        });

         markerCircle2=Circle(
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



  Future<void> _goToPosition() async{
   // final GoogleMapController controller = await _controller.future;
    //controller.animateCamera(CameraUpdate.newCameraPosition(initialLocation),);

    
      try
        {
        
            Uint8List imageData=await getmarker();

           // var location=await _locationTracker.getLocation();
            updateLocationAndCircle(currentLat2,currentLng2, imageData);

            if(_locationSubcription2!=null)
                _locationSubcription2.cancel();

             _changeSetting2=await _locationTracker2.changeSettings();
                if(_changeSetting2)
                {

                    _locationTracker2.onLocationChanged.listen((LocationData currentLoc){

                        if(mapcontroller!=null){
                        mapcontroller.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
                          bearing: 1.12455,
                          target: LatLng(currentLoc.latitude,currentLoc.longitude),
                          tilt: 0,
                          zoom: 15.0)));
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


  _onCamMove(CameraPosition position)
  {
    _lastMapPosition = position.target;
  }



  _onLocationSherInOut()
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
 

   _onSearchButtonPress()
  {
      geolocation.clear();
      alldata.clear();
      Navigator.push(
        context,
        MaterialPageRoute(builder:(context)=>SearchPage()));
  }

  _onDirectionButtonPress()
  {
      geolocation.clear();
      alldata.clear();
      josonArray="";
      Navigator.pop(context);
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
               DropdownButton(
                  dropdownColor: Colors.transparent,
                  iconSize: 25.0,
                  iconEnabledColor: mainColor,
                  value: _selectedFloor,
                  items: _dropdownMenuitem, 
                  onChanged: onChangeDropdwonItem,
                  ),
          ],
        ),
        drawer: getSideBar(context, _keyLoader),
       
        body: Stack(
          children: <Widget>[
 
            GoogleMap(
                
                onMapCreated:(GoogleMapController controller){
                   mapcontroller=controller;
                },
                initialCameraPosition:initialLocation,
                polylines: geolocation[0],
                markers:geolocation[1],             
                mapType: MapType.normal,
                onCameraMove: _onCamMove,
                myLocationButtonEnabled: true,
                circles: Set.of((markerCircle2!=null)?[markerCircle2]:[]),

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
                          Text(alldata[4][1].toString()+"min("+alldata[4][0].toString()+"m)",
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
                      button(_onLocationSherInOut, Icons.person_pin),
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