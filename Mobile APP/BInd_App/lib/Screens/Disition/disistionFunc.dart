import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:UorMap/Screens/Common/Distence_Calculation.dart';
import 'package:UorMap/Screens/Common/data.dart';
import 'package:UorMap/Screens/Map/Display/Display_OuterPlace.dart';
import 'package:UorMap/Screens/Request/JsonBody.dart';
import 'package:UorMap/Screens/Request/request.dart';
import 'package:UorMap/Screens/Common/placeLatLng.dart';
import 'dart:async';
import 'package:UorMap/Screens/Request/ConvertData.dart';
import 'package:UorMap/Screens/Map/Display/Display_PlaceInIn.dart';
import 'package:UorMap/Screens/Map/Display/Display_getPlace.dart';
import 'package:UorMap/Screens/Map/Display/Display_getfloor.dart';
import 'package:UorMap/Screens/Map/Display/Display_OuterRoutes.dart';
import 'package:UorMap/Screens/Map/Display/Display_placeInout.dart';
import 'package:UorMap/page_tran.dart';
import 'package:UorMap/Screens/Map/Display/Notification.dart';
import 'package:UorMap/Screens/Map/Display/Display_VehicleRouts.dart';


Future<String> myfuture;

void disitionFunc(BuildContext context, GlobalKey _loader,List<dynamic> arr) 
{
    //0=>start place name or 0=> 0=>Lat
    //                           1=>lng
    //                       1=> google map polyline
    //1=>destination place name
    //2=>department name
    //3=>floor name
    //4=>vOr
    //5=> 0 or 1
  

  bool startInside=false;
  bool startOutside=false;
  bool endInside=false;
  bool endOutside=false;

  if(arr[0]!=null && arr[1]!=null)
  {

    if(arr[0]==arr[1])
    {
        messageBox(context,"Notice","You can not select same place");  
        
    }else{

    //if user not select your location
    if(arr[5]==0)
    {
        int departmentID=getdepartmentID(arr[2]);
        int floorId=0; //defalut ground floor
        int selectedFloorID=1; // default selected first floor

        //check start whether inside or outside
        if(inSidePlces.contains(arr[0]))
              startInside=true;
        else
              startOutside=true;

        //check destination whether inside or outside
        if(outSideplaces.contains(arr[1]))
            endOutside=true;
        else
            endInside=true;


          //drawplace inside to inside
          if(startInside==true && endInside==true)
          {
              if(arr[4]!='f')
              {
                  messageBox(context,"Notice","Inside Routes Can't be Vehicle..");

              }else{

                  int selectedfloorId=getfloorID(arr[3]); //get selected floor ID
                  int startFloorID=getsAdfloorID(arr[0]);
                  int destinationID=allplaceID[arr[1]];
                  int destfloorID=getsAdfloorID(arr[1]);//get destination floorID
                  List<double> startarr=getPlaceLatLg(arr[0]);
                  
                  String url=getplaceInInRequest(departmentID,startFloorID , destinationID, startarr);   
                  myfuture=getjsonvalue(url);

                  List<dynamic> allResponse=new List<dynamic>();

                  //Add All Rquird Data 
                  allResponse.add(selectedfloorId);
                  allResponse.add(destinationID);
                  allResponse.add(startFloorID);
                  allResponse.add(destfloorID);
                  allResponse.add(arr[0]);

                  //0=>selectedfloorId
                  //1=>destinationID
                  //2=>startFloorID
                  //3=>destfloorID
                  //4=>start Place Name (arr[0])
                  //5=>Response
                  
                  myfuture.then((response) =>{
                    if(isjsonResponseOk)
                    {
                      isjsonResponseOk=false,
                      allResponse.add(response),
                     _loadingGetPlaceInIn(context, _loader,allResponse)
                    }
                    

                  });
              }
          }

          //drwa place inside to outside (drawplaceinout)
          else if(startInside==true && endOutside==true)
          {
              floorId=getsAdfloorID(arr[0]);//get Start floor id
              selectedFloorID=getfloorID(arr[3]); //default selected floor will be  destination place floor
              List<List<double>> startAdestLatLng=getStartADest(arr[0],arr[1]);
              String url1=getplaceinOutRequest(departmentID, floorId, startAdestLatLng);
              Future<String> myfuture=getjsonvalue(url1);

              List<dynamic> allResponse=new List<dynamic>();

              //Add All Rquird Data 
              allResponse.add(selectedFloorID);
              allResponse.add(arr[0]);

              //0=>selectedFloorID
              //1=>start Place name  (arr[0])
              //2=>Response
              
              myfuture.then((response) => {
                
                if(isjsonResponseOk)
                {
                    isjsonResponseOk=false,
                    allResponse.add(response),
                   _loadingGetPlaceInout(context, _loader,allResponse)
                }
                

              });
          }

          //draw place  outside to inside ( drawplace)
          else if(startOutside==true && endInside==true)
          {
              List<double> startLatLng=getPlaceLatLg(arr[0]);
              int placeID=allplaceID[arr[1]]; //get destination place ID
              int destFloorID=getsAdfloorID(arr[1]);//get destination floorID (0 /1 / 2)
              selectedFloorID=getfloorID(arr[3]);//get selected floor ID  (0 /1 / 2)
              String url=getplaceRequest(startLatLng, placeID, arr[4]);

              List<dynamic> allResponse=new List<dynamic>();

              //Add All Rquird Data 
              allResponse.add(selectedFloorID);
              allResponse.add(destFloorID);
              allResponse.add(0);
              allResponse.add(arr[5]);

                //0=>selectedFloorID
                //1=>destFloorID
                //2=>arr[0] -->current location and google map polyline
                //3=>arr[5] --> 0 or 1  (not current location and current location)
                //4=>Response
              Future<String> myfuture=getjsonvalue(url);
              //_loadingEffect(context, _loader);
              myfuture.then((response) =>{
                
                if(isjsonResponseOk)
                {
                    isjsonResponseOk=false,
                    allResponse.add(response),
                    _loadingGetPlace(context, _loader,allResponse)
                }
               
              });
          }

          //draw place outside to outside (drawRouteLine)
          else if(startOutside==true && endOutside==true)
          {
            if(arr[4]!='v')
            {
              List<List<double>> startAdestination=getStartADest(arr[0],arr[1]);
              String url2=getrouteRequest(startAdestination,arr[4]);

              
              Future<String> myfuture1=getjsonvalue(url2);
              myfuture1.then((response) => {
                 if(isjsonResponseOk)
                 {
                     isjsonResponseOk=false,
                    _loadingOuterRoutes(context, _loader,response,arr)       
                 }
                
              });
            }
            else{

              //vehicle Routes
              List<List<double>> startAdestination=getStartADest(arr[0],arr[1]);
              String url3=getrouteRequest(startAdestination,arr[4]);

              
              Future<String> myfuture1=getjsonvalue(url3);
              myfuture1.then((response) => {
                 if(isjsonResponseOk)
                 {
                     isjsonResponseOk=false,
                     _loadingvehicleRouts(context, _loader,response,arr)       
                 }
                
              });
              
            }
              
          }        
    }
    else
    {
        //if user select your location ---->>>

        if(outSideplaces.contains(arr[1]))
            endOutside=true;
        //if user select your location
        //default user sitting floor is Ground

        //arr ==>
        // 0=>startlocation  0=>lat
        //                   1=>lng
        //1=>destination Place Name
        //2=>department
        //3=>floor Name
        //4=> f or v
        //5=>0 or 1  (0=> not user location   1=> user location)

        if(arr[3]=="")
        {
            //if there isn't  floor name  exactly user sitting outside
            
            //outside to outside
            if(endOutside) 
            {
               List<List<double>> startAdestination1=new List<List<double>>();
               List<double> endLatLng=getPlaceLatLg(arr[1]);
               List<double> current=[currentLat2,currentLng2];
               
               if(isNotUniversity(current)){
                    startAdestination1.add(uorMainGate);//add main gate location as start
               }else{
                    startAdestination1.add(current);
               }
               arr.removeAt(0);
               arr.insert(0,current);
               //startAdestination1.add(arr[0]);     
               startAdestination1.add(endLatLng);
               String url4 =getrouteRequest(startAdestination1, arr[4]);
              

               Future<String> myfuture=getjsonvalue(url4);
               myfuture.then((response) => {
                  if(isjsonResponseOk){
                        isjsonResponseOk=false,
                      _loadingOuterRoutes(context, _loader,response,arr)       
                  }
                 
              });

            }
            else
            {
                //outside to inside  (getplace)
                List<double> startLatLng=new List<double>();
                List<double> current=[currentLat2,currentLng2];
                
                if(isNotUniversity(current))
                    startLatLng=uorMainGate;
                else
                    startLatLng=current;
                
                int placeID=allplaceID[arr[1]]; //get destination place ID
                int destFloorID=getsAdfloorID(arr[1]);//get destination floorID (0 /1 / 2)
                int selectedFloorID=getfloorID(arr[3]);//get selected floor ID  (0 /1 / 2)
                String url5=getplaceRequest(startLatLng, placeID, arr[4]);

                List<dynamic> allResponse=new List<dynamic>();

                //Add All Rquird Data 
                allResponse.add(selectedFloorID);
                allResponse.add(destFloorID);
                allResponse.add(arr[0]);
                allResponse.add(arr[5]);
                //0=>selectedFloorID
                //1=>destFloorID
                //2=>arr[0] -->current location and google map polyline
                //3=>arr[5] --> 0 or 1  (not current location and current location)
                //4=>Response
                Future<String> myfuture=getjsonvalue(url5);
                myfuture.then((response) =>{
                  
                  if(isjsonResponseOk)
                  {
                      isjsonResponseOk=false,
                      allResponse.add(response),
                     _loadingGetPlace(context, _loader,allResponse)
                  }
                  
                });

            }            
        }
        else
        {
             //user sitting in inside
             int departmentID=getdepartmentID(arr[2]);
             int floorId=0; //defalut ground floor
             int selectedFloorID=1; // default selected first floor


            //if user select floor exactly user sitting in inside
            if(isNotUniversity(arr[0][0]))
            {
              //set Notification -->>  user not in floor. user sitting in outside of university
              //setMessage("You now sitting in outside of University ...Don't select inside ");
              String msg="Currently you are not in the university premises.";
              showMessages(context,msg);
            }
            else
            {

                //insite to outside  (getplaceInOut)
              if(endOutside)
              {
                  floorId=getsAdfloorID(arr[0]);//get Start floor id
                  selectedFloorID=getfloorID(arr[3]); //default selected floor will be  destination place floor

                  List<List<double>> startAdestLatLng=new List<List<double>>();
                  List<double> current=[currentLat2,currentLng2];
                  List<double> endLatLng=getPlaceLatLg(arr[1]);

                  //add source and destination geolocation
                  startAdestLatLng.add(current);
                  startAdestLatLng.add(endLatLng);

                  String url6=getplaceinOutRequest(departmentID, floorId, startAdestLatLng);
                  Future<String> myfuture=getjsonvalue(url6);

                  List<dynamic> allResponse=new List<dynamic>();

                  //Add All Rquird Data 
                  allResponse.add(selectedFloorID);
                  allResponse.add(arr[0]);

                  //0=>selectedFloorID
                  //1=>start Place name  (arr[0])
                  //2=>Response
                  
                myfuture.then((response) => {
                    if(isjsonResponseOk)
                    {
                        isjsonResponseOk=false,
                        allResponse.add(response),
                      _loadingGetPlaceInout(context, _loader,allResponse)
                    }
                    
                  });


              }
              else
              {
                  //inside to inside (getplaceInIn)
                  int selectedfloorId=getfloorID(arr[3]); //get selected floor ID
                  int startFloorID=selectedfloorId;   //in this start floor id and selected floor id id same
                  int destinationID=allplaceID[arr[1]];
                  int destfloorID=getsAdfloorID(arr[1]);//get destination floorID
                  List<double> startarr=arr[0];
                  
                  String url7=getplaceInInRequest(departmentID,startFloorID , destinationID, startarr);   
                  myfuture=getjsonvalue(url7);

                  List<dynamic> allResponse=new List<dynamic>();

                  //Add All Rquird Data 
                  allResponse.add(selectedfloorId);
                  allResponse.add(destinationID);
                  allResponse.add(startFloorID);
                  allResponse.add(destfloorID);
                  allResponse.add(arr[0]);

                  //0=>selectedfloorId
                  //1=>destinationID
                  //2=>startFloorID
                  //3=>destfloorID
                  //4=>start Place Name (arr[0])
                  //5=>Response
                  
                  myfuture.then((response) =>{
                    if(isjsonResponseOk)
                    {
                        isjsonResponseOk=false,
                        allResponse.add(response),
                       _loadingGetPlaceInIn(context, _loader,allResponse)

                    }
                    
                  });

              }                
            }
          
        }
        
     }
    }

  

  }
}

 Future<void> _loadingEffect(BuildContext context,GlobalKey _loader) async{
    try{
      Dialogs.showLoadingDialog(context,_loader);
      await Future.delayed(Duration(seconds: 5,));
      Navigator.of(_loader.currentContext,rootNavigator: true).pop();

     
    }
    catch(error){
      print(error);
    }
  }

 Future<void> _loadingOuterRoutes(BuildContext context,GlobalKey _loader,String response,List<dynamic> arrRoute) async{
    try{
      Dialogs.showLoadingDialog(context,_loader);
      await Future.delayed(Duration(seconds: 3,));
      Navigator.of(_loader.currentContext,rootNavigator: true).pop();

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>DrawRouteLine(drawroute(response),arrRoute)));
    }
    catch(error){
      print(error);
    }
  }
  
 Future<void> _loadingvehicleRouts(BuildContext context,GlobalKey _loader,String response,List<dynamic> arrRoute) async{
    try{
      Dialogs.showLoadingDialog(context,_loader);
      await Future.delayed(Duration(seconds: 3,));
      Navigator.of(_loader.currentContext,rootNavigator: true).pop();

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>DrawVehicleRouteLine(drawroute(response),arrRoute)));
    }
    catch(error){
      print(error);
    }
  }

 Future<void> _loadingGetPlace(BuildContext context,GlobalKey _loader,List<dynamic> response) async{

   
    //0=>selectedFloorID
    //1=>destFloorID
    //2=>Response
    try{
      Dialogs.showLoadingDialog(context,_loader);
      await Future.delayed(Duration(seconds: 3,));
      Navigator.of(_loader.currentContext,rootNavigator: true).pop();

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>DrawPlace(drawplace(response[4]),response)));
    }
    catch(error){
      print(error);
    }
  }

