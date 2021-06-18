// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:testgsschoolst/localization/local_keys.dart';
// import 'package:testgsschoolst/locator.dart';
// import 'package:testgsschoolst/main.dart';
// import 'package:testgsschoolst/repo/validations.dart';
// import 'package:testgsschoolst/screens/account/screens/select_image_bottom_sheet.dart';
// import 'package:testgsschoolst/screens/account/screens/select_image_profile.dart';
// import 'package:testgsschoolst/screens/account/services/account_services.dart';
// import 'package:testgsschoolst/screens/account/services/personal_information_notifer.dart';
// import 'package:testgsschoolst/widget/alerts/loading_alert.dart';
// import 'package:testgsschoolst/widget/alerts/show_toast.dart';
// import 'package:testgsschoolst/widget/net_image_cheker.dart';
// import 'package:testgsschoolst/widget/responsev.dart';
// import 'package:testgsschoolst/widget/simple_button.dart';
// import 'package:testgsschoolst/widget/state_widget/view_profile_image.dart';

// class EditAccountScreen extends StatefulWidget {
//   @override
//   _EditAccountScreenState createState() => _EditAccountScreenState();
// }

// String imageUpdated = DateTime.now().toIso8601String();

// class _EditAccountScreenState extends State<EditAccountScreen> {
//   TextEditingController _firstName;
//   TextEditingController _lastName;

//   TextEditingController _middleName;

//   GlobalKey<FormState> _fromKey = GlobalKey<FormState>(
//       debugLabel: "werthjyuegrhergsdfsdfsdejyhregwghtujyhtge");

//   @override
//   void initState() {
//     super.initState();

//     _firstName = TextEditingController(
//         text: personalInfoNotifier.accountModel.firstName);
//     _lastName = TextEditingController(
//         text: personalInfoNotifier.accountModel.lastName);
//     _middleName = TextEditingController(
//         text: personalInfoNotifier.accountModel.middleName);
//   }

