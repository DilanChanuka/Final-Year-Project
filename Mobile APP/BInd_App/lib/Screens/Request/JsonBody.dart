import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:UorMap/Screens/Common/data.dart';
//import 'dart.io';

 String josonArray;
 Future<String> getjsonvalue(String url) async
  {
      //String a="https://my.api.mockaroo.com/my_saved_schema.json?key=8699f700";
     try
     {
       final  http.Response data=await http.get(url);

       

        if(data.statusCode==200)
         {
           josonArray=data.body; 
           isjsonResponseOk=true;
           //data=null;
         }
     
     }catch(error)
     {
        print(error);
     }
      
    
      return josonArray;
  }