Future<void> _loadingGetPlaceInout(BuildContext context,GlobalKey _loader,List<dynamic> response) async{

   
    //0=>selectedFloorID
    //1=>start Place name  (arr[0])
    //2=>Response

    try{
      Dialogs.showLoadingDialog(context,_loader);
      await Future.delayed(Duration(seconds: 3,));
      Navigator.of(_loader.currentContext,rootNavigator: true).pop();

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>DrawPlaceInOut(drawplaceinout(response[2]),response[0],response[1])));
    }
    catch(error){
      print(error);
    }
  }

Future<void> _loadingGetPlaceInIn(BuildContext context,GlobalKey _loader,List<dynamic> response) async{

   
    //0=>selectedfloorId
    //1=>destinationID
    //2=>startFloorID
    //3=>destfloorID
    //4=>start Place Name (arr[0])
    //5=>Response

    try{
      Dialogs.showLoadingDialog(context,_loader);
      await Future.delayed(Duration(seconds: 3,));
      Navigator.of(_loader.currentContext,rootNavigator: true).pop();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
          DrawPlaceInIn(drawplaceinin(response[5]),response[1],response[2],response[0],response[3],response[4])));
    }
    catch(error){
      print(error);
    }
  }
   
void serachPlace(BuildContext context,GlobalKey _loader,String placeNameselected)
{

    bool inside=false;
    bool outside=false;

    if(inSidePlces.contains(placeNameselected))
        inside=true;
    else
        outside=true;

        /*
      //draw relevent floor and  all the places of relevent floor   (drawfloor)
          // in this department is cd departmet (ID => 1)
        int floorID= getfloorIdWithName(placeNameselected);
        int deptID=1; //cs department
        String url8=getfloorRequest(deptID, floorID);

        Future<String> myfuture=getjsonvalue(url8);
        myfuture.then((response) => {
          if(isjsonResponseOk){
            isjsonResponseOk=false,
            _loadingSearch(context, _loader,response,placeNameselected),
          }
          
         
        });

      */

    
    if(inside)
    {
        

         //draw relevent floor with all places in relevent floor and  required place (drawfloorwithplace)
    
        int placeID=allplaceID[placeNameselected];
        String url =getfloorwithplaceRequest(placeID);
        Future<String> myfuture1=getjsonvalue(url);
        myfuture1.then((response) => {

          if(isjsonResponseOk)
          {
             isjsonResponseOk=false,
             _loadinfPlaceWFloor(context, _loader,response,placeNameselected),

          }
        });

    }
    if(outside)
    {
        Navigator.push(
          context,
          MaterialPageRoute(builder:(context)=>DisplayOuterPlace(placeNameselected)));
    }
   
}

