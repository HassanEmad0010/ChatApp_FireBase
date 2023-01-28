//// hasanemad1@gmail.com
//h@g.com
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_app_firebase/componants/chat_componants/message.dart';
import 'package:new_chat_app_firebase/componants/chat_componants/userColorModel.dart';
import 'package:new_chat_app_firebase/componants/shared_componants/comp.dart';
import 'package:new_chat_app_firebase/cubit/chat/chat_cubit.dart';
import 'package:new_chat_app_firebase/cubit/chat/chat_state.dart';
import 'package:new_chat_app_firebase/layout/LoginScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

import '../componants/chat_componants/chatcomp.dart';
import '../models/Arguments.dart';

class ChatScreen extends StatelessWidget {
  static String id = "ChatId";

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController controller = TextEditingController();



  String onChangedTextMessage = "";
  ScrollController Listcontroller = ScrollController();

  @override
  Widget build(BuildContext context) {
    ChatCubit chatCubit= BlocProvider.of<ChatCubit>(context);
     Arguments? arguments  = ModalRoute.of(context)!.settings.arguments as Arguments?;
    String receivedEmail= arguments!.enteredMail;
    String receivedCode=arguments.enteredCode;
 //   String receivedCode=ModalRoute.of(context)!.settings.arguments as String;
     print("enered mail is $receivedEmail \n"
         "entered code is $receivedCode");
    late int colorCodeFromList;
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) => {
        if (state is ChatSuccessAddMessageState) {} else if (state is ChatFailedAddMessageState) {}
        else {},
      },
      builder: (context, state) => MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(" ${receivedEmail.split("@").first.toUpperCase()} 👋"),
            backgroundColor: kPrimaryColor,
            leading: IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
                // to pop all screens in the stack
                Navigator.popUntil(context, ModalRoute.withName('/'));

                //Navigator.pop(context);
              },
            ),
            centerTitle: true,
          ),
          body: StreamBuilder<QuerySnapshot>(
              stream:
                  chatCubit.createCodeDocAndGetMesseagesCollection(receivedCode).orderBy(messageTime, descending: true).snapshots(),
              builder: (BuildContext context, snapshot) {
                chatCubit.messagesList.clear();
                if (snapshot.hasData) {
                  int snapShotSize = snapshot.data!.size;
                  //  print("snapshot size is: $snapShotSize");
                  chatCubit.addMessageToList(snapshot, chatCubit);

                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            reverse: true,
                            controller: Listcontroller,
                            itemCount: snapShotSize,
                            itemBuilder: (context, index) {
                             if (receivedEmail ==
                                 chatCubit.messagesList[index].messageEmailVar &&
                                 receivedCode ==
                                     chatCubit.messagesList[index].messageCode) {
                               return bubbleChatMyMessage(
                                   comingMessage:
                                   chatCubit.messagesList[index].messageVar);
                             } else if (receivedEmail !=
                                 chatCubit.messagesList[index].messageEmailVar &&
                                 receivedCode ==
                                     chatCubit.messagesList[index].messageCode) {
                               colorCodeFromList = getUserColorByMail(
                                   userEmail:
                                   chatCubit.messagesList[index].messageEmailVar);
                               print(
                                   "index of colors is $index, mail from message list is"
                                       " ${chatCubit.messagesList[index]
                                       .messageEmailVar} color is $colorCodeFromList");

                               return bubbleChatHisMessage(
                                 hisMail:chatCubit.messagesList[index].messageEmailVar ,
                                 colorNumber: colorCodeFromList,
                                 comingMessage: chatCubit.messagesList[index].messageVar,
                               );
                             }
                             else
                             {
                               return  const Text("No data");
                             }


                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: TextField(
                          textInputAction: TextInputAction.newline,
                          onChanged: (changedVal) {
                            onChangedTextMessage = changedVal;
                          },
                          controller: controller,

                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.send),
                              onPressed: () {
                                if (onChangedTextMessage.isNotEmpty) {
                                  chatCubit.addToFirebase(
                                      textValue: onChangedTextMessage,
                                      receivedEmail: receivedEmail,
                                  receivedCode: receivedCode, codeNumber: receivedCode,
                                  );
                                  Listcontroller.animateTo(0,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.ease);
                                  controller.clear();
                                }
                                onChangedTextMessage = "";
                              },
                            ),
                            enabledBorder: OutlineInputBorder(
                              //gapPadding: 10,
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  const BorderSide(color: Colors.blueAccent),
                            ),
                            border: OutlineInputBorder(
                              //gapPadding: 10,
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  const BorderSide(color: kPrimaryColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container(child: const Center(child: CircularProgressIndicator()));
                }
                return const Center(child: CircularProgressIndicator());
              }),
        ),
      ),
    );
  }


}
