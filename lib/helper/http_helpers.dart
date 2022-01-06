import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HttpHelpers {
  static bool sessionTimeout = false;

  static int timeoutException = 30;

  static postAnonymousRequest(String url, var data) async {
    var response;
    try {
      var url_uri = Uri.parse(url);
      response = await http.post(url_uri,
          body: json.encode(data),
          headers: {"Content-Type": "application/json"});
    } on TimeoutException catch (e) {
      // handle timeout
      showSnackBar();
      return null;
    } catch (ex) {
      return null;
    }

    return response;
  }

  static getAnonymousRequest(String url) async {
    var response;
    try {
      var url_uri = Uri.parse(url);
      response =
          await http.get(url_uri).timeout(Duration(seconds: timeoutException));
    } on TimeoutException catch (e) {
      // handle timeout
      showSnackBar();
      return null;
    } catch (ex) {
      return null;
    }

    return response;
  }

  static void showSnackBar() {
    Get.back();
    Get.showSnackbar(GetSnackBar(
      title: "You seem to have a slow internet connection",
      message: "Connection timed out please try again",
      duration: Duration(seconds: 7),
    ));
  }
}