List<List<double>> getStartADest(String start,String dest)
{
    List<List<double>> arr=new List<List<double>>();
    //if Start is your location / have to get current location


    //if not 
    double startlat =placeLatLng[start][0];
    double startlng=placeLatLng[start][1];
    List<double> startval=[startlat,startlng];

    double endlat=placeLatLng[dest][0];
    double endlng=placeLatLng[dest][1];
    List<double> endval=[endlat,endlng];

    arr=[startval,endval];

  return arr;

    
}

int getdepartmentID(String department)
{
    int id=1; //default id =1 (cs depaerment)
    if(department.length>0)
        id=departmentID[department];
    
    return id;

}

int getfloorID(String floorName)
{

   int id=0;// defalut floor id is ground floor
  
   if(floorName=="First floor")
        id=1;
   if(floorName=="Second floor")
        id=2;

    return id;
}

int getsAdfloorID(String placeName)
{
  int id=0; //default floor is  first floor
  if(first_floor.contains(placeName))
      id=1;
  if(second_floor.contains(placeName))
    id=2;

  return id;
}

List<double> getPlaceLatLg(String start) 
{
   // if start is your location we have to get user current location

   //if not 
   double lat=placeLatLng[start][0];
   double lng=placeLatLng[start][1];
   List<double> arr=[lat,lng];
   
   return arr;
}

