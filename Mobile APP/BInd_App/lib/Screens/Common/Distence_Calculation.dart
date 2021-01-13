
import 'dart:math';

bool isNotUniversity(List<double> startloc)
{
    int earthRadius=6371; //Km

    //Central point
    double lat1=5.938789;
    double lng1=80.576910;

    double lat2=startloc[0];
    double lng2=startloc[1];

    double x= (lng2-lng1)*cos((lat1+lat2)/2);
    double y=(lat2-lat1);
    double d=sqrt(x*x+y*y)*earthRadius;

    if(d>=24)
        return true;
    else
        return false;
}