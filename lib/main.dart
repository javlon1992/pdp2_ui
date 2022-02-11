import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pdp2_ui/pages/note_page.dart';
import 'package:pdp2_ui/pages/home_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pdp2_ui/pages/shared_preference.dart';
import 'package:pdp2_ui/services/hive_database.dart';

void main() async{
  /// #Til tanlah uchun
 WidgetsFlutterBinding.ensureInitialized();
 await EasyLocalization.ensureInitialized();

 /// #Data base uchun
 await Hive.initFlutter();
 await Hive.openBox(HiveDataBase.dbName);

 runApp(
   EasyLocalization(
       supportedLocales: [Locale('en', 'US'), Locale('ru', 'RU'),Locale('uz', 'UZ'),Locale('ko', 'KO'),Locale('ja', 'JA'),Locale('fr', 'FR')],
       path: 'assets/translations', // <-- change the path of the translation files
       //fallbackLocale: Locale('en', 'US'),
       startLocale: Locale('en','US'),
       child: MyApp(),
   ),
 );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: NotePage(),

      routes: {
        HomePage.id: (context)=> HomePage(),
        SharedPreferencePage.id: (context)=> SharedPreferencePage(),
        NotePage.id: (context)=> NotePage(),
      },
    );
  }
}

