
import 'package:UorMap/Screens/Common/data.dart';

String getuserLocationRequest(List<double> userLoc,String usrename)
{

    String url=port+"/UserLocation/"+usrename+"/"+userLoc[0].toString()+"/"+userLoc[1].toString()+"";
    return url;
}

String getFirendLocationRequest(String userName)
{
    String url=port+"/GetLocations/"+userName+"";
    return url;
}

String getPathRequest(List<String> towuserName)
{
    String url=port+"/GetPath/"+towuserName[0]+"/"+towuserName[1]+"";
    return url;
}

String getManageFirendRequest(String userName)
{
    String url=port+"/GetAppUsers/"+userName+"";
    return url;
}

String getAddFirendrequest(List<String> towuser)
{
    String url=port+"/AddFriend/"+towuser[0]+"/"+towuser[1]+"";
    return url;
}

String getConfiremFiredrequest(List<String> towuser)
{
    String url=port+"/ConfirmFriend/"+towuser[0]+"/"+towuser[1]+"";
    return url;
}

String getRemoveFirendRequest(List<String> towuser)
{
    String url=port+"/RemoveFriend/"+towuser[0]+"/"+towuser[1]+"";
    return url;
}
