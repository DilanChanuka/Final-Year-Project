import 'package:flutter/material.dart';
import 'package:UorMap/Screens/LocationShare/Friends/AddFriends.dart';
import 'package:UorMap/Screens/Map/Display/Notification.dart';
import 'package:UorMap/Screens/Request/Send_Request.dart';
import 'package:UorMap/Screens/Request/Location_shearing.dart';
import '../../../constanents.dart';
import 'package:UorMap/Screens/Common/data.dart';

List<dynamic> firendList=new List<dynamic>();

class Friends extends StatefulWidget {

  Friends(List<dynamic> frends)
  {
    firendList=frends;
    if(firendList==null)
        firendList=[];
  }

  @override
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: firendList.length,
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
                    child: Text(firendList[i],
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
                      width: (MediaQuery.of(context).size.width * 0.3),
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
                        border: Border.all(color: colorgreen),
                      ),
                      child: RaisedButton(
                        elevation: 5.0,
                        color: tridColor,
                        /*shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height / 30),
                        ),*/
                        onPressed: (){

  /*                           setState((){
                                      addfrendList.add(firendList[i]);
                                      firendList.removeAt(i);
                                    });
*/

                          String msg="Unable Remove Firend. \nPlease try Again..!";
                          bool remove=false;
                          List<String> parm=[user,firendList[i]];
                          String url=getRemoveFirendRequest(parm);
                          Future<bool> myfuture=sendRequest(url);

                          myfuture.then((value) => {
                              if(value){
                                  setState((){
                                      addfrendList.add(firendList[i]);
                                      firendList.removeAt(i);
                                    }),
                                  remove=true,
                                  setMessage("Your Request Succesfull Updated.....!")
                              }else
                                  showMessages(context,msg),
                            });

                              setState(() {
                                if(remove)
                                firendList.removeAt(i);  
                              });

                        },
                        child: Text("Remove",
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.5,
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