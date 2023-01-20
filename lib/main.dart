import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_app_firebase/cubit/chat/chat_cubit.dart';
import 'package:new_chat_app_firebase/cubit/login/login_cubit.dart';
import 'package:new_chat_app_firebase/cubit/register/register_cubit.dart';
import 'package:new_chat_app_firebase/modules/Chat_Screen.dart';
import 'componants/Bloc_Observer.dart';
import 'cubit/CodeScreen/Code_cubit.dart';
import 'firebase_options.dart';
import 'layout/LoginScreen.dart';
import 'modules/CodeScreen.dart';

void main() async {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
      //DevicePreview(
    //  builder:(context) =>
          MyApp() );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => LoginCubit()),
        BlocProvider(create: (BuildContext context) => RegisterCubit()),
        BlocProvider(create: (BuildContext context) => ChatCubit()),
        BlocProvider(create: (BuildContext context) => CodeCubit()),

      ],
      child: MaterialApp(
      //  builder: DevicePreview.appBuilder,
        routes: {
          ChatScreen.id: (context) => ChatScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          CodeScreen.id:(context)=>CodeScreen(),
        },
        title: 'Chap Chat',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
