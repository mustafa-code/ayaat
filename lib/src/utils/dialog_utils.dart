import 'package:flutter/material.dart';

import 'wavy_header.dart';

Future<bool> showCustomSuccessDialog(BuildContext context, {
  required String title,
  required String subtitle,
  required String positive,
  String? negative,
  Color? color,
  bool isDismissible = false,
}) async {
  return showCustomDialog(context,
      title: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white), ),
      color: color ?? Theme.of(context).primaryColor,
      subtitle: Text(subtitle, textAlign: TextAlign.center,),
      positiveLabel: Text(positive, style: TextStyle(color: Colors.white),),
      negativeLabel: negative == null? null :Text(negative, style: TextStyle(color: Colors.white),),
      negativeColor: Colors.grey,
      isDismissible: isDismissible,
      positiveColor: Theme.of(context).primaryColor);
}
Future<bool> showNoInternetDialog(BuildContext context) async {
  bool openSettings = await showCustomDialog(
    context,
    title: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image(
          image: AssetImage("assets/images/no_internet.png"),
          width: 128,
          height: 128,
        ),
        Text(
          "No Internet",
          style: TextStyle(
            fontSize: 18,
            color: Colors.orange,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
    subtitle: Text(
      ("Ooops, Please check your internet connection."),
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey,
      ),
    ),
    negativeLabel: Text(
      ("CANCEL"),
      style: TextStyle(color: Colors.black),
    ),
    positiveLabel: Text(
      ("SETTINGS"),
      style: TextStyle(color: Colors.white),
    ),
    negativeColor: Color(0xFFe6e6e6),
    positiveColor: Colors.orange,
    color: Theme.of(context).primaryColor,
  );
  if(openSettings){

  }
  return openSettings;
}

Future<bool> showCustomErrorDialog(BuildContext context, [
  String? title,
  String? subtitle,
  String? positiveLabel
]) async {
  return showCustomDialog(context,
    title: Text(title ?? ("Close App"),
      style: TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    color: Colors.red,
    subtitle: Text(
      subtitle ?? ("Are you sure to close the app?"),
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey,
      ),
    ),
    negativeLabel: Text(
      ("Ignore"),
      style: TextStyle(color: Colors.black),
    ),
    positiveLabel: Text(
      positiveLabel ?? ("Close"),
      style: TextStyle(color: Colors.white),
    ),
    negativeColor: Color(0xFFe6e6e6),
    positiveColor: Colors.red,
  );
}

Future<bool> showCustomDialog(BuildContext context, {
  required Widget title,
  Widget? subtitle,
  required Widget positiveLabel,
  Widget? negativeLabel,
  required Color negativeColor,
  required Color positiveColor,
  required Color color,
  bool isDismissible = true
}) async {
  // flutter defined function
  var status = await showDialog(
    context: context,
    barrierDismissible: isDismissible,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                title is Text?
                WavyHeader(
                  child: title,
                  color: color,
                ): title,
                SizedBox(height: 16,),
                Container(
                  padding: EdgeInsets.only(top: 0, bottom: 8, left: 16, right: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      subtitle ?? Container(),
                      subtitle == null ? Container() : const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: _getButtons(context, positiveLabel, positiveColor, negativeLabel, negativeColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          contentPadding: EdgeInsets.zero,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(16.0))
      );
    },
  );
  return status ?? false;
}

List<Widget> _getButtons(context, positiveLabel, positiveColor, negativeLabel, negativeColor){

  List<Widget> list = [
    RaisedButton(
        child: positiveLabel,
        onPressed: () async {
          Navigator.of(context).pop(true);
        },
        color: positiveColor,
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0))
    ),
  ];
  if(negativeLabel != null){
    list.add(RaisedButton(
        child: negativeLabel,
        onPressed: () {
          Navigator.of(context).pop(false);
        },
        color: negativeColor,
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0))
    ));
  }
  return list;
}


void showLoadingDialog(BuildContext context, [String? message]) {
  // flutter defined function
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(width: 32,),
            Expanded(child: Text(message ?? ("Loading..."))),
          ],
        ),
      );
    },
  );
}