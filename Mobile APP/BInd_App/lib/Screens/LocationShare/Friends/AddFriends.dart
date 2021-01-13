import 'package:flutter/material.dart';
import 'package:UorMap/Screens/Common/data.dart';
import 'package:UorMap/Screens/Map/Display/Notification.dart';
import 'package:UorMap/Screens/Request/Send_Request.dart';
import 'package:UorMap/Screens/Request/Location_shearing.dart';
import 'package:UorMap/constanents.dart';

List<dynamic> addfrendList=new List<dynamic>();

class AddFriends extends StatefulWidget {

  AddFriends(List<dynamic> frends)
  {
     addfrendList=frends;
     if(frends==null)
          addfrendList=[];
  }

  @override
  _AddFriendsState createState() => _AddFriendsState();
}

class _AddFriendsState extends State<AddFriends> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: addfrendList.length,
        itemBuilder: (BuildContext contxt,int i) => Column(
          children: <Widget>[
            Divider(
              height: 10.0,
              color: colorborder,
              thickness: 1.0,
            ), 
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: Text(addfrendList[i],
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: Container(
                      height: (MediaQuery.of(context).size.height / 20),
                      width: (MediaQuery.of(context).size.width * 0.2),
                      decoration: BoxDecoration(
                        //borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height / 30)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                        border: Border.all(color: clrblue),
                      ),
                      child: RaisedButton(
                        elevation: 5.0,
                        color: firstColor,//dummyAddFriends[i].pressed == false ? firstColor : tridColor,
                        /*shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height / 30),
                        ),*/
                        onPressed: (){
                          
                          List<String> parm=[user,addfrendList[i]];
                          String url=getAddFirendrequest(parm);
                          bool remove=false;
                         
                          String msg="Alredy You have send Request..!";
               
                            Future<bool> myfuture=sendRequest(url);
                            myfuture.then((value) =>{
                                if(value){
                                      setState((){
                                          addfrendList.removeAt(i);
                                      }),
                                      remove=true,
                                      setMessage("Your Request Succesfull.....!"),
                                    }else{
                                      showMessages(context,msg),
                                }               
                            }); 

                            setState(() {
                                if(remove)
                                addfrendList.removeAt(i);  
                              });                                       
                                                 
                        },
                        child: Text("Add",
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.3,
                            fontSize: MediaQuery.of(context).size.width / 22,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}