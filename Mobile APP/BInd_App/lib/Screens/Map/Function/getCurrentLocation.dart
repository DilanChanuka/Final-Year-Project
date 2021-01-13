
import 'package:location/location.dart';

Location location =new Location();
double lat=0.0,lng=0.0;

Future<List<double>>  getcurrentLocation154() async
{
      bool _changeSetting;
      //bool _serviceEnabled;
      //PermissionStatus _permissionGranted;
      LocationData _locationData122;
      List<double> data122;

   
     // _permissionGranted=await location.hasPermission();

      /*if(_permissionGranted ==PermissionStatus.denied)
        {
              _permissionGranted=await location.requestPermission();
              if(_permissionGranted!=PermissionStatus.granted){
                
              }
                    
        }
*/
        _changeSetting=await location.changeSettings();

        if(_changeSetting)
        {
            _locationData122=await location.getLocation();
            
            lat=_locationData122.latitude;
            lng=_locationData122.longitude;
      
            data122=[lat,lng];
        }    

      print(data122);

     return data122;
}