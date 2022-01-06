import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photoapp/viewcontroller/todo_viewController.dart';
import 'package:photoapp/widgets/customalertprogressIndicator.dart';

class HashHelpers {

  static Future<String> generateImageHash(File file) async{
    var image_bytes =  file.readAsBytesSync().toString();
    var bytes = utf8.encode(image_bytes); // data being hashed
    String digest = sha256.convert(bytes).toString();
    return  digest;
  }


  static Future<void> verifyHash(context) async {
    customAlertProgressIndicator(context);
    var result = TodoViewController.getTodo();
    if(result != null){
      Get.showSnackbar(GetSnackBar(title: "Hash verified successfully",));
    }
    Navigator.of(context).pop();
  }
}