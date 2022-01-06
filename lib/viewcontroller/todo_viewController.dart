
import 'dart:convert';

import 'package:get/get.dart';
import 'package:photoapp/helper/endpoints.dart';
import 'package:photoapp/helper/http_helpers.dart';
import 'package:photoapp/models/todo.dart';

class TodoViewController {

  static getTodo() async {
    String todoNum = '1';
    Todo? todomodel;

    try {
      var response =
      await HttpHelpers.getAnonymousRequest(EndPoints.get_todo.replaceAll('{0}', todoNum));
      if (response.statusCode == 201 || response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

      }
    } catch (ex) {
      return null;
    }

    return todomodel;
  }
}