import 'dart:io';

import 'package:flutter/material.dart';
import 'package:testgsschoolst/localization/local_keys.dart';
import 'package:testgsschoolst/main.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/screens/account/screens/crop_image.dart';
import 'package:testgsschoolst/widget/alerts/faliedAlert.dart';
import 'package:testgsschoolst/widget/alerts/permsseion_not_allowed_alert.dart';
import 'package:testgsschoolst/widget/responsev.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

selectImage(context) {
  showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(10.0),
              topRight: const Radius.circular(10.0))),
      // useRootNavigator: true,
      builder: (BuildContext context) {
        return SafeArea(
          maintainBottomViewPadding: true,
          top: true,
          child: Container(
              child: SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    padding: EdgeInsets.only(left: 25, right: 25),
                    margin: EdgeInsets.zero,
                    decoration: new BoxDecoration(
                        color: Theme.of(navigatorKey.currentContext)
                            .secondaryHeaderColor,
                        borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(9.0),
                            topRight: const Radius.circular(9.0))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(Translate.selectImage.trans(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: Responsive().setSp(
                              24,
                            ))),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: new Icon(
                      Icons.photo_camera,
                      size: Responsive().setSp(30),
                    ),
                    title: new Text(
                      Translate.camera.trans(),
                      style: TextStyle(fontSize: Responsive().setSp(20)),
                    ),
                    onTap: () async {
                      Navigator.pop(navigatorKey.currentContext);
                      _pickImageCamera(ImageSource.camera);
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  new ListTile(
                    leading: new Icon(
                      Icons.photo_library,
                      size: Responsive().setSp(30),
                    ),
                    title: new Text(
                      Translate.gallery.trans(),
                      style: TextStyle(fontSize: Responsive().setSp(20)),
                    ),
                    onTap: () async {
                      Navigator.pop(navigatorKey.currentContext);
                      _pickImageCamera(ImageSource.gallery);
                    },
                  ),
                  attachmentNotifier.getFile != null
                      ? Column(
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            new ListTile(
                              leading: new Icon(
                                Icons.cancel,
                                size: Responsive().setSp(30),
                              ),
                              title: new Text(
                                Translate.delete.trans(),
                                style:
                                    TextStyle(fontSize: Responsive().setSp(20)),
                              ),
                              onTap: () async {
                                Navigator.pop(navigatorKey.currentContext);
                                attachmentNotifier.setFile = null;
                              },
                            ),
                          ],
                        )
                      : Container(),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          )),
        );
      });
}

final picker = ImagePicker();

_pickImageCamera(ImageSource source) async {
  try {
    PermissionStatus havePer = await Permission.camera.request();
    myPrint("havePer $havePer");
    if (havePer.isGranted) {
      final pickedFile = await picker.getImage(source: source);

      if (pickedFile != null) {
        Navigator.push(
            navigatorKey.currentContext,
            MaterialPageRoute(
                builder: (_) => SimpleCropRoute(
                      isAttachmen: true,
                      file: File(pickedFile.path),
                    )));
      } else {
        myPrint('No image selected.');
      }
    } else {
      permissionNotAllowedAlert(source == ImageSource.gallery
          ? Translate.appHasNotAccessToAlbum.trans()
          : Translate.appHasNotAccessToCamera.trans());
    }
  } catch (e) {
    myPrint(e);
    if (e.toString().toUpperCase().contains("denied".toUpperCase())) {
      permissionNotAllowedAlert(source == ImageSource.gallery
          ? Translate.appHasNotAccessToAlbum.trans()
          : Translate.appHasNotAccessToCamera.trans());
      return;
    }
    failedAlert(error: Translate.failed.trans());
  }
}
