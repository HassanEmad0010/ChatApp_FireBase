import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:new_chat_app_firebase/componants/chat_componants/userColorModel.dart';
import 'package:new_chat_app_firebase/cubit/login/login_cubit.dart';
import 'package:new_chat_app_firebase/cubit/login/login_state.dart';
import 'package:new_chat_app_firebase/modules/register_screen.dart';

import '../componants/chat_componants/chatcomp.dart';
import '../componants/shared_componants/comp.dart';
import '../modules/Chat_Screen.dart';

class LoginScreen extends StatelessWidget {
  GlobalKey<FormState> formKeyHome = GlobalKey();
  static String id = "HomeScreen";

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    LoginCubit loginCubit = BlocProvider.of<LoginCubit>(context);

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) => {
        if (state is LoginLoadingState)
          {
            isLoading = true,
          }
        else if (state is LoginSuccessState)
          {
            print("success log in"),
            Navigator.pushNamed(context, ChatScreen.id,
                arguments: loginCubit.enteredEmail),
            isLoading = false,
          }
        else if (state is LoginFailedState)
          {
            showSnackBarMethod(
                context: context, dataSnackBar: loginCubit.logoinFailedCode),
            isLoading = false,
          }
      },
      builder: (context, loginState) => StreamBuilder<QuerySnapshot>(
        stream: kUsersColors.snapshots(),
        builder: (BuildContext context, snapshot) => ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                "Chap Chat!",
                style: TextStyle(color: Colors.cyan, letterSpacing: 2),
              ),
              titleSpacing: 120,
              elevation: 15,
              centerTitle: true,
              backgroundColor: kPrimaryColor,
            ),
            backgroundColor: kPrimaryColor,
            // backgroundColor: Colors.indigoAccent,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Form(
                      key: formKeyHome,
                      child: Column(
                        //  mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Image(
                              image: AssetImage("assets/DALLE.ChapChat.png")),
                          textFormFeiled(
                              hintText: "Email",
                              onChanged: (String val) {
                                loginCubit.enteredEmail = val;
                              }),
                          const SizedBox(
                            height: 7,
                          ),
                          textFormFeiled(
                              onChanged: (String val) {
                                loginCubit.enteredPassword = val;
                              },
                              hintText: "Password",
                              isPassword: true),
                          const SizedBox(
                            height: 8,
                          ),
                          materialButton(
                              buttonText: "Sign-In",
                              onTap: () async {
                                if (formKeyHome.currentState!.validate()) {
                                  if (loginCubit.enteredEmail.isNotEmpty &&
                                      loginCubit.enteredPassword.isNotEmpty) {
                                    await loginCubit
                                        .userCredentialSignInWithEmailAndPassword(
                                            enteredEmail:
                                                loginCubit.enteredEmail,
                                            enteredPass:
                                                loginCubit.enteredPassword);
                                    if (snapshot.hasData) {
                                      for (int i = 0;
                                          i < snapshot.data!.size;
                                          i++) {
                                        usersColorsList.clear();

                                        fillUserColorList(
                                            userColorFromFirebase:
                                                snapshot.data!.docs[i]["color"],
                                            emailColorFromFirebase:
                                                snapshot.data!.docs[i]["user"]);
                                        //  usersColorsList.add(UserColor.fromJson(snapshot.data!.docs[i]) ) ;
                                      }
                                    } else {
                                      print("no color data");
                                    }

                                    print("sign in pressed!");
                                  }
                                }
                                ;
                              }),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account ?",
                                  style: TextStyle(color: Colors.yellowAccent)),
                              TextButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return RegisterScreen();
                                        },
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.login_outlined,
                                    color: Colors.green,
                                  ),
                                  label: const Text(
                                    "Register now",
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ],
                          ),
                          /*const Spacer(
                            flex: 2,
                          ),*/
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
