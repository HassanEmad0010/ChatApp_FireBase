import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:new_chat_app_firebase/componants/chat_componants/userColorModel.dart';
import 'package:new_chat_app_firebase/componants/shared_componants/Media_Query.dart';
import 'package:new_chat_app_firebase/cubit/login/login_cubit.dart';
import 'package:new_chat_app_firebase/cubit/login/login_state.dart';
import 'package:new_chat_app_firebase/modules/CodeScreen.dart';
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
    MediaQueryData mediaQueryData = MediaQuery.of(context);

    Map<String, double> sizeMap = getSizesByMediaQ(mediaQueryData);
    double? maxHeight = sizeMap["maxHeight"];
    double? maxWidth = sizeMap["maxWidth"];

    print("max h: $maxHeight and max w: $maxWidth ");

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) => {
        if (state is LoginLoadingState)
          {
            isLoading = true,
          }
        else if (state is LoginSuccessState)
          {
            print("success log in"),
            Navigator.pushNamed(context, CodeScreen.id,
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
              titleSpacing: maxWidth! / 20,
              elevation: maxHeight! / 20,
              centerTitle: true,
              backgroundColor: kPrimaryColor,
            ),
            backgroundColor: kPrimaryColor,
            // backgroundColor: Colors.indigoAccent,
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(maxWidth / 20),
                child: Column(
                  children: [
                    Form(
                      key: formKeyHome,
                      child: Column(
                        //  mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          sizedBoxSpacer(height: maxHeight / 20),
                          getLogoDesign(maxHeight,maxWidth),

                          //sizedBoxSpacer(height: 200),
                          textFormFeiled(
                              hintText: "Email",
                              onChanged: (String val) {
                                loginCubit.enteredEmail = val;
                              }),
                          sizedBoxSpacer(height: maxHeight / 70),
                          textFormFeiled(
                              onChanged: (String val) {
                                loginCubit.enteredPassword = val;
                              },
                              hintText: "Password",
                              isPassword: true),
                          sizedBoxSpacer(height: maxHeight / 70),
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

                       //   sizedBoxSpacer(height: maxHeight / 70),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              const Text(
                                "Don't have an account ?",
                                maxLines: 1,
                                style: TextStyle(color: Colors.yellowAccent),
                                overflow: TextOverflow.ellipsis,
                              ),
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
                                    //overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Colors.white,
                                        overflow: TextOverflow.ellipsis),
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
