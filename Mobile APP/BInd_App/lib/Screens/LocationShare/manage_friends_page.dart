import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:UorMap/Screens/LocationShare/Friends/AddFriends.dart';
import 'package:UorMap/Screens/LocationShare/Friends/Friends.dart';
import 'package:UorMap/Screens/LocationShare/Friends/FriendsRequests.dart';
import 'package:UorMap/Screens/Map/Function/main_map.dart';
import 'package:UorMap/constanents.dart';
import 'package:UorMap/page_tran.dart';


List<dynamic> frendsData=new List<dynamic>();
//0=>add firends
//1=>frendRequest
//2=>other user (frends)
class Managefriends extends StatelessWidget
{

  Managefriends(List<dynamic> allresponse)
  {
      frendsData=allresponse;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: colorwhite,
        backgroundColor: firstColor,
      ),
      home: Body(),
    );
  }
}
class Body extends StatefulWidget
{
  @override
  _Bodycreate createState() => _Bodycreate();
}
class _Bodycreate extends State<Body> with SingleTickerProviderStateMixin
{
  TabController _tabController;
  SearchBar searchBar;

  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  AppBar buildAppBar(BuildContext context){
    return AppBar(
    actions: [searchBar.getSearchAction(context)],
    backgroundColor: firstColor,
      leading: IconButton(icon: Icon(
        Icons.arrow_back,
        size: MediaQuery.of(context).size.width / 15,
        color: mainColor,
      ),
        onPressed: () 
        {
          Navigator.push(context,MaterialPageRoute(builder: (context) => MainMap()));
          //_handleMainPage(context);
        },
      ),
      title: Text("Manage Friends",
          style: TextStyle(
          fontSize: MediaQuery.of(context).size.width / 20,
        ),
      ),
      bottom: TabBar(
        controller: _tabController,
        indicatorColor: mainColor,
        indicatorWeight: 3,
        tabs: [
          Tab(
            child: SingleChildScrollView(
              child: Text("Add \nFriends",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 20,
                  color: mainColor,
                ),
              ),
            ),
          ),
          Tab(
            child: SingleChildScrollView(
              child: Text("Friends \nRequests",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 20,
                  color: mainColor,
                ),
              ),
            ),
          ),
          Tab(
            child: SingleChildScrollView(
              child: Text("Friends",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 20,
                  color: mainColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  _Bodycreate(){
    searchBar = SearchBar(
      inBar: false,
      setState: setState,
      onSubmitted: print,
      buildDefaultAppBar: buildAppBar,
    );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          resizeToAvoidBottomInset: false,
          resizeToAvoidBottomPadding: false,
          appBar: searchBar.build(context),
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              AddFriends(frendsData[2]),
              FriendsRequests(frendsData[1]),
              Friends(frendsData[0]),
            ],
          ),
        ),
      
    );
  }

  Future<void> _handleMainPage(BuildContext context) async{
    try{
      Dialogs.showLoadingDialog(context,_keyLoader);
      await Future.delayed(Duration(seconds: 1,));
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();

      Navigator.push(context,MaterialPageRoute(builder: (context) => MainMap()));
    }
    catch(error){
      print(error);
    }
  }
}

