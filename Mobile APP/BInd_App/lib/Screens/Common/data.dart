
import 'package:flutter/material.dart';


List<String> walkoutUserLoc = [
  "Your Location",
  "Main Gate",
  "Y Junction",
  "Library Junction",
  "Library",
  "Student's Well fair branch",
  "Maths Department",
  "Computer Science Department",
  "Science faculty Canteen",
  "Science Auditorium",
  "Science Dean office",
  "Botany Department",
  "Zoology Department",
  "Faculty of fisharies",
  "Maths Lecture hall 1",
  "Maths Lecture hall 2",
  "Chemistry Department",
  "Physics Department",
  "Medical Center",
  "Student Common Room",
  "Student reading place",
  // new places
  "Maths Department Car Park",
  "Administrative Building car park",
  "Computer Science Department car park",
  "General Car Park",
  "Science Complex Car park",
  "Zoology Department Car Park",
  "Chemistry Departmet car park",
  "Medical center car park",
  "Physics department car park",
];
final walkoutUserLocselect = TextEditingController();
String walkoutUserLocselected = "";

List<String> walkoutDestiLoc = [
  
  "Main Gate",
  "Y Junction",
  "Library Junction",
  "Library",
  "Student's Well fair branch",
  "Maths Department",
  "Computer Science Department",
  "Science faculty Canteen",
  "Science Auditorium",
  "Science Dean office",
  "Botany Department",
  "Zoology Department",
  "Faculty of fisharies",
  "Maths Lecture hall 1",
  "Maths Lecture hall 2",
  "Chemistry Department",
  "Physics Department",
  "Medical Center",
  "Student Common Room",
  "Student reading place",
  "CS Lecturer's Room",
  "CS Instructors's Room",
  "CS Computer Lab 01",
  "CS Mini-auditorium",
  "CS Head's Room",
  "CS Conference Room",
  "CS Record Room",
  "CS Special Lab",
  "CS Computer lab 02",
  "CS E-Learning Center",
  "CS Special Room",
  "CS Demonstrator's Room",
  "CS Main-auditorium",
  "CS Wash Rooms",
  "CS Computer Lab 03",
  "CS Car park",
  "Lecture Hall 01",
  //new places
  "Maths Department Car Park",
  "Administrative Building car park",
  "Computer Science Department car park",
  "General Car Park",
  "Science Complex Car park",
  "Zoology Department Car Park",
  "Chemistry Departmet car park",
  "Medical center car park",
  "Physics department car park",
];

List<String> walkoutStartiLoc = [
  "Your Location",
  "Main Gate",
  "Y Junction",
  "Library Junction",
  "Library",
  "Student's Well fair branch",
  "Maths Department",
  "Computer Science Department",
  "Science faculty Canteen",
  "Science Auditorium",
  "Science Dean office",
  "Botany Department",
  "Zoology Department",
  "Faculty of fisharies",
  "Maths Lecture hall 1",
  "Maths Lecture hall 2",
  "Chemistry Department",
  "Physics Department",
  "Medical Center",
  "Student Common Room",
  "Student reading place",
  "CS Lecturer's Room",
  "CS Instructors's Room",
  "CS Computer Lab 01",
  "CS Mini-auditorium",
  "CS Head's Room",
  "CS Conference Room",
  "CS Record Room",
  "CS Special Lab",
  "CS Computer lab 02",
  "CS E-Learning Center",
  "CS Special Room",
  "CS Demonstrator's Room",
  "CS Main-auditorium",
  "CS Wash Rooms",
  "CS Computer Lab 03",
  "CS Car park",
  "Lecture Hall 01",

];
final walkoutDestiLocselect = TextEditingController();
String walkoutDestiLocselected = "";