int getfloorIdWithName(String placeName)
{
   //in this disition relevent floor id using place name

   int id=1; //default floor is first floor
   if(ground_floor.contains(placeName))
      id=0;
   else if(second_floor.contains(placeName))
      id=2;
    
    return id;
}

 Future<void> _handleSubmitaddsearch(BuildContext context,GlobalKey<State> _keyloader) async
  {
    try{
      Dialogs.showLoadingDialog(context,_keyloader);
      await Future.delayed(Duration(seconds: 3,));
      Navigator.of(_keyloader.currentContext,rootNavigator: true).pop();

     // Navigator.push(context,MaterialPageRoute(builder: (context) => AddSearch()));
    }
    catch(error){
      print(error);
    }
  }

  Future<void> _loadingSearch(BuildContext context,GlobalKey<State> _keyloader,String response,String placename) async
  {
    try{
      Dialogs.showLoadingDialog(context,_keyloader);
      await Future.delayed(Duration(seconds: 3,));
      Navigator.of(_keyloader.currentContext,rootNavigator: true).pop();

      Navigator.push(
            context,
            MaterialPageRoute(
              builder:(context)=>DrawFloor(drawfloor(response),placename)));
    }
    catch(error){
      print(error);
    }
  }

  Future<void> _loadinfPlaceWFloor(BuildContext context,GlobalKey<State> _keyloader,String response,String placename) async
  {
    try{
      Dialogs.showLoadingDialog(context,_keyloader);
      await Future.delayed(Duration(seconds: 3,));
      Navigator.of(_keyloader.currentContext,rootNavigator: true).pop();

      Navigator.push(
            context,
            MaterialPageRoute(
              builder:(context)=>DrawFloor(drawfloorWplace(response),placename)));
    }
    catch(error){
      print(error);
    }
  }