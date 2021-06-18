import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/repo/connection.dart';
import 'package:testgsschoolst/repo/shared_pref_helper.dart';
import 'package:testgsschoolst/repo/theme.dart';
import 'package:testgsschoolst/screens/account/screens/select_image_profile.dart';
import 'package:testgsschoolst/screens/account/services/multi_account_services.dart';
import 'package:testgsschoolst/screens/account/services/personal_information_notifer.dart';
import 'package:testgsschoolst/screens/attendances/services/attendance_notifer.dart';
import 'package:testgsschoolst/screens/behave/services/behave_notifer.dart';
import 'package:testgsschoolst/screens/books/services/books_notifer.dart';
import 'package:testgsschoolst/screens/chat_screen/services/chat_notifer.dart';
import 'package:testgsschoolst/screens/chat_screen/services/messages_notifer.dart';
import 'package:testgsschoolst/screens/dash_board/services/dash_board_notifer.dart';
import 'package:testgsschoolst/screens/events/services/event_notifer.dart';
import 'package:testgsschoolst/screens/exames/services/exam_notifer.dart';
import 'package:testgsschoolst/screens/homeworks/services/homeworks_notifer.dart';
import 'package:testgsschoolst/screens/online_quizs/services/online_quiz_notifer.dart';
import 'package:testgsschoolst/screens/prepare.dart';
import 'package:testgsschoolst/screens/schedule/services/schedule_notifer.dart';
import 'package:testgsschoolst/screens/splash_screen.dart';
import 'package:testgsschoolst/screens/student/services/student_notifer.dart';
import 'package:testgsschoolst/screens/subjects/services/subjects_notifer.dart';

import 'localization/app_local.dart';
import 'localization/ku_local.dart';
import 'locator.dart';
import 'repo/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true);
  Paint.enableDithering = true;
  await setUpLocalDataBase();

  setUpLocator();
  await locator<SharedPrefrenceHalper>().initData();
  await locator<MultuAccountServices>().initDatas();

  runApp(MyApp());
}

