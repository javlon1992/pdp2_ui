import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static String id="home_page";
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text("flutter").tr(),
            ),),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MaterialButton(onPressed: (){
                //context.locale = Locale('en','US');
                context.setLocale(Locale('en','US'));
              },textColor: Colors.white, child: Text("English",), color: Colors.green,),
              MaterialButton(onPressed: (){
                context.locale = Locale('ko','KO');
              },textColor: Colors.white, child: Text("Korean"), color: Colors.red,),
              MaterialButton(onPressed: (){
                context.locale = Locale('ja','JA');
              },textColor: Colors.white, child: Text("Japanese"), color: Colors.blue,),
            ],
          ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }
}
