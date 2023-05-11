import 'package:contactsbar/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';


void main() async{
  ;
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  void request ()async {
    await [ Permission.camera, Permission.phone, Permission.sms ].request();
    print("working");
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage()
    );
  }
}
