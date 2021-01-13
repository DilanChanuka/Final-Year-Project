import 'package:UorMap/Screens/Common/data.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:UorMap/Screens/Common/placeLatLng.dart';
import 'package:UorMap/Screens/Map/Display/Display_PlaceInIn.dart';
import 'package:UorMap/Screens/Disition/disistionFunc.dart';

List<dynamic> placeInIn(List<dynamic> data,int destinationID,int start,int selectedFloorID,String startFName)
{
// 0=> 0=>floor Route
//          0=>ground floor
//          1=>first floor
//          2=>second floor
//     1=>stair route
//          0=>stair01
//          1=>stair12
//     2=>floor location
//          0=>ground floor
//          1=>first floor
//          2=>second floor
// 1=.place LatLng
// 2=>place Name

    List<dynamic> finaldata=new List<dynamic>();
     //this will hold marker
    Set<Marker> _marker={};

    //this will hold polyline
    Set<Polyline> _polyline={};
    
    List<int> flageFR=[1,1,1];
    List<int> flagestair=[1,1];
    
    int destFloor=getdestionationFloor(destinationID);  //get destination floor number(0/1/2)
  
    String derection=getderection(start,destFloor);  //get dierection (UP /DOWN)
    List<double> startLocation=placeLatLng[startFName]; //get start LatLng
    //int startfloorID=getfloorIdWithName(startFName);   //get start floorID using place Name

  if(data[0][2][selectedFloorID].length>0)
  {
      if(derection=="UP") 
      {
          //draw relevent floor route/ floor / and stair

          //add floor route polyline
          if(data[0][0][selectedFloorID].length>0)
          {
              flageFR[selectedFloorID]=0;
              Polyline routes=Polyline(
                polylineId:PolylineId("routes"),
                color: routeColor,
                width: routeWidth,
                points: data[0][0][selectedFloorID]);

                _polyline.add(routes);
          }

          //add floor location polyline
          if(data[0][2][selectedFloorID].length>0)
          {
              Polyline floor=Polyline(
                polylineId:PolylineId("floor"),
                color: floorColor,
                width: floorWidth,
                points: data[0][2][selectedFloorID]);

                _polyline.add(floor);
          }

          //add stair  polyline
          if(selectedFloorID==0)
          {
              //get stair01
              if(data[0][1][0].length>0)
              {
                  flagestair[0]=0;
                  Polyline stair01=Polyline(
                    polylineId:PolylineId("stair01"),
                    color: stairColor,
                    width: stairWidth,
                    points: data[0][1][0]);

                    _polyline.add(stair01);
              }
              
          }

          if(selectedFloorID==1)
          {
              //get stair12
              if(data[0][1][1].length>0)
              {   
                  flagestair[1]=0;
                  Polyline stair12=Polyline(
                    polylineId:PolylineId("stair12"),
                    color: stairColor,
                    width: stairWidth,
                    points: data[0][1][1]);

                    _polyline.add(stair12);
              }
              
          }    }
      else if(derection=="DOWN")
      {
          //draw relevent floor route/ floor / and stair

          //add floor route polyline
          if(data[0][0][selectedFloorID].length>0)
          {
              flageFR[selectedFloorID]=0;
              Polyline routes=Polyline(
                polylineId:PolylineId("routes"),
                color: routeColor,
                width: routeWidth,
                points: data[0][0][selectedFloorID]);

                _polyline.add(routes);
          }    
          //add floor location polyline
          if(data[0][2][selectedFloorID].length>0)
          {
              Polyline floor=Polyline(
                polylineId:PolylineId("floor"),
                color: floorColor,
                width: floorWidth,
                points: data[0][2][selectedFloorID]);

                _polyline.add(floor);
          }

          //add stair Polyline
          if(selectedFloorID==1)
          {
              //get stair01
              if(data[0][1][0].length>0)
              {
                  flagestair[0]=0;
                  Polyline stair01=Polyline(
                    polylineId:PolylineId("stair01"),
                    color: stairColor,
                    width: stairWidth,
                    points: data[0][1][0]);

                    _polyline.add(stair01);
              }
              
          }
          if(selectedFloorID==2)
          {
              //get stair12
              if(data[0][1][1].length>0)
              {
                  flagestair[1]=0;
                  Polyline stair12=Polyline(
                    polylineId:PolylineId("stair12"),
                    color: stairColor,
                    width: stairWidth,
                    points: data[0][1][1]);

                    _polyline.add(stair12);
              }
              
          }      }
      else if(derection=="NO")
      {
       
          //add floor and floor routes

          //add floor routes polyline
          if(data[0][0][selectedFloorID].length>0)
          {
            flageFR[selectedFloorID]=0;
            Polyline  routes=Polyline(
              polylineId:PolylineId("routes"),
              color: routeColor,
              width: routeWidth,
              points: data[0][0][selectedFloorID]);

             _polyline.add(routes);
          }

          //add floor polyline
          if(data[0][2][selectedFloorID].length>0)
          {
            Polyline floor=Polyline(
              polylineId:PolylineId("floor"),
              color: floorColor,
              width: floorWidth,
              points: data[0][2][selectedFloorID]);

              _polyline.add(floor);
          } }

      if(data[1].length>0)
      {
            //set map Marker
           _marker.add(Marker(
              markerId:MarkerId("destination"),
              position: LatLng(data[1][0], data[1][1]),
              icon:pinLocation,
            ));

      }
        
      if(startLocation!=null)
      {
            _marker.add(Marker(
              markerId:MarkerId("userlocation"),
              position: LatLng(startLocation[0], startLocation[1]),
              icon: userLocation,
              ));

      }   
     
  }
 
  Polyline groundRPL; //ground route poly line
  Polyline firstRPL;
  Polyline secondRPL;

  List<Polyline> floorname=[groundRPL,firstRPL,secondRPL];
  List<String> floorRID=["groundR","firstR","secondR"];
  //add Dotted Line
  for(int i=0;i<3;i++)
  {
      if(flageFR[i]>0 && isSelect(start,destFloor,selectedFloorID))
      {
          if(data[0][0][i].length>0)
          {
              floorname[i]=Polyline(
                polylineId:PolylineId(floorRID[i]),
                color: routesDColor,
                width: routeWidth,
                points:data[0][0][i],
                patterns: [PatternItem.dot,PatternItem.gap(10)]);

              _polyline.add(floorname[i]);
          }
      }
  }

  Polyline stair01RPL; //stair Route Poly line
  Polyline stair12RPL;

  List<Polyline> stairRName=[stair01RPL,stair12RPL];
  List<String> stairID=["stair01","stair12"];

  //dotted line for Stair
  for(int i=0;i<2;i++)
  {
      if(flagestair[i]>0 && isSelect(start,destFloor,selectedFloorID))
      {
            if(data[0][1][i].length>0)
            {
                stairRName[i]=Polyline(
                  polylineId:PolylineId(stairID[i]),
                  color: stairColor,
                  width: stairWidth,
                  points: data[0][1][i],
                  patterns: [PatternItem.dot,PatternItem.gap(10)]);

                _polyline.add(stairRName[i]);
            }
      }
  }
    finaldata.add(_polyline);
    finaldata.add(_marker);

    return finaldata;

}


bool isSelect(int startFloorID,int destFloorID,selectedFloorID)
{
    bool result=false;
    int deference=(startFloorID-destFloorID).abs();

    if(deference==2)
        result=true;
    else if(deference==0)
    {
        if(selectedFloorID==startFloorID || selectedFloorID==destFloorID)
              result=true;
    }
    else if(deference==1)
    {
        if(selectedFloorID==startFloorID || selectedFloorID==destFloorID)
              result=true;
    }

    return result;
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
