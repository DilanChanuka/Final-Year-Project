import 'package:UorMap/Screens/Map/Display/Display_OuterRoutes.dart';
import 'package:UorMap/Screens/Common/data.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


List<dynamic> getOuterRoutes(List<dynamic> data,int selectedfloorid,List<dynamic> startAendL)
{

    //0=>routetsLocation
    //1=> 0=>Distence
    //    1=>Time

        //startAendL ==>
        // 0=>startlocation  0=>lat
        //                   1=>lng
        //1=>destination Place Name
        //2=>department
        //3=>floor Name
        //4=> f or v
        //5=>0 or 1  (0=> not user location   1=> user location)
      
     //this will hold marker
    Set<Marker> _marker={};

    //this will hold polyline
    Set<Polyline> _polyline={}; 
    

    if(data[0].length>0 && selectedfloorid==0)
    { 

        if(true)
        {
         //source ping
          _marker.add(Marker(
            markerId:MarkerId('source'),
            infoWindow: InfoWindow(title: "Start Location"),
            position: LatLng(data[0][0].latitude, data[0][0].longitude),
            icon: sourceIcon,
            ));

          //destination pin
          _marker.add(Marker(
            markerId:MarkerId('destination'),
            infoWindow: InfoWindow(title: startAendL[1]),
            position: LatLng(data[0][data[0].length-1].latitude, data[0][data[0].length-1].longitude),
            icon: destinationIcon
             ));
       
        }

          Polyline routes=Polyline(
                 polylineId:PolylineId("route"),
                 color:routeColor,
                 points: data[0]
                );
                        
                _polyline.add(routes);           
        
    }
   
    if(startAendL[5]==1)
    {
          //get google map polylines
         // _polyline.add(startAendL[0][1]);
    }
    
    List<dynamic> finalData=new List<dynamic>();
    finalData.add(_polyline);
    finalData.add(_marker);

    isSendOuterRoutes=true;

    return finalData;
}


