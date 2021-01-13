import 'package:flutter/cupertino.dart';
import 'package:UorMap/Screens/Common/data.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:UorMap/Screens/Common/placeLatLng.dart';
import 'package:UorMap/Screens/Map/Display/Display_placeInout.dart';
import 'package:UorMap/Screens/Disition/disistionFunc.dart';

List<dynamic> placeInout(List<dynamic> data,int selectedFloorID,String startFname)
{
      //0=>outer routes
      //1=>floor routes
      //      0=>ground floor
      //      1=>first floor
      //      2=>second floor
      //2=>stair routes
      //      0=>stair 01
      //      1=>stair 12
      //3=>floor cordinates
      //      0=>ground floor
      //      1=>first floor
      //      2=>second floor

    List<dynamic> finaldata=new List<dynamic>();
     //this will hold marker
    Set<Marker> _marker={};

    //this will hold polylinefg
    Set<Polyline> _polyline={}; 
    List<double> startLocation=placeLatLng[startFName];
    int startFID=getsAdfloorID(startFName);
  

    List<int> flageFRoute=[1,1,1];
    List<int> flageStair=[1,1];
    
    if(selectedFloorID == 0 && data[0].length>0 )
    {
        //get outer routes
        if(data[0].length>0)  //selected floorID should be ground
        {
            Polyline outerR=Polyline(
              polylineId:PolylineId("outerR"),
              color: routeColor,
              width: routeWidth,
              points: data[0] );

              _polyline.add(outerR);
        }

    }

    if(data[3][selectedFloorID].length>0)
    {
        flageFRoute[selectedFloorID]=0;
        //add floor Routes
        if(data[1][selectedFloorID].length>0)
        {
             Polyline floorRoute=Polyline(
              polylineId:PolylineId("floorR"),
              color:routeColor,
              width: routeWidth,
              visible: true,
              points:data[1][selectedFloorID]);

              _polyline.add(floorRoute);
        }

        //add stair routes polyline
        if(selectedFloorID==2)
        {

          flageStair[1]=0;
          //stair12
          if(data[2][1].length>0)
          {
              Polyline stair12=Polyline(
                  polylineId:PolylineId("stair12"),
                  color: stairColor,
                  width:stairWidth,
                  points:data[2][1]);

                  _polyline.add(stair12);
          }
        }

        if(selectedFloorID==1)
        {
          flageStair[0]=0;
          //stair01
          if(data[2][0].length>0)
          {
              Polyline stair01=Polyline(
                  polylineId:PolylineId("stair01"),
                  color: stairColor,
                  width:stairWidth,
                  points:data[2][0]);

                  _polyline.add(stair01);
          }
        }
      

        //add floor polyline
        if(data[3][selectedFloorID].length>0)
        {
          Polyline floor1=Polyline(
              polylineId:PolylineId("floor1"),
              color: floorColor,
              width:floorWidth,
              points:data[3][selectedFloorID]);

              _polyline.add(floor1);
        }

      

       
    }


        //Start marker
        if(startLocation[0]!=null && selectedFloorID <= startFID)
        {
            _marker.add(Marker(
              markerId:MarkerId("start"),
              position:LatLng(startLocation[0],startLocation[1]),
              icon:userLocation ));
        }
        //Destination Marker
        if(data[0].length>0 &&  selectedFloorID <= startFID)  //selected floorId should be ground
        {
            int last=data[0].length-1;
            _marker.add(Marker(
              markerId:MarkerId("destination"),
              position: LatLng(data[0][last].latitude,data[0][last].longitude),
              icon:userDestination)
            
            );           
        }

    //get Dotted line
    if(selectedFloorID!=0)
    {
        //add outer route dotted Line
        if(data[0].length>0 && startFID>= selectedFloorID)
        {
            Polyline outerRDL=Polyline(
              polylineId:PolylineId("outerRPL"),
              color:routeColor,
              width: routeWidth,
              points:data[0],
              patterns: [PatternItem.dot,PatternItem.gap(10)]);
            
            _polyline.add(outerRDL);
        }
        
    }
    Polyline groundRPL; //ground Route Poly Line
    Polyline firstRPL;
    Polyline secondRPL;

    List<Polyline> floorRPL=[groundRPL,firstRPL,secondRPL];
    List<String> floorRID=["groundF","firstF","secondF"];
    for(int i=0;i<3;i++)
    {
        if(flageFRoute[i]>0)
        {
             if(data[1][i].length>0 && startFID>= selectedFloorID)
             {
                floorRPL[i]=Polyline(
                  polylineId:PolylineId(floorRID[i]),
                  color:routesDColor,
                  width: routeWidth,
                  points: data[1][i],
                  patterns: [PatternItem.dot,PatternItem.gap(10)] );

                _polyline.add(floorRPL[i]);
             }
        }
       
    }

    Polyline stair01;
    Polyline stair12;

    List<Polyline> stairName=[stair01,stair12];
    List<String> stairRID=["stair01","stair12"];
    for(int i=0;i<2;i++)
    {
        if(flageStair[i]>0)
        {
            if(data[2][i].length>0 && startFID>= selectedFloorID)
             {
                stairName[i]=Polyline(
                  polylineId:PolylineId(stairRID[i]),
                  color: stairDColor,
                  width: stairWidth,
                  points: data[2][i],
                  patterns: [PatternItem.dot,PatternItem.gap(10)]);

                _polyline.add(stairName[i]);
             }
        }
        
    }

      

    finaldata.add(_polyline);
    finaldata.add(_marker);

    return finaldata;

}


int getdestionationFloor(int id)
{
    if(groundFloor.contains(id))
        return 0;
    else if(firstFloor.contains(id))
        return 1;
    else if(secondFloor.contains(id))
        return 2;
    else
        return 1;
}
String getderection(int start,int end)
{
    if(start<end)
      return "UP";
    else if(start>end)
      return "DOWN";
    else if(start==end) //same floor
      return "NO";
    else
      return "NO";
}