List<String> vehicleoutUserLoc = [
  "Your Location",
  "Main Gate",
  "Y Junction",
  "Library Junction",
  "Maths Department Car Park",
  "Administrative Building car park",
  "Computer Science Department car park",
  "Science Faculty canteen",
  "General Car Park",
  "Science Complex Car park",
  "Botany Department",
  "Zoology Department Car Park",
  "Faculty of Fisheries",
  "Chemistry Departmet car park",
  "Medical center car park",
  "Physics department car park",
];
final vehicleoutUserLocselect = TextEditingController();
String vehicleoutUserLocselected = "";

List<String> vehicleoutDestiLoc = [
  "Main Gate",
  "Y Junction",
  "Library Junction",
  "Maths Department Car Park",
  "Administrative Building car park",
  "Computer Science Department car park",
  "Science Faculty canteen",
  "General Car Park",
  "Science Complex Car park",
  "Botany Department",
  "Zoology Department Car Park",
  "Faculty of Fisheries",
  "Chemistry Departmet car park",
  "Medical center car park",
  "Physics department car park",
];
final vehicleoutDestiLocselect = TextEditingController();
String vehicleoutDestiLocselected = "";

List<String> vehicleinUserLoc = [];
final vehicleinUserLocselect = TextEditingController();
String vehicleinUserLocselected = "";

List<String> vehicleinDestiLoc = [];
final vehicleinDestiLocselect = TextEditingController();
String vehicleinDestiLocselected = "";


List<String> placeName=[
  "Main Gate",
  "Y Junction",
  "Library Junction",
  "Library",
  "Student's Well fair branch",
  "Maths Department",
  "Computer Science Department",
  "Scienes faculty Canteen",
  "Science Auditorium",
  "Science Dean office",
  "Botany Department",
  "Zoology Department",
  "Faculty of fisharies",
  "Maths Lecture hall 1",
  "Maths Lecture hall 2",
  "Chemistry Department",
  "Physics Department",
  "Medical Center",
  "Student Common Room",
  "Student reading place",
  "CS Lecturer's Room",
  "CS Instructors's Room",
  "CS Computer Lab 01",
  "CS Mini-auditorium",
  "CS Head's Room",
  "CS Conference Room",
  "CS Record Room",
  "CS Special Lab",
  "CS Computer lab 02",
  "CS E-Learning Center",
  "CS Special Room",
  "CS Demonstrator's Room",
  "CS Main-auditorium",
  "CS Wash Rooms",
  "CS Computer Lab 03",
  "Lecture Hall 01"
  //new places
  "Maths Department Car Park",
  "Administrative Building car park",
  "Computer Science Department car park",
  "General Car Park",
  "Science Complex Car park",
  "Zoology Department Car Park",
  "Chemistry Departmet car park",
  "Medical center car park",
  "Physics department car park",
];
final placeNameSelect = TextEditingController();
String placeNameselected = "";

List<String> floor=[
  "Ground floor",
  "First floor",
  "Second floor"
  ];
String floorvalue  = "Ground floor";

List<String> department=[
  "Computer Science Department",
  "Botany Department",
  "Zoology Department",
  "Chemistry Department",
  "Physics Department",
  "Mathematics Department"
];
String departmentvalue ="Computer Science Department";

List<String> ground = [
  "Your Location",
  "CS Wash Rooms",
  "CS Computer Lab 01",
  "CS Car park"
  ];
final floorcontroller = TextEditingController();
String groundselected = "";

List<String> first = [
  "Your Location",
  "CS Record Room",
  "CS Special Lab",
  "CS Lecture's Room",
  "CS Instructor's Room",
  "CS Demonstrator's Room",
  "CS Main-auditorium",
  "CS E-Learning Center",
  "CS Conference Room",
  "CS Head's Room",
  "CS Computer lab 02",
  "CS Record Room"
  ];
//final firstf = TextEditingController();
String firstselected = "";

List<String> secound = [
  "Your Location",
  "CS Mini-auditorium",
  "CS Computer Lab 03"
  ];
//final secoundf = TextEditingController();
String secoundselected = "";

