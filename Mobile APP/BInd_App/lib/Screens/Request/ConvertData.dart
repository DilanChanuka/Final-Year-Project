import 'dart:convert';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:UorMap/Screens/Common/data.dart';

 

List<dynamic> drawroute(String jsonplaceholder)   //getroute   ---
{

  var jsonresponse=json.decode(jsonplaceholder)['routelocations'];
  var distence_time=json.decode(jsonplaceholder)["distance_time"];
  
  List<dynamic> data=new List<dynamic>();
  List<LatLng> routesLocation=new List<LatLng>();
  int n=jsonresponse.length;


    for(int i=0;i<n;i++)
    {
        routesLocation.add(LatLng(jsonresponse[i][0],jsonresponse[i][1]));
    }

    //if(jsonresponse==null)
        

    data.add(routesLocation);
    data.add(distence_time);

    return data;
   
}

List<dynamic> drawfloor(String jsonplaceholder)   //getfloor
{

    var jsonresponse=json.decode(jsonplaceholder);
    var floor0array = jsonresponse["floor_0_locations"];
    var floor1array = jsonresponse["floor_1_locations"];
    var floor2array = jsonresponse["floor_2_locations"];
    var places = jsonresponse["places"];  //this will come places array
   

    List<dynamic> finalarray=new List<dynamic>();

    List<String> floorlocation=["floor_0_locations","floor_1_locations","floor_2_locations"];

    int numPlaces=places.length;
    int floorID=0;
    List<List<dynamic>> allplaces=new List<List<dynamic>>();
    List<LatLng> floor00=[];
    List<LatLng> floor01=[];
    List<LatLng> floor02=[];
    List<dynamic> floor=[floor00,floor01,floor02];
    

    //get floor geolocation
    for(int j=0;j<3;j++)
    {
         if(jsonresponse[floorlocation[j]]!=null)
         {
            int n=jsonresponse[floorlocation[j]].length;
            for(int i=0;i<n;i++)
            {
                floor[j].add(LatLng(jsonresponse[floorlocation[j]][i][0],jsonresponse[floorlocation[j]][i][1]));
            }
            floorID=j;
            finalarray.add(floor[j]);
            
         }

    }


  //get places
  if(numPlaces!=null)
  {
      for(int i=0;i<numPlaces;i++)
      {   
          String name;
          double lat,lng;
          Map<String,dynamic> map=places[i];
          name=places[i]["name"];
          lat=places[i]["lat"];
          lng=places[i]["lon"];

          List<dynamic> oneplace=new List<dynamic>();
          oneplace.add(name);
          oneplace.add(lat);
          oneplace.add(lng);

          allplaces.add(oneplace);
          
      }
  }
  
  finalarray.add(allplaces);
  finalarray.add(floorID);
  //0=> floor location
  //1=> floor all places
  //2=> floor ID ( 0 /1 /2)
  return finalarray;
    
}

