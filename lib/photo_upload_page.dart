import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photoapp/styles/appstyles.dart';
import 'package:crypto/crypto.dart';
import 'package:photoapp/viewcontroller/todo_viewController.dart';
import 'package:photoapp/widgets/customalertprogressIndicator.dart';

import 'helper/hash_helpers.dart';
import 'helper/image_helper_methods.dart';

class PhotoUploadPage extends StatefulWidget {
  PhotoUploadPage({Key? key}) : super(key: key);

  @override
  _PhotoUploadPageState createState() {
    return _PhotoUploadPageState();
  }
}

class _PhotoUploadPageState extends State<PhotoUploadPage> {
  TextEditingController txtPhotoController = TextEditingController();
  PickedFile? image;
  String hash = "";
  String newImagePath = "";

  @override
  void initState() {
    super.initState();
    txtPhotoController.text = "No File Chosen";
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Spacer(),
              if (image != null)
                Card(
                  child: Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width - 70,
                      child: Image.file(File(image!.path))),
                ),

              SizedBox(
                height: 20,
              ),
              Text(
                "Please choose a photo to generate it's hash",
                style: AppStyle.primaryTextStyleHeading(),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 10),
                child: Text("Photo",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
              ),
              SizedBox(
                height: 3,
              ),
              Container(
                // decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(30),
                //     border: Border.all()),
                //  height: 35,
                child: TextFormField(
                  readOnly: true,
                  validator: (val) =>
                      val == "No File Chosen" ? "No File Chosen" : null,
                  onTap: () {
                    _showPhotoPicker(context);
                  },
                  controller: txtPhotoController,
                  style: AppStyle.primaryTextStyleb(),
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(104.50),
                          color: Color(0xffDEDEDE),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 14.0, right: 14, top: 8, bottom: 8),
                          child: Text(
                            "Choose Photo",
                            style: AppStyle.primaryTextStyleb(),
                          ),
                        ),
                      ),
                    ),
                    filled: true,
                    errorStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    contentPadding:
                        EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(width: 1, color: Colors.black),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              if(newImagePath.isNotEmpty)
                Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text.rich(
                  TextSpan(
                      text: "Image saved to:  ",
                      style: AppStyle.primaryTextStylenormalBold(),
                      children: [
                        TextSpan(
                            text: newImagePath.isNotEmpty ? newImagePath : "N/A",
                            style: AppStyle.primaryTextStylenormal()),
                        TextSpan(
                            text: newImagePath.isNotEmpty ? " (App's Secure Location)" : "",
                            style: AppStyle.primaryTextStylenormalBoldItalics())
                      ]),
                  maxLines: 3,
                ),
              ),

              SizedBox(
                height: 10,
              ),
              if(hash.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text.rich(
                  TextSpan(
                      text: "Hash:  ",
                      style: AppStyle.primaryTextStylenormalBold(),
                      children: [
                        TextSpan(
                            text: hash.isNotEmpty ? hash : "N/A",
                            style: AppStyle.primaryTextStylenormal())
                      ]),
                  maxLines: 3,
                ),
              ),
              Spacer(),
              Padding(
                padding:
                    const EdgeInsets.only(top: 2, right: 8, bottom: 2, left: 1),
                child: RaisedButton.icon(
                  onPressed: () {
                    if (image != null)
                      verifyHash();
                    else
                      Get.showSnackbar(GetSnackBar(
                        title: 'No photo chosen',
                        message: 'Please choose a photo first',
                        duration: Duration(seconds: 7),
                      ));
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  label: Text(
                    'Verify Hash',
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: Icon(
                    Icons.verified_user_rounded,
                    color: Colors.white,
                  ),
                  textColor: Colors.white,
                  color: Colors.indigoAccent,
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Method for image picker dialogue

  void _showPhotoPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Photo Library'),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  //Method to choose image from camera

  _imgFromCamera() async {
    image = await ImagePicker.platform
        .pickImage(source: ImageSource.camera, imageQuality: 50);

    getImageHash(image);
  }

  //Method to choose image from gallery

  _imgFromGallery() async {
    image = await ImagePicker.platform
        .pickImage(source: ImageSource.gallery, imageQuality: 50);

    getImageHash(image);
  }

  //Method to save image and get image hash
  getImageHash(image) async {

    ImageHelpers.saveImageToSecureDir(image).then((img) async {
      hash = await HashHelpers.generateImageHash(File(img.path));
      setState(() {
        newImagePath = img.path;
        txtPhotoController.text = img.path.split('/').last;
      });

    });
  }

  //Method to verify image hash

  Future<void> verifyHash() async {
    customAlertProgressIndicator(context);
    var result = TodoViewController.getTodo();
    if (result != null) {
      Get.showSnackbar(GetSnackBar(
        title: "Congratulations",
        message: 'Hash verified successfully',
      ));
    }
    Navigator.of(context).pop();
  }
}