//   @override
//   Widget build(BuildContext context) {
//     TextTheme textTheme = Theme.of(context).textTheme;
//     Size scSize = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: BackButton(),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsetsDirectional.only(start: 10, end: 10),
//           child: Container(
//             constraints: BoxConstraints(minHeight: scSize.height - 100),
//             child: Form(
//               key: _fromKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Align(
//                         alignment: AlignmentDirectional.centerStart,
//                         child: Padding(
//                           padding: const EdgeInsetsDirectional.only(start: 10),
//                           child: Text(
//                             Translate.editPersonalInformation.trans(),
//                             style: textTheme.headline4.copyWith(
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                       Align(
//                         alignment: Alignment.center,
//                         child: Stack(
//                           alignment: AlignmentDirectional.bottomEnd,
//                           children: [
//                             Container(
//                                 height: Responsive().setHeight(200),
//                                 width: Responsive().setHeight(200),
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   border: Border.all(
//                                       color: textTheme.headline2.color),
//                                 ),
//                                 child: Selector<PersonalInfoNotifier, String>(
//                                     selector: (buildContext, countPro) =>
//                                         countPro.accountModel.image,
//                                     builder: (context, image, child) {
//                                       return Selector<AttachmentNotifier, File>(
//                                           selector: (buildContext, countPro) =>
//                                               countPro.getFile,
//                                           builder: (context, file, child) {
//                                             myPrint(
//                                                 "imageimageimageimage $image");
//                                             myPrint(file);
//                                             return ClipOval(
//                                               child: file != null
//                                                   ? InkWell(
//                                                       onTap: () {
//                                                         Navigator.push(
//                                                             context,
//                                                             MaterialPageRoute(
//                                                                 builder: (_) => ViewProfileImage(
//                                                                     title: Translate
//                                                                         .profile
//                                                                         .trans(),
//                                                                     isFile:
//                                                                         true,
//                                                                     url: file
//                                                                         .path)));
//                                                       },
//                                                       child: Image.file(
//                                                         file,
//                                                         fit: BoxFit.cover,
//                                                       ),
//                                                     )
//                                                   : image != null
//                                                       ? InkWell(
//                                                           onTap: () {
//                                                             Navigator.push(
//                                                                 context,
//                                                                 MaterialPageRoute(
//                                                                     builder: (_) => ViewProfileImage(
//                                                                         title: Translate
//                                                                             .profile
//                                                                             .trans(),
//                                                                         isFile:
//                                                                             false,
//                                                                         url:
//                                                                             image)));
//                                                           },
//                                                           child:
//                                                               NetImageChecker(
//                                                             boxFit:
//                                                                 BoxFit.cover,
//                                                             additonalPath:
//                                                                 imageUpdated,
//                                                             errorImage:
//                                                                 'assets/images/profile.png',
//                                                             linkImage: image,
//                                                             tempImage:
//                                                                 'assets/images/profile.png',
//                                                           ),
//                                                         )
//                                                       : Image.asset(
//                                                           'assets/logs/logo.jpg'),
//                                             );
//                                           });
//                                     })),
//                             CircleAvatar(
//                                 child: IconButton(
//                                     icon: Icon(Icons.camera_alt),
//                                     onPressed: () {
//                                       selectImage(context);
//                                     })),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Selector<AttachmentNotifier, File>(
//                           selector: (buildContext, countPro) =>
//                               countPro.getFile,
//                           builder: (context, file, child) {
//                             return file != null
//                                 ? Column(
//                                     children: [
//                                       SizedBox(height: 25),
//                                       Container(
//                                         child: InkWell(
//                                           onTap: () async {
//                                             FocusScope.of(context).unfocus();
//                                             upLoadImage();
//                                           },
//                                           child: Container(
//                                               width: Responsive().setWidth(150),
//                                               height: Responsive().setWidth(50),
//                                               padding: EdgeInsets.all(10),
//                                               decoration: new BoxDecoration(
//                                                 color: Theme.of(context)
//                                                     .primaryColor,
//                                                 borderRadius:
//                                                     new BorderRadius.circular(
//                                                         45.0),
//                                               ),
//                                               alignment: Alignment.center,
//                                               child: Text(
//                                                 Translate.saveChanges.trans(),
//                                                 style: TextStyle(
//                                                   fontWeight: FontWeight.normal,
//                                                   color: Theme.of(context)
//                                                       .selectedRowColor,
//                                                   fontSize: Responsive().setSp(
//                                                     18,
//                                                   ),
//                                                 ),
//                                               )),
//                                         ),
//                                       ),
//                                     ],
//                                   )
//                                 : Container();
//                           }),
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(top: 20, bottom: 10),
//                         child: Card(
//                           elevation: 4,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.only(
//                                   topRight: Radius.circular(25),
//                                   topLeft: Radius.circular(25),
//                                   bottomRight: Radius.circular(25))),
//                           child: TextFormField(
//                             controller: _firstName,
//                             keyboardType: TextInputType.text,
//                             autovalidateMode:
//                                 AutovalidateMode.onUserInteraction,
//                             validator: validateName,
//                             decoration: InputDecoration(
//                                 focusedBorder: myTheme.textFormField,
//                                 enabledBorder: myTheme.textFormField,
//                                 hintText: Translate.firstName.trans(),
//                                 prefixIcon: Icon(
//                                   Icons.person,
//                                   color: Colors.grey,
//                                 )),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 10, bottom: 10),
//                         child: Card(
//                           elevation: 4,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.only(
//                                   topRight: Radius.circular(25),
//                                   topLeft: Radius.circular(25),
//                                   bottomRight: Radius.circular(25))),
//                           child: TextFormField(
//                             controller: _middleName,
//                             autovalidateMode:
//                                 AutovalidateMode.onUserInteraction,
//                             validator: validateName,
//                             keyboardType: TextInputType.text,
//                             decoration: InputDecoration(
//                                 errorBorder: InputBorder.none,
//                                 focusedBorder: myTheme.textFormField,
//                                 enabledBorder: myTheme.textFormField,
//                                 hintText: Translate.middleName.trans(),
//                                 prefixIcon: Icon(
//                                   Icons.person,
//                                   color: Colors.grey,
//                                 )),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 10, bottom: 10),
//                         child: Card(
//                           elevation: 4,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.only(
//                                   topRight: Radius.circular(25),
//                                   topLeft: Radius.circular(25),
//                                   bottomRight: Radius.circular(25))),
//                           child: TextFormField(
//                             controller: _lastName,
//                             validator: validateName,
//                             keyboardType: TextInputType.text,
//                             autovalidateMode:
//                                 AutovalidateMode.onUserInteraction,
//                             decoration: InputDecoration(
//                                 errorBorder: InputBorder.none,
//                                 focusedBorder: myTheme.textFormField,
//                                 enabledBorder: myTheme.textFormField,
//                                 hintText: Translate.lastName.trans(),
//                                 prefixIcon: Icon(
//                                   Icons.person,
//                                   color: Colors.grey,
//                                 )),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(
//                             left: 10, right: 10, top: 30, bottom: 15),
//                         child: SizedBox(
//                           width: double.maxFinite,
//                           child: SimpleButton(
//                                                         fontSize: Responsive().setSp(20),

//                               txtColor:
//                                   Theme.of(context).textTheme.bodyText1.color,
//                               text: Translate.saveChanges.trans(),
//                               onPres: () {
//                                 _handle();
//                               },
//                               hight: Responsive().setHeight(60)),
//                         ),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   AccountServices accountServices = locator<AccountServices>();

//   upLoadImage() async {
//     if (connectionNotifer.isConnected != true) {
//       showToast(
//         Translate.checkInternet.trans(),
//       );
//       return;
//     }

//     showLoadingProgressAlert();

//     accountServices.updateImage(path: attachmentNotifier.getFile.path);
//   }

//   _handle() async {
//     myPrint(_fromKey.currentState.validate());
//     if (_fromKey.currentState.validate() == false) {
//       return;
//     }

//     showLoadingProgressAlert();

//     accountServices.editPersonalInfoMiddleWare(
//       firstName: _firstName.text.trim(),
//       lastName: _lastName.text.trim(),
//       middleName: _middleName.text.trim(),
//     );
//   }
// }
