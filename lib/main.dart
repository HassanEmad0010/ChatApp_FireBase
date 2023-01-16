import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_app_firebase/cubit/chat/chat_cubit.dart';
import 'package:new_chat_app_firebase/cubit/login/login_cubit.dart';
import 'package:new_chat_app_firebase/cubit/register/register_cubit.dart';
import 'package:new_chat_app_firebase/modules/Chat_Screen.dart';
import 'componants/Bloc_Observer.dart';
import 'firebase_options.dart';
import 'layout/LoginScreen.dart';

void main() async {
  Bloc.observer = SimpleBlocObserver();
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => LoginCubit()),
        BlocProvider(create: (BuildContext context) => RegisterCubit()),
        BlocProvider(create: (BuildContext context) => ChatCubit()),
      ],
      child: MaterialApp(
        routes: {
          ChatScreen.id: (context) => ChatScreen(),
          LoginScreen.id: (context) => LoginScreen(),
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
