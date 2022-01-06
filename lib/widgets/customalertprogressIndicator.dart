import 'package:flutter/material.dart';

customAlertProgressIndicator(BuildContext context) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctxt) => new WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
              title: Row(
            children: <Widget>[
              CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor),
              ),
              SizedBox(
                width: 25,
              ),
              Text(
                "Please wait...",
                style: TextStyle(fontSize: 18),
              )
            ],
          ))));
}