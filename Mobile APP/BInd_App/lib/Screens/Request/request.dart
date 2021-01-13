
import 'package:UorMap/Screens/Common/data.dart';


  //2d array is lat and lng
  String getplaceinOutRequest(int deptId,int floorId,List<List<double>> array)//Request a outside Place from inside
  {
          //start and destinationa location come from array 
        String deptID=deptId.toString();
        String floorID=floorId.toString();
        String sourcelat=array[0][0].toString();
        String sourcelng=array[0][1].toString();
        String destlat=array[1][0].toString();
        String destlng=array[1][1].toString();

        String url=port+"/getplaceinout/"+deptID+"/"+floorID+"/"+sourcelat+"/"+sourcelng+"/"+destlat+"/"+destlng+"";
  
        //get data from server (3 json array from )
  
    return url;

  } 

  String getplaceInInRequest(int deptID,int floorID,int destinationID,List<double> array) //Request a inside Place from inside
  {
        String sourcelat=array[0].toString();
        String sourcelng=array[1].toString();
        String deptId=deptID.toString();
        String floorId=floorID.toString();
        String destinationId=destinationID.toString();

        String url=port+"/getplaceinin/"+deptId+"/"+floorId+"/"+sourcelat+"/"+sourcelng+"/"+destinationId+"";

       return url;
  }

  String getfloorRequest(int deptID,int floorID)  //done
  {
          String deptId=deptID.toString();
          String floorId=floorID.toString();

          String url=port+"/getfloor/"+deptId+"/"+floorId+"";
      
      
      return url;
          
  }

  String getplaceRequest(List<double> array,int placeID,String vORf)  //done
  {
          String sourcelat=array[0].toString();
          String sourcelng=array[1].toString();
          String placeId=placeID.toString();

          String url=port+"/getplace/"+sourcelat+"/"+sourcelng+"/"+placeId+"/"+vORf+"";
    
      return url;
  }

  String getrouteRequest(List<List<double>> array ,String vORf) 
  {
        //start and destinationa location come from array 
        String sourcelat=array[0][0].toString();
        String sourcelng=array[0][1].toString();
        String destlat=array[1][0].toString();
        String destlng=array[1][1].toString();

        String url=port+"/getroute/"+sourcelat+"/"+sourcelng+"/"+destlat+"/"+destlng+"/"+vORf+"";
    
     return url;
      
  }
   
  String getfloorwithplaceRequest(int placeID)
  {
    
   // String id=placeID.toString();
      String url=port+"/getfloorwithplace/"+placeID.toString()+"";

      //String url="https://my.api.mockaroo.com/my_saved_schema.json?key=8699f700";
      return url;
  }

  
