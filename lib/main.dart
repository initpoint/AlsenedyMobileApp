import 'package:ecommerce_app_ui_kit/src/services/cart.service.dart';
import 'package:ecommerce_app_ui_kit/src/services/chat.service.dart';
import 'package:ecommerce_app_ui_kit/src/services/customer.service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app_localizations.dart';
import 'package:ecommerce_app_ui_kit/config/app_config.dart' as config;
import 'package:ecommerce_app_ui_kit/route_generator.dart';
import 'package:ecommerce_app_ui_kit/src/screens/signin.dart';
import 'package:ecommerce_app_ui_kit/src/screens/tabs.dart';
import 'package:ecommerce_app_ui_kit/src/services/auth.service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) async {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.changeLanguage(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;

  initState() {
    getCurrentLanguage();
    super.initState();
  }

  getCurrentLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var currentLang = prefs.getString('lang');
    if (currentLang == "en") {
      _locale = Locale("en", "US");
    } else if (currentLang == "ar") {
      _locale = Locale("ar", "EG");
    }
  }

  changeLanguage(Locale locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lang', locale.languageCode);

    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CartService>(create: (_) => new CartRepo()),
        ChangeNotifierProvider<BaseChatService>(create: (_) => new ChatService()),
        ChangeNotifierProvider<BaseAuth>(create: (_) => new Auth()),
        ProxyProvider<BaseAuth, UsersService>(
            update: (context, baseAuth, usersService) =>
                new UsersRepo(baseAuth: baseAuth)),
        StreamProvider<FirebaseUser>(
            create: (_) => Auth().onAuthStateChanged()),
      ],
      child: MaterialApp(
        locale: _locale,
        title: 'Alsenedy',
        initialRoute: '/Auth',
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData(
          fontFamily: 'Poppins',
          primaryColor: Color(0xFF252525),
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Color(0xFF2C2C2C),
          accentColor: config.Colors().mainDarkColor(1),
          hintColor: config.Colors().secondDarkColor(1),
          focusColor: config.Colors().accentDarkColor(1),
          textTheme: TextTheme(
            button: TextStyle(color: Color(0xFF252525)),
            headline: TextStyle(
                fontSize: 20.0, color: config.Colors().secondDarkColor(1)),
            display1: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: config.Colors().secondDarkColor(1)),
            display2: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                color: config.Colors().secondDarkColor(1)),
            display3: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w700,
                color: config.Colors().mainDarkColor(1)),
            display4: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w300,
                color: config.Colors().secondDarkColor(1)),
            subhead: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                color: config.Colors().secondDarkColor(1)),
            title: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: config.Colors().mainDarkColor(1)),
            body1: TextStyle(
                fontSize: 12.0, color: config.Colors().secondDarkColor(1)),
            body2: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                color: config.Colors().secondDarkColor(1)),
            caption: TextStyle(
                fontSize: 12.0, color: config.Colors().secondDarkColor(0.7)),
          ),
        ),
        theme: ThemeData(
          fontFamily: 'Poppins',
          primaryColor: Colors.white,
          brightness: Brightness.light,
          accentColor: config.Colors().mainColor(1),
          focusColor: config.Colors().accentColor(1),
          hintColor: config.Colors().secondColor(1),
          textTheme: TextTheme(
            button: TextStyle(color: Colors.white),
            headline: TextStyle(
                fontSize: 20.0, color: config.Colors().secondColor(1)),
            display1: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: config.Colors().secondColor(1)),
            display2: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                color: config.Colors().secondColor(1)),
            display3: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w700,
                color: config.Colors().mainColor(1)),
            display4: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w300,
                color: config.Colors().secondColor(1)),
            subhead: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                color: config.Colors().secondColor(1)),
            title: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: config.Colors().mainColor(1)),
            body1: TextStyle(
                fontSize: 12.0, color: config.Colors().secondColor(1)),
            body2: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                color: config.Colors().secondColor(1)),
            caption: TextStyle(
                fontSize: 12.0, color: config.Colors().secondColor(0.6)),
          ),
        ),
        supportedLocales: [
          Locale('en', 'US'),
          Locale('ar', 'EG'),
        ],
        // These delegates make sure that the localization data for the proper language is loaded
        localizationsDelegates: [
          // THIS CLASS WILL BE ADDED LATER
          // A class which loads the translations from JSON files
          AppLocalizations.delegate,
          // Built-in localization of basic text for Material widgets
          GlobalMaterialLocalizations.delegate,
          // Built-in localization for text direction LTR/RTL
          GlobalWidgetsLocalizations.delegate,
        ],
        // Returns a locale which will be used by the app
        localeResolutionCallback: (locale, supportedLocales) {
          // Check if the current device locale is supported
          try {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale.languageCode &&
                  supportedLocale.countryCode == locale.countryCode) {
                return supportedLocale;
              }
            }
          } catch (e) {}
          // If the locale of the device is not supported, use the first one
          // from the list (English, in this case).
          return supportedLocales.first;
        },
      ),
    );
  }
}

class Navigation extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
    final auth = Provider.of<BaseAuth>(context);
    return StreamBuilder(
        stream: auth.onAuthStateChanged(),
        builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
          if (snapshot.data != null) {
            return TabsWidget(currentTab: 2);
          }
          return SignInWidget();
        }
        );
  }
}
