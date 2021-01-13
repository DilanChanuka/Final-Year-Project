import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:UorMap/Screens/Common/data.dart';
import 'package:UorMap/Screens/Common/placeLatLng.dart';
import 'package:UorMap/Screens/Direction/Direction_page.dart';
import 'dart:async';
import 'package:UorMap/constanents.dart';
import 'package:UorMap/Screens/Map/Logic/getfloor.dart';
import 'package:UorMap/Screens/Map/Display/Display_SideBar.dart';
import 'package:UorMap/Screens/Map/Display/Display_2User_Path.dart';
import 'package:UorMap/page_tran.dart';
import 'package:UorMap/Screens/Request/ConvertData.dart';
import 'package:UorMap/Screens/Map/Function/RealTimeULoc.dart';
import 'package:UorMap/Screens/Request/Location_shearing.dart';
import 'package:UorMap/Screens/Request/JsonBody.dart';


const String KEY=GOOGL_KEY;
const double CAMERA_ZOOM = 19.0;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;

List<dynamic> geolocation;
//0=> polyline
//1=>marker
List<dynamic> alldata;
  //0=> floor location
  //1=> floor all places
  //2=> floor ID ( 0 /1 /2)

 //or

    //0=>floor location
    //1=> required place
    //      0=>place name
    //      1=>lat
    //      2=>lng
    //2=>relevent places
    //3=>relevent floor id

int floorID=0;
String placeNameselected;
BitmapDescriptor destinationPIN12;
BitmapDescriptor startPIN;

class DrawFloor extends StatefulWidget
{

  DrawFloor(List<dynamic> data,String placeNameSelected)
  {
      //geolocation=getfloor(data,data[3]);
      //requirdPlaceLatLng=placeLatLng[placeNameSelected];
      alldata=data;
      floorID=data[3];
      placeNameselected=placeNameSelected;
  }

  final String txt= "UOR Map";

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
class _DrawState extends State<DrawFloor>
{

  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  List<Floor> _floor = Floor.getFloor();
  List<DropdownMenuItem<Floor>> _dropdownMenuitem;
  Floor _selectedFloor; 

  Map<MarkerId,Marker> markers=<MarkerId,Marker>{};
  final MarkerId markerId = MarkerId("specificPlcace");
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
          position: LatLng(alldata[1][1],alldata[1][2]),
          infoWindow: InfoWindow(title:alldata[1][0]),
          icon: destinationPIN12);


        setState(() {
          markers[markerId]=marker;
        });
    }

    void customMapPing() async{
        geolocation=getfloor(alldata,alldata[3]);
      destinationPIN12 =await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/destination_PIn.png');

        //geolocation=getfloor(alldata,alldata[3]);

    }
   

@override
void initState()
{
  _dropdownMenuitem = buildDropdownMenuItems(_floor).cast<DropdownMenuItem<Floor>>();
   customMapPing();
  _selectedFloor = _dropdownMenuitem[floorID].value;
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
    geolocation=getfloor(alldata,_selectedFloor.id);
 
  });
}

  static LatLng _center =LatLng(alldata[1][1],alldata[1][2]);
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;

static CameraPosition initialLocation = CameraPosition(
    bearing: CAMERA_BEARING,
    target:LatLng(alldata[1][1],alldata[1][2]),
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
      geolocation.clear();
      alldata.clear();
      Navigator.pop(context);
  }

  _onDirectionButtonPress()
  {
      geolocation.clear();
      alldata.clear();
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
        drawer:getSideBar(context, _keyLoader),
      
        body: Stack(
          children: <Widget>[

            GoogleMap(
                
                onMapCreated: _onMapCreated,
                initialCameraPosition:initialLocation,
                polylines: geolocation[0],
                markers:geolocation[1],             
                mapType: MapType.normal,
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