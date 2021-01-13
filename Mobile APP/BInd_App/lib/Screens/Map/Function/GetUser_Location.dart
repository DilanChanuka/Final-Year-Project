import 'package:UorMap/Screens/Common/data.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';
import 'package:UorMap/Screens/Common/Distence_Calculation.dart';

Location location =new Location();
double lat=0.0,lng=0.0;

List<double> userCurrentLocation23=new List<double>();
// this is the key object - the PolylinePoints
// which generates every polyline between start and finish
//PolylinePoints polylinePoints = PolylinePoints();
//List<LatLng> googlemapCordinates=[];
List<dynamic> data=new List<dynamic>();



Future<List<dynamic>>  getUserLocation123() async
{
     
     /*
      bool _changeSetting;
      //bool _serviceEnabled;
      PermissionStatus _permissionGranted;
      LocationData _locationData;

    /*  _serviceEnabled=await location.serviceEnabled();

      if(!_serviceEnabled)
      {
          _serviceEnabled=await location.requestService();
          if(!_serviceEnabled){

          }
                
      }
*/
      _permissionGranted=await location.hasPermission();
      if(_permissionGranted ==PermissionStatus.denied)
        {
              _permissionGranted=await location.requestPermission();
              if(_permissionGranted!=PermissionStatus.granted){
                
              }
                    
        }

        _changeSetting=await location.changeSettings();

        if(_changeSetting)
        {
            _locationData=await location.getLocation();
            
            lat=_locationData.latitude;
            lng=_locationData.longitude;
        

            userCurrentLocation23.add(lat);
            userCurrentLocation23.add(lng);

            data.add(userCurrentLocation23);
        }

        
        if(isNotUniversity(userCurrentLocation23))
        {
             // Get google map polyline
            List<PointLatLng> result=await
            polylinePoints?.getRouteBetweenCoordinates(
            GOOGL_KEY,
            userCurrentLocation23[0],
            userCurrentLocation23[1],
            5.937777,
            80.574449);

          if(result.isNotEmpty)
          {
            // loop through all PointLatLng points and convert them
            // to a list of LatLng, required by the Polyline

            result.forEach((PointLatLng points) 
            { 
                googlemapCordinates.add(
                  LatLng(points.latitude,points.longitude)
                );              
            });

            if(googlemapCordinates!=null)
            {
                Polyline googlemapRoutes=Polyline(
                  polylineId:PolylineId("goglemapR"),
                  color:routeColor,
                  points:googlemapCordinates,
                  width: routeWidth);

                data.add(googlemapRoutes);
            }
            
          }

        }
        else{
          //user sitting in inside of unversity
          //therfore not  get google map support
          data.add(0);  //add zero value 
        }

  
     //0=>user location LatLng
     //1=>google map polyline
     return data;

    */
}