List<dynamic> drawplaceinout(String response) //getplaceinout
{



    var jsonresponse=json.decode(response);
    List<LatLng> finalDataArray=[];
    List<LatLng> finalFloorDataArray=[];
  
          var floor0RL = jsonresponse["floor_0_routelocations"];
          var floor1RL = jsonresponse["floor_1_routelocations"];
          var floor2RL = jsonresponse["floor_2_routelocations"];
          var floor0array = jsonresponse["floor_0_locations"];
          var floor1array = jsonresponse["floor_1_locations"];
          var floor2array = jsonresponse["floor_2_locations"];
          var stair01 = jsonresponse["stair_0_1_locations"];
          var stair12 = jsonresponse["stair_1_2_locations"];
          var outerR = jsonresponse["outerroutelocations"];
          var distence_time=jsonresponse["distance_time"];
          
          

          List<String> floorlocation=["floor_0_locations","floor_1_locations","floor_2_locations"];
          List<String> floorRL=["floor_0_routelocations","floor_1_routelocations","floor_2_routelocations"];
          List<String> stairRL=["stair_0_1_locations","stair_1_2_locations"];
 

          List<LatLng> floor0R=[];
          List<LatLng> floor1R=[];
          List<LatLng> floor2R=[];

          List<LatLng> stair01R=[];
          List<LatLng> stair12R=[];

          List<LatLng> floor0=[];
          List<LatLng> floor1=[];
          List<LatLng> floor2=[];

          List<LatLng> finalouterR=[];

          List<dynamic> floorRC=[floor0R,floor1R,floor2R];
          List<dynamic> stairC=[stair01R,stair12R];
          List<dynamic> floorC=[floor0,floor1,floor2];

          //get outer route
          // outer routes must comr from json array
          if(outerR!=null)
          { 
              double a,b;
              for(int i=0;i<outerR.length;i++)
              { 
                a=outerR[i][0];
                b=outerR[i][1];
                finalouterR.add(LatLng(a,b));
              }
          }
         
         //get inner routes
         for(int i=0;i<3;i++)
         {
            
            if(jsonresponse[floorRL[i]]!=null)
            {
                int n=jsonresponse[floorRL[i]].length;
                for(int j=0;j<n;j++)
                {
                    floorRC[i].add(LatLng(jsonresponse[floorRL[i]][j][0],jsonresponse[floorRL[i]][j][1]));
                }
            }
         }

         //get stair routes

         for(int i=0;i<2;i++)
         {
           if(jsonresponse[stairRL[i]]!=null)
           {

              /*
              //check if there are floor routes
              if(floorRC[i+1].length>0)
              {
                  //add last location as stair one location (join stair and floor)
                  stairC.add(floorRC[i+1]);
              }
              else if(jsonresponse[stairRL[0]].length>0 && jsonresponse[stairRL[1]].length>0)
              {
                  //join stair12 last value  as stair01  first value
                  int last=jsonresponse[stairRL[1]].length;
                  stairC[0].add(jsonresponse[stairRL[1]][last]);
              }
              */
              int n=jsonresponse[stairRL[i]].length;
              for(int j=0;j<n;j++)
              {
                  stairC[i].add(LatLng(jsonresponse[stairRL[i]][j][0],jsonresponse[stairRL[i]][j][1]));
              }

           }
         }

        //get floor 
           for(int i=0;i<3;i++)
         {
            
            if(jsonresponse[floorlocation[i]]!=null)
            {
                int n=jsonresponse[floorlocation[i]].length;
                for(int j=0;j<n;j++)
                {
                    floorC[i].add(LatLng(jsonresponse[floorlocation[i]][j][0],jsonresponse[floorlocation[i]][j][1]));
                }
            }
         }

   
      List<dynamic> allData=[];
      allData.add(finalouterR);
      allData.add(floorRC);
      allData.add(stairC);
      allData.add(floorC);
      allData.add(distence_time);

      //0=>outer routes
      //1=>floor routes
      //      0=>ground floor
      //      0=>first floor
      //      0=>second floor
      //2=>stair routes
      //      0=>stair 01
      //      0=>stair 12
      //3=>floor cordinates
      //      0=>ground floor
      //      1=>first floor
      //      2=>second floor
     return allData;
}

