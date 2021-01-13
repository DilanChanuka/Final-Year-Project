import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart';


 String josonArray;
 Future<String> getjsonvalue123(String url) async
  {
     // String a="https://my.api.mockaroo.com/my_saved_schema.json?key=8699f700";
      String josonArray;
     try
     {
        
        HttpClient client = new HttpClient();

      // final httpClient = createHttpClient();
     // final httpClient=new Client();
        //var response = await httpClient.read(url);

         // print(response);
        //json.decode(response.body);
           
       // Map data = JSON.decode(response);
    /*
        final request = await client.getUrl(Uri.parse(url));
       // request.headers.set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");

        final response = await request.close();

        response.transform(utf8.decoder).listen((contents) {
          print(contents);    
      });


      */
      /*
     await client.getUrl(Uri.parse(url))
    .then((HttpClientRequest request) 
    {
      // Optionally set up headers...
      // Optionally write to the request object...
      // Then call close.
      return request.close();

    }).then((HttpClientResponse response) 
    {
      // Process the response.
        
 
        //josonArray=response.toString();

           print(response);
           response.transform(utf8.decoder).listen((contents) 
           {
              print(contents); //josonArray=response.toString();
           });


    });

*/
     }catch(error)
     {
        print(error);
        
     }
      
    
      return josonArray;
  }
