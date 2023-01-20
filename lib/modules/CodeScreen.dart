import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_app_firebase/componants/shared_componants/comp.dart';
import 'package:new_chat_app_firebase/layout/LoginScreen.dart';
import 'package:new_chat_app_firebase/modules/Chat_Screen.dart';

import '../componants/shared_componants/CodeModel.dart';
import '../componants/shared_componants/CodeScreenCompnants.dart';
import '../componants/shared_componants/Media_Query.dart';
import '../cubit/CodeScreen/Code_cubit.dart';
import '../cubit/login/login_cubit.dart';

class CodeScreen extends StatelessWidget {
  static String id = "CodeScreenID";
  TextEditingController textEditingController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    CodeCubit codeCubit = BlocProvider.of<CodeCubit>(context);
    print("list size is ${codeCubit.codesList.length}");

    // Stream<QuerySnapshot<Object>>  snapshots=  readCodeFireStore();

    MediaQueryData mediaQueryData = MediaQuery.of(context);
    Map<String, double> sizeMap = getSizesByMediaQ(mediaQueryData);
    double? maxHeight = sizeMap["maxHeight"];
    double? maxWidth = sizeMap["maxWidth"];
    var scafoldKey = GlobalKey<ScaffoldState>();

    LoginCubit loginCubit = BlocProvider.of<LoginCubit>(context);
    return Scaffold(
      key: scafoldKey,
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        //elevation: maxHeight!/30,
        title: const Text(
          "Log in",
          style: TextStyle(color: Colors.cyan, letterSpacing: 2),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(maxHeight! / 15),
        child: StreamBuilder<QuerySnapshot>(
            stream: kCreatingCodes.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData)  {
                print(
                    "data size from CODES snapshot builder is ${snapshot.data!.size}\n"
                        "size of local Code list is ${codeCubit.codesList.length}");
                codeCubit.fillCodeListFromFireStore(snapshot);
              } else {
                print("nO daaaaaata from snapshot builder ");
              }
              return Column(
                // mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        print("join pressed!");

                        showDialog(
                          context: context,
                          builder: (context) => Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: maxHeight / 1.3,
                                  width: double.infinity,
                                  child: Scaffold(
                                      backgroundColor: Colors.transparent,
                                      body:
                                      SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Center(
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.all(maxHeight / 100),
                                                child: Container(
                                                  height: maxHeight / 3,
                                                  decoration: BoxDecoration(
                                                    color: Colors.cyan,
                                                    borderRadius: BorderRadius.all(
                                                      Radius.circular(maxHeight / 15),
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                      children: [
                                                        joinCreateButton(
                                                          maxWidth: maxWidth! / 10,
                                                          maxHeight: maxHeight / 10,
                                                          title: "",
                                                          color: Colors.cyan,
                                                        ),
                                                        textFormFeiled(
                                                          controller: textEditingController,
                                                            hintText:
                                                                "Enter the code",
                                                            onChanged: (value) {
                                                              codeCubit.codeEntered =
                                                                  value;
                                                            }),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),

                                            ),
                                            MaterialButton(
                                                elevation: 2,
                                                hoverColor: Colors.blue,
                                                focusColor: Colors.green,
                                                color: Colors.transparent,
                                                textColor: Colors.white,
                                                onPressed: () {
                                                  print("material button of join");
                                                  bool isCodeExist=  codeCubit.codesList.contains(CodeModel(codeId: codeCubit.codeEntered));
                                                  print("bool contaaaaains is $isCodeExist");
                                                  if (isCodeExist)
                                                  {
                                                    Navigator.pushNamed(context, ChatScreen.id,
                                                        arguments: loginCubit.enteredEmail);
                                                    textEditingController.clear();
                                                  }
                                                  else
                                                  {
                                                    print("this code ${codeCubit.codeEntered} isnt exist");
                                                    textEditingController.clear();
                                                  }


                                                },
                                                child: const Text("Enter Your Code")),
                                          ],
                                        ),
                                      )),

                                ),

                              ],
                            ),
                          ),
                        );
                      },
                      child: joinCreateButton(
                          maxWidth: maxWidth!,
                          maxHeight: maxHeight,
                          title: "Join",
                          color: Colors.cyan),
                    ),
                  ),

                  sizedBoxSpacer(
                    height: maxHeight / 20,
                    width: double.infinity,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        print("create pressed!");
                        showDialog(
                            context: context,
                            builder: (context) => Center(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: maxHeight / 1.1,
                                        width: double.infinity,
                                        child: Scaffold(
                                            backgroundColor: Colors.transparent,
                                            body: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Center(
                                                    child: Padding(
                                                      padding: EdgeInsets.all(
                                                          maxHeight / 100),
                                                      child: Container(
                                                        height: maxHeight / 3,
                                                        decoration: BoxDecoration(
                                                          color: Colors.blue,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(
                                                                maxHeight / 15),
                                                          ),
                                                        ),
                                                        child: Center(
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize.max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              joinCreateButton(
                                                                maxWidth:
                                                                    maxWidth / 10,
                                                                maxHeight:
                                                                    maxHeight / 10,
                                                                title: "",
                                                                color: Colors.cyan,
                                                              ),
                                                              textFormFeiled(
                                                                  hintText:
                                                                      "Create a new code",
                                                                  onChanged: (value) {
                                                                    codeCubit
                                                                            .codeEntered =
                                                                        value;
                                                                  }),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  MaterialButton(
                                                      elevation: 2,
                                                      hoverColor: Colors.blue,
                                                      focusColor: Colors.green,
                                                      color: Colors.transparent,
                                                      textColor: Colors.white,
                                                      onPressed: () {
                                                        print("material button of create pressed ");
                                                        bool isCodeAlreadyExist=  codeCubit.codesList.contains(CodeModel(codeId: codeCubit.codeEntered));
                                                        if(isCodeAlreadyExist)
                                                        {
                                                          print("code already exist!");
                                                          textEditingController.clear();
                                                        }
                                                        else {
                                                          codeCubit.addCodeFireStore(
                                                              codeCubit.codeEntered);
                                                          print("code ${codeCubit.codeEntered} inserted");
                                                          textEditingController.clear();
                                                        }
                                                      },
                                                      child: const Text("Create a new Code")),
                                                ],
                                              ),
                                            )),
                                      ),

                                    ],
                                  ),
                                ));
                      },
                      child: joinCreateButton(
                          maxWidth: maxWidth,
                          maxHeight: maxHeight,
                          title: "Create",
                          color: Colors.blue),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
