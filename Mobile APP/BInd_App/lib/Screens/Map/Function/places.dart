import 'package:google_maps_flutter/google_maps_flutter.dart';

class OutSidePlaces {
  String name;
  LatLng locationCoords;

  OutSidePlaces({
    this.name,
    this.locationCoords
  });
}
final List<OutSidePlaces> uorplaces = [
  OutSidePlaces(
    name: 'Main Gate',
    locationCoords: LatLng(5.93802, 80.574649),
  ),
  OutSidePlaces(
    name: 'Y Junction',
    locationCoords: LatLng(5.938596, 80.575161),
  ),
  OutSidePlaces(
    name: 'Library Junction',
    locationCoords: LatLng(5.938779, 80.575966),
  ),
];

class Department{
  String depname;
  LatLng deplocationCoords;
  Department({
    this.depname,
    this.deplocationCoords,
  });
}
final List<Department> departmentLoc=[
  Department(
    depname: 'Maths Department',
    deplocationCoords: LatLng(5.93945, 80.576022),
  ),
  Department(
    depname: 'Computer Science Department',
    deplocationCoords: LatLng(5.939505, 80.576344),
  ),
  Department(
    depname: 'Chemistry Department',
    deplocationCoords: LatLng(5.940944, 80.576713),
  ),
  Department(
    depname: 'Physics Department',
    deplocationCoords: LatLng(5.940462, 80.576642),
  ),
  Department(
    depname: 'Botany Department',
    deplocationCoords: LatLng(5.940006, 80.577992),
  ),
  Department(
    depname: 'Zoology Department',
    deplocationCoords: LatLng(5.940578, 80.578011),
  ),
  Department(
    depname: 'Faculty of Fisharies',
    deplocationCoords: LatLng(5.941287, 80.577381),
  ),
];

class InSidePlaces{
  String insidename;
  LatLng insidedeplocationCoords;
  InSidePlaces({
    this.insidename,
    this.insidedeplocationCoords,
  });
}
final List<InSidePlaces> insideplaces = [
  InSidePlaces(
    insidename: 'Students Well Fair Branch',
    insidedeplocationCoords: LatLng(5.937734, 80.576161),
  ),
  InSidePlaces(
    insidename: 'Science Auditorium',
    insidedeplocationCoords: LatLng(5.93947, 80.577466),
  ),
  InSidePlaces(
    insidename: 'Science Dean Office',
    insidedeplocationCoords: LatLng(5.93948, 80.577104),
  ),
];

class ReadingPalces{
  String readname;
  LatLng readdeplocationCoords;
  ReadingPalces({
    this.readname,
    this.readdeplocationCoords,
  });
}
final List<ReadingPalces> readingplaces = [
  ReadingPalces(
    readname: 'Student Reading Place',
    readdeplocationCoords: LatLng(5.93893, 80.577123),
  ),
  ReadingPalces(
    readname: 'Library',
    readdeplocationCoords: LatLng(5.938399, 80.576378),
  ),
];

class Canteen{
  String canteenname;
  LatLng canteendeplocationCoords;
  Canteen({
    this.canteenname,
    this.canteendeplocationCoords,
  });
}
final List<Canteen> canteenplaces = [
  Canteen(
    canteenname: 'Science Faculty Canteen',
    canteendeplocationCoords: LatLng(5.939885, 80.576923),
  ),
];

class MainGate{
  String name;
  LatLng cordinates;
  MainGate({
    this.name,
    this.cordinates,
  });
}



final List<MainGate> maingate = [
  MainGate(
    name: 'main Gate',
    cordinates: LatLng(5.93802,80.574649),
  ),
];

class Medical{
  String name;
  LatLng locationCoords;
  Medical({
    this.name,
    this.locationCoords,
  });
}



final List<Medical> medical = [
  Medical(
    name: 'Medical Center',
    locationCoords: LatLng(5.940433, 80.576065),
  ),
];