import 'dart:async';
import 'package:http/http.dart' as http;
//import 'package:uor_road_map/Screens/Map/drwaplace.dart';

 bool responseValue=false;
 Future<bool> sendRequest(String url) async
  {
     // String a="https://my.api.mockaroo.com/my_saved_schema.json?key=8699f700";
     try
     {
        var data=await http.get(url);

        if(data.statusCode==200)
             responseValue=true;
        else
            responseValue=false;                  
     }catch(error)
     {
        print(error);
     }
      
    return responseValue;
      
  }
