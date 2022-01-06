 import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ImageHelpers {

  static Future<File> saveImageToSecureDir(image) async {
    var dir = await getApplicationDocumentsDirectory();
    final String path = dir.path;

    File imgOriginalFile = File(image!.path);

    final File newImage = await imgOriginalFile.copy('$path/image1.png');

    return newImage;
  }
}