List<String> ifground = [
  "Your Location",
  "Main Gate",
  "Y Junction",
  "Library Junction",
  "Library",
  "Student's Well fair branch",
  "Maths Department",
  "Computer Science Department",
  "Scienes faculty Canteen",
  "Science Auditorium",
  "Science Dean office",
  "Botany Department",
  "Zoology Department",
  "Faculty of fisharies",
  "Maths Lecture hall 1",
  "Maths Lecture hall 2",
  "Chemistry Department",
  "Physics Department",
  "Medical Center",
  "Student Common Room",
  "Student reading place",
  "CS Lecturer's Room",
  "CS Instructors's Room",
  "CS Computer Lab 03",
  "CS Mini-auditorium",
  "CS Head's Room",
  "CS Conference Room",
  "CS Record Room",
  "CS Special Lab",
  "CS Computer lab 02",
  "CS E-Learning Center",
  "CS Special Room",
  "CS Demonstrator's Room",
  "CS Main-auditorium",

  //new places
  "Maths Department Car Park",
  "Administrative Building car park",
  "Computer Science Department car park",
  "General Car Park",
  "Science Complex Car park",
  "Zoology Department Car Park",
  "Chemistry Departmet car park",
  "Medical center car park",
  "Physics department car park",
  ];
final iffloorcontroller = TextEditingController();
String ifgroundselected = "";

List<String> iffirst = [
  "Your Location",
  "Main Gate",
  "Y Junction",
  "Library Junction",
  "Library",
  "Student's Well fair branch",
  "Maths Department",
  "Computer Science Department",
  "Scienes faculty Canteen",
  "Science Auditorium",
  "Science Dean office",
  "Botany Department",
  "Zoology Department",
  "Faculty of fisharies",
  "Maths Lecture hall 1",
  "Maths Lecture hall 2",
  "Chemistry Department",
  "Physics Department",
  "Medical Center",
  "Student Common Room",
  "Student reading place",
  "CS Lecturer's Room",
  "CS Instructors's Room",
  "CS Mini-auditorium",
  "CS Computer Lab 01",
  "CS Special Room",
  "CS Wash Rooms",
  "CS Computer Lab 03",
  "CS Car park",
  
  //new places
  "Maths Department Car Park",
  "Administrative Building car park",
  "Computer Science Department car park",
  "General Car Park",
  "Science Complex Car park",
  "Zoology Department Car Park",
  "Chemistry Departmet car park",
  "Medical center car park",
  "Physics department car park",
  ];
//final iffirstf = TextEditingController();
String iffirstselected = "";

List<String> ifsecound = [
  "Your Location",
  "Main Gate",
  "Y Junction",
  "Library Junction",
  "Library",
  "Student's Well fair branch",
  "Maths Department",
  "Computer Science Department",
  "Scienes faculty Canteen",
  "Science Auditorium",
  "Science Dean office",
  "Botany Department",
  "Zoology Department",
  "Faculty of fisharies",
  "Maths Lecture hall 1",
  "Maths Lecture hall 2",
  "Chemistry Department",
  "Physics Department",
  "Medical Center",
  "Student Common Room",
  "Student reading place",
  "CS Lecturer's Room",
  "CS Instructors's Room",
  "CS Computer Lab 01",
  "CS Head's Room",
  "CS Conference Room",
  "CS Record Room",
  "CS Special Lab",
  "CS E-Learning Center",
  "CS Special Room",
  "CS Demonstrator's Room",
  "CS Main-auditorium",
  "CS Wash Rooms",
  "CS Computer lab 02",
  "CS Car park",
  //new places
  "Maths Department Car Park",
  "Administrative Building car park",
  "Computer Science Department car park",
  "General Car Park",
  "Science Complex Car park",
  "Zoology Department Car Park",
  "Chemistry Departmet car park",
  "Medical center car park",
  "Physics department car park",
  ];
//final ifsecoundf = TextEditingController();
String ifsecoundselected = "";

final List<String> faculty = [
  "Faculty of Science",
  "Faculty of Art",
  "Faculty of Fisharies",
  "Faculty of Management"
];


