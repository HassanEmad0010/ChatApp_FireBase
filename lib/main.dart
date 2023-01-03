import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:new_chat_app_firebase/modules/Chat_Screen.dart';
import 'firebase_options.dart';
import 'layout/HomeScreen.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes:
          {
           ChatSceen.id:(context)=>ChatSceen(),
            HomeScreen.id:(context)=> HomeScreen(),

          },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
