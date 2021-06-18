import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';
import 'package:testgsschoolst/localization/local_keys.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/screens/account/screens/chang_names.dart';
import 'package:testgsschoolst/screens/account/screens/change_password.dart';
import 'package:testgsschoolst/screens/account/screens/select_image_bottom_sheet.dart';
import 'package:testgsschoolst/screens/account/services/account_services.dart';
import 'package:testgsschoolst/screens/account/services/personal_information_notifer.dart';
import 'package:testgsschoolst/widget/alerts/loading_alert.dart';
import 'package:testgsschoolst/widget/alerts/show_toast.dart';
import 'package:testgsschoolst/widget/net_image_cheker.dart';
import 'package:testgsschoolst/widget/responsev.dart';
import 'package:testgsschoolst/widget/state_widget/view_profile_image.dart';

class AccountSettingScreen extends StatefulWidget {
  const AccountSettingScreen({Key key}) : super(key: key);

  @override
  _AccountSettingScreenState createState() => _AccountSettingScreenState();
}

class _AccountSettingScreenState extends State<AccountSettingScreen> {
  @override
  void dispose() {
    Future.delayed(Duration.zero).then((value) {
      personalInfoNotifier.changeFileImage(null);
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              Translate.setting.trans(),
            ),
            centerTitle: true,
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<PersonalInfoNotifier>(
                  builder: (context, myType, child) {
                myPrint(
                    "myType.accountModel.image   ${myType.accountModel.image}");
                String fullname = "";
                if (myType.accountModel.firstName != null) {
                  fullname = myType.accountModel.firstName;
                }
                if (myType.accountModel.middleName != null) {
                  fullname = fullname + " ${myType.accountModel.middleName}";
                }
                if (myType.accountModel.firstName != null) {
                  fullname = fullname + " ${myType.accountModel.lastName}";
                }

                return ListView(
                  children: [
                    SizedBox(height: Responsive().setHeight(50)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => ViewProfileImage(
                                            isFile: myType.fileImage != null,
                                            title: Translate.profile.trans(),
                                            url: myType.fileImage != null
                                                ? myType.fileImage.path
                                                : myType.accountModel.image)));
                              },
                              child: Center(
                                child: Hero(
                                  tag: "123456",
                                  child: Container(
                                      width: Responsive().setWidth(200),
                                      height: Responsive().setWidth(200),
                                      child: Container(
                                        width: Responsive().setWidth(125),
                                        height: Responsive().setWidth(125),
                                        decoration: new BoxDecoration(
                                          color: Colors.grey,
                                          shape: BoxShape.circle,
                                        ),
                                        child: ClipOval(
                                            clipBehavior: Clip.hardEdge,
                                            child: myType.fileImage != null
                                                ? Image.file(myType.fileImage,
                                                    fit: BoxFit.fill)
                                                : myType.accountModel.image !=
                                                            null &&
                                                        myType.accountModel
                                                                .image !=
                                                            "null"
                                                    ? NetImageChecker(
                                                        linkImage: myType
                                                            .accountModel.image,
                                                        additonalPath: myType
                                                            .accountModel.image,
                                                        tempImage:
                                                            "assets/images/profile_image.png",
                                                        boxFit: BoxFit.cover,
                                                        errorImage:
                                                            "assets/images/profile_image.png")
                                                    : Image.asset(
                                                        'assets/images/profile_image.png')),
                                      ),
                                      decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey[300],
                                      )),
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                width: Responsive().setWidth(200),
                                height: Responsive().setWidth(200),
                                padding: EdgeInsets.all(5),
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(45.0))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: InkWell(
                                      onTap: () {
                                        FocusScope.of(context).unfocus();
                                        selectImage(context);
                                      },
                                      child: Icon(
                                        FontAwesomeIcons.camera,
                                        color: Colors.black,
                                        size: Responsive().setWidth(30),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        myType.fileImage != null
                            ? Column(
                                children: [
                                  SizedBox(height: 25),
                                  Container(
                                    child: InkWell(
                                      onTap: () async {
                                        FocusScope.of(context).unfocus();
                                        upLoadImage();
                                      },
                                      child: Container(
                                          width: Responsive().setWidth(150),
                                          height: Responsive().setWidth(50),
                                          padding: EdgeInsets.all(10),
                                          decoration: new BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                new BorderRadius.circular(45.0),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            Translate.save.trans(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: Theme.of(context)
                                                  .selectedRowColor,
                                              fontSize: Responsive().setSp(
                                                18,
                                              ),
                                            ),
                                          )),
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                      ],
                    ),
                    SizedBox(height: 25),
                    Card(
                      child: InkWell(
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EditPersonalInfoScreen()));
                        },
                        child: Container(
                          decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.circular(45.0),
                          ),
                          child: ListTile(
                            trailing: Icon(FontAwesomeIcons.edit,
                                size: Responsive().setSp(26)),
                            title: Text(
                              fullname,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: Responsive().setSp(
                                  20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Card(
                      child: InkWell(
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ChangePasswordScreen()));
                        },
                        child: Container(
                          decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.circular(45.0),
                          ),
                          child: ListTile(
                            trailing: Icon(FontAwesomeIcons.lock,
                                size: Responsive().setSp(26)),
                            title: Text(
                              Translate.changePassword.trans(),
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: Responsive().setSp(
                                  20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                  ],
                );
              }),
            ),
          )),
    );
  }

  AccountServices accountServices = locator<AccountServices>();

  upLoadImage() async {
    if (connectionNotifer.isConnected != true) {
      showToast(Translate.connectToNetAndRetryAgain.trans());
      return;
    }
    showLoadingProgressAlert();
    accountServices.updateImages(path: personalInfoNotifier.fileImage.path);
  }
}