//final ifsecoundf = TextEditingController();
//String ifsecoundselected = "";
String user="samira";
String useremail="";
bool isOnRealTimeUserLocation=false;
bool isjsonResponseOk=false;

List<String> outSideplaces=["Main Gate","Y Junction", "Library Junction","Library",
  "Student's Well fair branch","Maths Department", "Computer Science Department","Science faculty Canteen",
  "Science Auditorium","Science Dean office", "Botany Department","Zoology Department",
  "Faculty of fisharies", "Maths Lecture hall 1", "Maths Lecture hall 2","Chemistry Department",
  "Physics Department", "Medical Center","Student Common Room",
  "Student reading place","Maths Department", "Maths Department Car Park",
  "Administrative Building car park","Computer Science Department car park",
  "General Car Park","Science Complex Car park","Zoology Department Car Park",
  "Chemistry Departmet car park","Medical center car park","Physics department car park" ];

List<String> inSidePlces=["Your Location","CS Lecturer's Room", "CS Instructors's Room","CS Computer Lab 01",
  "CS Mini-auditorium","CS Head's Room", "CS Conference Room", "CS Record Room",
  "CS Special Lab","CS Computer lab 02", "CS E-Learning Center",
  "CS Special Room","CS Demonstrator's Room", "CS Main-auditorium","CS Wash Rooms",
  "CS Computer Lab 03","Lecture Hall 01"];

List<String> ground_floor=["CS Wash Rooms","CS Computer Lab 03","CS Car park"];

List<String> first_floor=[ "CS Record Room", "CS Special Lab","CS Lecturer's Room",
   "CS Demonstrator's Room", "CS Main-auditorium",
  "CS E-Learning Center","CS Conference Room","CS Head's Room","CS Computer lab 02",
  "CS Record Room","CS Special Room"];

List<String> second_floor=[  "CS Mini-auditorium","CS Computer Lab 01","CS Instructors's Room"];
Map<String,int> departmentID={"Computer Science":1,"Zoology":2,"Chemistry":3,"Botany":4,"Physics":5,"Mathematics":6};

const String GOOGL_KEY="AIzaSyD27-xwm_C9mv9V2mb2hki_XfzKTD5TYRg";
String port="https://uorroadmap.codemartlanka.com";
List<int> groundFloor=[14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46];
List<int> firstFloor=[5,6,7,8,9,10,11,12,13];
List<int> secondFloor=[1,2,3,4];


//Color
const routeColor=Color.fromARGB(255,40,122,198);
const floorColor=Color.fromARGB(150,25,162,150);
const stairColor=Colors.red;

//dotted line Colors
const routesDColor=Color.fromARGB(150, 40,122,198);
const floorDColor=Color.fromARGB(150,25,162,150);
const stairDColor=Colors.red;
//width
const int routeWidth=7;
const int floorWidth=3;
const int stairWidth=7;

const MAX_FLOOR=3;
const GROUND_FLOOR=0;
const FIRST_FLOOR=1;
const SECOND_FLOOOR=2;
const double ZOOM=20.0;

const List<double> uorMainGate=[5.937777, 80.574449];
double currentLat2=5.937777;
double currentLng2= 80.574449;
/*
  01-Lecture's Room               
  02-Instructor's Room            
  03-Computer Lab 01              
  04-Mini-auditorium              
  05-Head's room                  
  06-Conference Room              
  07-Record Room                 
  08-Special Lab                  
  09-Computer lab 02
  10-E-Learning Center
  11-Special Room
  12-Demostrator's Room
  13-Main-auditorium
  14-Car park
  15-Wash Rooms (CS)
  16-Computer Lab 03
  17-Lecture Hall 01
  18-Server Room
  19-Car park 
  20-Wash Rooms (CS)
  21-Computer Lab 01
  22-Main Gate
  23-Library
  24-Scenes Library
  25-Scenes Auditorium
  26-Scenes Cantin
  27-Art Cantin
  28-Auditorium
*/