final myTheme = MyTheme();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      // DeviceOrientation.portraitDown,
      // DeviceOrientation.portraitUp,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final darkTextTheme = TextTheme(
    //   bodyText1: TextStyle(color: Colors.white),
    //   bodyText2: TextStyle(color: _kSecondaryColor),
    //   button: TextStyle(color: _kBlackColor),
    //   caption: TextStyle(color: _kBlackColor),
    //   subtitle1: TextStyle(color: _kBlackColor),
    //   subtitle2: TextStyle(color: Colors.white),
    //   headline1: TextStyle(color: _kBlackColor),
    //   headline2: TextStyle(color: _kBlackColor),
    //   headline3: TextStyle(color: _kBlackColor),
    //   headline4: TextStyle(color: _kBlackColor),
    //   headline5: TextStyle(color: _kBlackColor),
    //   headline6: TextStyle(color: Colors.white),
    // );
    // final lightTextTheme = TextTheme(
    //   bodyText1: TextStyle(color: _kBlackColor),
    //   bodyText2: TextStyle(color: _kSecondaryColor),
    //   button: TextStyle(color: _kBlackColor),
    //   caption: TextStyle(color: _kBlackColor),
    //   subtitle1: TextStyle(color: _kBlackColor),
    //   subtitle2: TextStyle(color: Colors.white),
    //   headline1: TextStyle(color: _kBlackColor),
    //   headline2: TextStyle(color: _kBlackColor),
    //   headline3: TextStyle(color: _kBlackColor),
    //   headline4: TextStyle(color: _kBlackColor),
    //   headline5: TextStyle(color: _kBlackColor),
    //   headline6: TextStyle(color: _kFirstPColor),
    // );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider(create: (_) => AttachmentNotifier()),
        ChangeNotifierProvider(create: (_) => BooksNotifer()),
        ChangeNotifierProvider(create: (_) => StudentNotifer()),
        ChangeNotifierProvider(create: (_) => HomeWorkNotifer()),
        ChangeNotifierProvider(create: (_) => SubJectsNotifer()),
        ChangeNotifierProvider(create: (_) => ConnectionNotifer()),
        ChangeNotifierProvider(create: (_) => PersonalInfoNotifier()),
        ChangeNotifierProvider(create: (_) => AttendanceNotifer()),
        ChangeNotifierProvider(create: (_) => DashBoardNotifer()),
        ChangeNotifierProvider(create: (_) => MessagesNotifer()),
        ChangeNotifierProvider(create: (_) => PrepareAppNotifier()),
        ChangeNotifierProvider(create: (_) => OnlineQuizNotifer()),
        ChangeNotifierProvider(create: (_) => ScheduleNotifer()),
        ChangeNotifierProvider(create: (_) => ExamesNotifer()),
        ChangeNotifierProvider(create: (_) => ChatNotifer()),
        ChangeNotifierProvider(create: (_) => EventsNotifer()),
        ChangeNotifierProvider(create: (_) => BehaveNotifer()),
      ],
      child: Consumer<ThemeNotifier>(builder: (context, myType, child) {
        return OverlaySupport.global(
          child: MaterialApp(
            localizationsDelegates: [
              AppLocalizations.delegate,
              CkbWidgetLocalizations.delegate,
              CkbMaterialLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            theme: myType.isDark
                ? ThemeData.dark().copyWith(
                    //     scaffoldBackgroundColor: kDarkBackGroundColor,
                    //     selectedRowColor: _kSecondaryColor,
                    //     textSelectionTheme: TextSelectionThemeData(
                    //       cursorColor: _kFirstPColor,
                    //       selectionColor: _kFirstPColor,
                    //       selectionHandleColor: _kFirstPColor,
                    //     ),
                    //     primaryColor: _kFirstPColor,
                    //     accentColor: _kFirstPColor,
                    //     secondaryHeaderColor: _kSecondSColor,
                    //     unselectedWidgetColor: _kSecondaryColor,
                    //     toggleableActiveColor: _kSecondSColor,
                    //     inputDecorationTheme:
                    //         InputDecorationTheme(fillColor: _kTextFiledColor),
                    //     appBarTheme: AppBarTheme(
                    //         titleTextStyle: TextStyle(color: Colors.white)),
                    //     textTheme: darkTextTheme,
                    //     primaryTextTheme: darkTextTheme,
                    //     accentTextTheme: darkTextTheme
                    )
                : ThemeData.light().copyWith(
                    //     textSelectionTheme: TextSelectionThemeData(
                    //       cursorColor: _kFirstPColor,
                    //       selectionColor: _kFirstPColor,
                    //       selectionHandleColor: _kFirstPColor,
                    //     ),
                    //     primaryColor: _kFirstPColor,
                    //     accentColor: _kFirstPColor,
                    //     inputDecorationTheme:
                    //         InputDecorationTheme(fillColor: Colors.grey[300]),
                    //     scaffoldBackgroundColor: _kLightBackGroundColor,
                    //     colorScheme: ColorScheme.light(
                    //         primary: Colors.white, secondary: _kFirstPColor),
                    //     secondaryHeaderColor: _kFirstPColor.withOpacity(0.5),
                    //     selectedRowColor: _kFirstPColor.withOpacity(0.5),
                    //     unselectedWidgetColor: _kFirstPColor.withOpacity(0.5),
                    //     toggleableActiveColor: _kFirstPColor.withOpacity(0.5),
                    //     appBarTheme: AppBarTheme(
                    //         titleTextStyle: TextStyle(color: Colors.white)),
                    //     textTheme: lightTextTheme,
                    //     primaryTextTheme: lightTextTheme,
                    //     accentTextTheme: lightTextTheme,
                    ),
            debugShowCheckedModeBanner: false,
            title: 'Hi Card',
            home: SplashScreen(),
            navigatorKey: navigatorKey,
            supportedLocales: [
              Locale('en', "US"),
              Locale('ar', "UAE"),
              Locale('ku', 'ckb'),
              Locale('pa'),
              Locale('tr')
            ],
            locale: getLocale(myType.lang),
          ),
        );
      }),
    );
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Locale getLocale(String lang) {
  myPrint("lang $lang");
  if (lang == "ar") {
    return Locale('ar', "UAE");
  } else if (lang == "tr") {
    return Locale('tr');
  } else if (lang == "pa") {
    return Locale('pa');
  } else if (lang == "ku") {
    return Locale('ku', 'ckb');
  }
  return Locale('en', "US");
}

// Color _kFirstPColor = Color(0xFFf20fb6);
// Color _kSecondaryColor = Colors.black;
// Color _kBlackColor = Color(0xFF16161A);
// Color _kFirstSColor = Color(0xFFFECECEC);
// Color kDarkBackGroundColor = Color(0xFF363636);
// Color kDarkBackGroundColor = Color(0xFF16161A);
// Color _kLightBackGroundColor = Color(0xFFFff5f5);
// Color _kTextFiledColor = Color(0xFF242629);
// Color _kSecondSColor = Color(0xFF898989);
// Color _kThirdSColor = Color(0xFF1b1b1b);