List<dynamic> drawplaceinin(String url) //getplaceinin
{
    
    var jsonresponse=json.decode(url);

    var floor0location = jsonresponse["floor_0_locations"];
    var floor1location = jsonresponse["floor_1_locations"];
    var floor2location = jsonresponse["floor_2_locations"];
    var floor0Routelocation = jsonresponse["floor_0_routelocations"];
    var floor1Routelocation = jsonresponse["floor_1_routelocations"];
    var floor2Routelocation = jsonresponse["floor_2_routelocations"];
    var stair12location = jsonresponse["stair_1_2_locations"];
    var stair01location = jsonresponse["stair_0_1_locations"];
    var place=jsonresponse["place"];
    var distence_time=jsonresponse["distance_time"];

    String name;
    double lat,lng;
    String derection;

    List<LatLng> finalRouteArray=[];
    List<LatLng> finalStairArray=[];
    List<LatLng> finalFloorLocation=[]; //relevent selected floor id

    List<String> floorlocation=["floor_0_locations","floor_1_locations","floor_2_locations"];
    List<String> floorRlocation=["floor_0_routelocations","floor_1_routelocations","floor_2_routelocations"];
    List<String> stair=["stair_0_1_locations","stair_1_2_locations"];

    List<LatLng> floor0R=[];
    List<LatLng> floor1R=[];
    List<LatLng> floor2R=[];
    List<dynamic> floors=[floor0R,floor1R,floor2R];

    List<LatLng> floor0L=[];
    List<LatLng> floor1L=[];
    List<LatLng> floor2L=[];
    List<dynamic> floorLo=[floor0L,floor1L,floor2L];

    List<LatLng> stair01=[];
    List<LatLng> stair12=[];
    List<dynamic> stairArray=[stair01,stair12];

   // int destFloor=getdestionationFloor(destinationID);  //get destination floor number(0/1/2)
   // derection=getderection(start,destFloor);  //get dierection (UP /DOWN)
   // int diference=(destFloor-start).abs();

    if(stair12location!=null || stair01location!=null) //check user wants to stair
    {
        //get stair01 location data for LatLng array
        if(stair01location!=null)       
        {

            for(int i=0;i<stair01location.length;i++)
            {
                double a=jsonresponse["stair_0_1_locations"][i][0];
                double b=jsonresponse["stair_0_1_locations"][i][1];
                stair01.add(LatLng(a,b));
            }
        }    

        //get stair12 location data for latLng array
       if(stair12location!=null)
        {

            for(int i=0;i<stair12location.length;i++)
            {
                double a=jsonresponse["stair_1_2_locations"][i][0];
                double b=jsonresponse["stair_1_2_locations"][i][1];
                stair12.add(LatLng(a,b));
            }
        }   
    }

    List<int> length=[getArraylength(jsonresponse[floorRlocation[0]]),
    getArraylength(jsonresponse[floorRlocation[1]]),
    getArraylength(jsonresponse[floorRlocation[2]])];

    List<int> fLLength=[getFLLength(jsonresponse[floorlocation[0]]),
    getFLLength(jsonresponse[floorlocation[1]]),
    getFLLength(jsonresponse[floorlocation[2]])];

    

    //get floor Rutes 
    for(int i=0;i<3;i++)
    {
       if(jsonresponse[floorRlocation[i]]!=null)
       {
          int n=jsonresponse[floorRlocation[i]].length;
          for(int j=0;j<n;j++)
          {
             floors[i].add(LatLng(jsonresponse[floorRlocation[i]][j][0],jsonresponse[floorRlocation[i]][j][1]));
          }
       }
    }

    //get floor
    for(int i=0;i<3;i++)
    {
       if(jsonresponse[floorlocation[i]]!=null)
       {
          int n=jsonresponse[floorlocation[i]].length;
          for(int j=0;j<n;j++)
          {
             floorLo[i].add(LatLng(jsonresponse[floorlocation[i]][j][0],jsonresponse[floorlocation[i]][j][1]));
          }
       }
    }

     //get place details
          if(place.length>0)
          {
                Map<String,dynamic> map=place;
                name=map["name"];
                lat=map["lat"];
                lng=map["lon"];
          }

 
  
    List<dynamic> arr=[];
    arr.add(floors);
    if(finalStairArray!=null)
      arr.add(stairArray);
    if(finalFloorLocation!=null)
      arr.add(floorLo);


    List<double> placeLatLng=[lat,lng];

    List<dynamic> allDetails=[arr,placeLatLng,name];
    allDetails.add(distence_time);

    return allDetails;
}

