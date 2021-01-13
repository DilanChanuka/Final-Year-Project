import 'package:UorMap/Screens/Common/data.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

List<dynamic> placeWFloor(List<dynamic> data,int selectedFloorID)
{

    //0=>floor location
    //1=> required place
    //2=>relevent places
    //3=>floor id
    List<dynamic> finaldata=new List<dynamic>();
     //this will hold marker
    Set<Marker> _marker={};

    //this will hold polyline
    Set<Polyline> _polyline={}; 
  
    if(data[3]==selectedFloorID)
    {
        //get floor location polyline
        if(data[0].length>0)
        {
            Polyline floor=Polyline(
              polylineId:PolylineId("floor"),
              color: floorColor,
              width:floorWidth,
              points:data[0]);

              _polyline.add(floor);
        }

        //get all place Marker
        if(data[2].length>0)
        {
            int count=data[2].length;
            for(int i=0;i<count;i++)
            {
                _marker.add(Marker(
                  markerId:MarkerId(i.toString()),
                  infoWindow: InfoWindow(title:data[2][i][0]),
                  position:LatLng(data[2][i][1],data[2][i][2])));

            }

        }
        //get required place marker
        if(data[1].length>0)
        {
            _marker.add(Marker(
              markerId: MarkerId(data[1][0]),
              infoWindow: InfoWindow(title: data[1][0]),
              position: LatLng(data[1][1],data[1][2])));
          
        }

    }
  
    finaldata.add(_polyline);
    finaldata.add(_marker);
    return finaldata;

}


