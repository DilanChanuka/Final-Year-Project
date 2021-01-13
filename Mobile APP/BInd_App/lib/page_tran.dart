import 'package:UorMap/constanents.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static Future<void> showLoadingDialog(
    BuildContext context,
    GlobalKey key) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return WillPopScope(
            child: SimpleDialog(
              key: key,
              backgroundColor: mainColor,
              children: <Widget>[
                Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 10.0,),
                      Text("Please Wait.....",
                      style: TextStyle(
                        color: Colors.blueAccent,
                      ),
                      ),
                    ],
                  ),
                ),
              ],
            ), 
            onWillPop: () async => false,
            );
        }
      );
    }
}