List<dynamic> drawplace(String jsonplaceholder)  //getplace
{

        
      var jsonresponse=json.decode(jsonplaceholder);

      var floor0R=jsonresponse['floor_0_routelocations'];
      var floor1R=jsonresponse['floor_1_routelocations'];
      var floor2R=jsonresponse['floor_2_routelocations'];
      var outerR=jsonresponse['outerroutelocations'];
      var floor2L=jsonresponse['floor_2_locations'];
      var floor1L=jsonresponse['floor_1_locations'];
      var floor0L=jsonresponse['floor_0_locations'];
      var stair01=jsonresponse['stair_0_1_locations'];
      var stair12=jsonresponse['stair_1_2_locations'];
      var place=jsonresponse["place"];
      var distence_time=jsonresponse["distance_time"];

      List<String> floorlocation=["floor_0_locations","floor_1_locations","floor_2_locations"];
      List<String> floorRL=["floor_0_routelocations","floor_1_routelocations","floor_2_routelocations"];
      List<String> stairRL=["stair_0_1_locations","stair_1_2_locations"];
    
      String name;
      double lat,lng;

      List<LatLng> finalFloor0R=[];
      List<LatLng> finalFloor1R=[];
      List<LatLng> finalFloor2R=[];

      List<LatLng> finalOuterR=[];

      List<LatLng> finalStair01=[];
      List<LatLng> finalStair12=[];

      List<LatLng> finalFloor0=[];
      List<LatLng> finalFloor1=[];
      List<LatLng> finalFloor2=[];
      
      List<dynamic> routes=[finalFloor0R,finalFloor1R,finalFloor2R];
      List<dynamic> stair=[finalStair01,finalStair12];
      List<dynamic> floor=[finalFloor0,finalFloor1,finalFloor2];

        //get place details
        if(place.length>0)
        {         
            if(place!=null){
                Map<String,dynamic> map=place;
                name=map["name"];
                lat=map["lat"];
                lng=map["lon"];
            }  
        }
      List<dynamic> placeDetails=[name,lat,lng];

      //get outer route
      if(outerR!=null)
      {
           double a,b;
          for(int i=0;i<outerR.length;i++)  
          {
              a=outerR[i][0];
              b=outerR[i][1];
              finalOuterR.add(LatLng(a,b));
          }
      }
     

      //get inner routes
      for(int i=0;i<3;i++)
      {
         if(jsonresponse[floorRL[i]]!=null)
         {
            int n=jsonresponse[floorRL[i]].length;
            for(int j=0;j<n;j++)
            {
               routes[i].add(LatLng(jsonresponse[floorRL[i]][j][0],jsonresponse[floorRL[i]][j][1]));
            }
         }
      }

      //get floor
      for(int i=0;i<3;i++)
      {
         if(jsonresponse[floorlocation[i]]!=null)
         {
            int n=jsonresponse[floorlocation[i]].length;
            for(int j=0;j<n;j++)
            {
               floor[i].add(LatLng(jsonresponse[floorlocation[i]][j][0],jsonresponse[floorlocation[i]][j][1]));
            }
         }
      }

      //get stair
      for(int i=0;i<2;i++)
      {
         if(jsonresponse[stairRL[i]]!=null)
         {

            int n=jsonresponse[stairRL[i]].length;
            for(int j=0;j<n;j++)
            {
               stair[i].add(LatLng(jsonresponse[stairRL[i]][j][0],jsonresponse[stairRL[i]][j][1]));
            }
         }
      }
      
      List<dynamic> allData=[];
      allData.add(finalOuterR);
      allData.add(routes);
      allData.add(stair);
      allData.add(floor);
      allData.add(placeDetails);
      allData.add(distence_time);
      
      return allData;
}

List<dynamic> getUserLocations(String jsonplaceholder)
{
    List<dynamic> firendDetails=new List<dynamic>();
    String username;
    double lat,lng;

    var jsonresponse=json.decode(jsonplaceholder);
    var friends2=jsonresponse['friends'];
    
    if(friends2.length>0)
    {
        for(int i=0;i<friends2.length;i++)
        {
            Map<String,dynamic> mapfrend=friends2[i];
            username=mapfrend["username"];
            lat=mapfrend["lat"];
            lng=mapfrend["lon"];
            
            List<dynamic> oneFirend=new List<dynamic>();
            oneFirend.add(username);
            oneFirend.add(LatLng(lat,lng));

            firendDetails.add(oneFirend);
           

        }
    }
    
    return firendDetails;
}

