import 'dart:io';
import 'package:flutter/material.dart';
import 'package:testgsschoolst/localization/local_keys.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/screens/account/screens/select_image_bottom_sheet.dart';
import 'package:testgsschoolst/screens/account/screens/select_image_profile.dart';
import 'package:testgsschoolst/screens/account/screens/show_attachment_file.dart';
import 'package:testgsschoolst/screens/account/services/account_services.dart';
import 'package:testgsschoolst/widget/alerts/loading_alert.dart';
import 'package:testgsschoolst/widget/alerts/show_toast.dart';
import 'package:testgsschoolst/widget/responsev.dart';
import 'package:testgsschoolst/widget/simple_button.dart';
import 'package:provider/provider.dart';

class SetProfilePicture extends StatefulWidget {
  @override
  _SetProfilePictureState createState() => _SetProfilePictureState();
}

class _SetProfilePictureState extends State<SetProfilePicture> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Size scSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: textTheme.bodyText1.color,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsetsDirectional.only(start: 10, end: 10),
          child: Container(
            constraints: BoxConstraints(minHeight: scSize.height - 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Align(
                      alignment: AlignmentDirectional.center,
                      child: Text(
                        Translate.profile.trans(),
                        style: textTheme.headline3.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                    ),
                    SizedBox(
                      height: Responsive().setHeight(200),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Container(
                              height: Responsive().setHeight(400),
                              width: Responsive().setHeight(400),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: textTheme.headline2.color),
                              ),
                              child: Selector<AttachmentNotifier, File>(
                                  selector: (buildContext, countPro) =>
                                      countPro.getFile,
                                  builder: (context, file, child) {
                                    myPrint(file);
                                    return ClipOval(
                                      child: file != null
                                          ? InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            ShowAttAchmentFromFile(
                                                              url: file.path,
                                                            )));
                                              },
                                              child: Image.file(
                                                file,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : Image.asset(
                                              'assets/logs/logo.jpg'),
                                    );
                                  })),
                          CircleAvatar(
                              child: IconButton(
                                  icon: Icon(Icons.camera_alt),
                                  onPressed: () {
                                    selectImage(context);
                                  })),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 20),
                      child: SizedBox(
                        width: double.maxFinite,
                        child: Selector<AttachmentNotifier, File>(
                            selector: (buildContext, countPro) =>
                                countPro.getFile,
                            builder: (context, file, child) {
                              return SimpleButton(
                                                              fontSize: Responsive().setSp(20),

                              txtColor: Theme.of(context).textTheme.bodyText1.color,
                                  text:
                                      "${attachmentNotifier.getFile == null ? 'Skip' : "Save"}",
                                  onPres: () {
                                    saveImage();
                                  },
                                  hight: Responsive().setHeight(100));
                            }),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final AccountServices loginServices = locator<AccountServices>();
  saveImage() async {
    if (attachmentNotifier.getFile.path == null) {
      showToast( Translate.selectImage.trans());
      return;
    }
    showLoadingProgressAlert();
    loginServices.updateImages(path: attachmentNotifier.getFile.path);
  }
}
