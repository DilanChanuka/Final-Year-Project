import 'package:UorMap/Screens/Direction/Direction_page.dart';
import 'package:UorMap/Screens/Map/Function/places.dart';
import 'package:UorMap/Screens/Welcome/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:UorMap/constanents.dart';
import 'package:UorMap/Screens/Map/Display/Display_SideBar.dart';
import 'package:UorMap/Screens/Search/search_page.dart';


class 
LogGuest extends StatefulWidget
{
  LogGuest() : super();

  final String txt= "Guest Access";
  @override
  LogGuestState createState() => LogGuestState();

}
class LogGuestState extends State<LogGuest>
{
  GoogleMapController controller;
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  MapType _currentMapType = MapType.normal;

  List<Marker> allMarker = [];

  @override
  void initState(){
    super.initState();
   // startTimeout();

    canteenplaces.forEach((element) async {
      allMarker.add(Marker(
        markerId: MarkerId(element.canteenname),
        position: element.canteendeplocationCoords,
        infoWindow: InfoWindow(title: element.canteenname),
        icon:await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(32.0,32.0)),'assets/images/3.png'),
      ));
    });
    medical.forEach((element) async { 
      allMarker.add(Marker(
        markerId:MarkerId(element.name),
        position: element.locationCoords,
        infoWindow: InfoWindow(title: element.name),
        icon:await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(32.0,32.0)),'assets/images/2.png'),
      ));
    });
    insideplaces.forEach((element) async { 
      allMarker.add(Marker(
        markerId:MarkerId(element.insidename),
        position: element.insidedeplocationCoords,
        infoWindow: InfoWindow(title: element.insidename),
        icon:await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(32.0,32.0)),'assets/images/4.png'),
      ));
    });
    readingplaces.forEach((element) async { 
      allMarker.add(Marker(
        markerId:MarkerId(element.readname),
        position: element.readdeplocationCoords,
        infoWindow: InfoWindow(title: element.readname),
        icon:await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(32.0,32.0)),'assets/images/5.png'),
      ));
    });
    departmentLoc.forEach((element) async { 
      allMarker.add(Marker(
        markerId:MarkerId(element.depname),
        position: element.deplocationCoords,
        infoWindow: InfoWindow(title: element.depname),
        icon:await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(32.0,32.0)),'assets/images/6.png'),
      ));
    });
    uorplaces.forEach((element) async { 
      allMarker.add(Marker(
        markerId:MarkerId(element.name),
        position: element.locationCoords,
        infoWindow: InfoWindow(title: element.name),
        icon:await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(32.0,32.0)),'assets/images/7.png'),
      ));
    });
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

  void _onSearchButtonPress()
  {
   // startTimeout();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context)=>SearchPage()));
    
  }

  void _onDirectionButtonPress()
  {
    //  startTimeout();
     Navigator.push(
       context,
       MaterialPageRoute(builder:(context)=>DirectionPage()));
  }
  
  void mapCreated(controller)
  {
    setState(() {
      controller = controller;
    });
  }
  
  void _goToPosition()
  {
  }

  @override
  Widget build(BuildContext context) {
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
          leading: IconButton(icon: Icon(
            Icons.arrow_back,
            size: MediaQuery.of(context).size.width / 15,
            color: mainColor,
            ),
             onPressed: () {
              Navigator.push(context,
              MaterialPageRoute(builder: (context)=>WelcomePage()));
             },
          ),
        ),
        drawer:getSideBar(context, _keyLoader),
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height - 50.0,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                  target: LatLng(5.9382181, 80.576216),
                  zoom: 18.5, 
                  ), 
                  markers: Set.from(allMarker),
                  onMapCreated: mapCreated,
                ),
            ),

            Container(
               padding:EdgeInsets.all(16.0),
                child:Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    children: <Widget>[
                      button(_goToPosition, Icons.location_searching),
                      SizedBox(height: 16.0,),

                      button(_onSearchButtonPress,Icons.search),
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
}