List<dynamic> getPathBwTowUser(String jsonplaceholder)
{
    var jsonresponse=json.decode(jsonplaceholder);
    var distenceTime=jsonresponse['distance_time'];
    var route=jsonresponse['routelocations'];

    List<dynamic> finaldata=new List<dynamic>();
    List<dynamic> data=new List<dynamic>();
    List<LatLng> routesLocation=new List<LatLng>();

    //get routes location
    if(route.length>0)
    {
        for(int i=0;i<route.length;i++)
        {
            routesLocation.add(LatLng(route[i][0],route[i][1]));
        }

        data.add(routesLocation);
        data.add(distenceTime);

        finaldata.add(data);
    }

    return finaldata;
    //0=>location (LatLng)
    //1=>time and distence
}


List<dynamic> getManageFirend(String jsonplaceholder)
{
    var jsonresponse=json.decode(jsonplaceholder);
    var firends=jsonresponse['friends'];
    var friend_requests=jsonresponse['friend_requests'];
    var other_users=jsonresponse['other_users'];

    List<dynamic> finaldata=new List<dynamic>();
    List<String> frend=List<String>();
    List<String> fr_request=List<String>();
    List<String> add_frebd=List<String>();
  
    finaldata=[firends,friend_requests,other_users];
    return finaldata;
}


Future<bool> loginuser(String jsonplaceholder) async  //login user
{

    var data=await http.get(jsonplaceholder);

    if(data.statusCode==200)
          return true;
    else if(data.statusCode==401)
          return false;
    else
          return false;
}

List<dynamic> drawfloorWplace(String response) //getfloorwithplace
{

    var jsonresponse=json.decode(response);

    var floor0=jsonresponse["floor_0_locations"];
    var floor1=jsonresponse["floor_1_locations"];
    var floor2=jsonresponse["floor_2_locations"];
    var releventPlace=jsonresponse["place"];
    var otherplaces=jsonresponse["places"]; //other all places in relevent floor

    int releventfloor=getreleventfloor(jsonresponse);
    List<dynamic> arr=[floor0,floor1,floor2];

    List<dynamic> rPlace=[];
    List<dynamic> allplaces=[];
    //get place details
    if(releventPlace.length>0)
    {
        String name;
        double lat,lng;

        Map<String,dynamic> map=releventPlace;
        name=map["name"];
        lat=map["lat"];
        lng=map["lon"];

        rPlace.add(name);
        rPlace.add(lat);
        rPlace.add(lng);
    }

    //get other all places in relevent floor
    if(otherplaces!=null)
    {
        int count=otherplaces.length;
        
        for(int i=0;i<count;i++)
        {
            List<dynamic> oneplace=[];
            String name;
            double lat,lng;
            Map<String,dynamic> map=otherplaces[i];
            if(map!=null)
            {
              name=map["name"];
              lat=map["lat"];
              lng=map["lon"];

              oneplace.add(name);
              oneplace.add(lat);
              oneplace.add(lng);

              allplaces.add(oneplace);
            }
            
        }
    }

    //get floor location
    List<LatLng> floorL=[];
    if(arr[releventfloor]!=null)
    {
          for(int i=0;i<arr[releventfloor].length;i++)
          {
            floorL.add(LatLng(arr[releventfloor][i][0],arr[releventfloor][i][1]));
          }
    }
    
    List<dynamic> finalData=[];
    finalData.add(floorL);
    finalData.add(rPlace);
    finalData.add(allplaces);
    finalData.add(releventfloor);

    //0=>floor location
    //1=> required place
    //2=>relevent places
    //3=>relevent floor

    return finalData;
}

int getreleventfloor(var data)
{
   if(data["floor_0_locations"]!=null)
      return 0;
   else if(data["floor_1_locations"]!=null)
      return 1;
   else
      return 2;
}

int getUserFloor(var response)
{
    var floor0array = response["floor_0_locations"];
    var floor1array = response["floor_1_locations"];
    var floor2array = response["floor_2_locations"];
    int floor;
    if(floor0array!=null)
        floor=0;
    else if(floor1array!=null)
        floor=1;
    else if(floor2array!=null)
        floor=2;
    else
        floor=1;

    return floor;
}

int getArraylength(var response)
{
    if(response!=null)
      return response.length;
    else
      return 0;
}

int getFLLength(var response)
{
    if(response!=null)
      return response.length;
    else
      return 0;
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


