//// hasanemad1@gmail.com
//h@g.com
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_app_firebase/componants/chat_componants/message.dart';
import 'package:new_chat_app_firebase/componants/shared_componants/comp.dart';
import 'package:new_chat_app_firebase/cubit/chat/chat_cubit.dart';
import 'package:new_chat_app_firebase/cubit/chat/chat_state.dart';
import 'package:new_chat_app_firebase/layout/LoginScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../componants/chat_componants/chatcomp.dart';

class ChatScreen extends StatelessWidget {
  static String id = "ChatId";

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController controller = new TextEditingController();

  List<Message> messagesList = [];
    String onChangedTextMessage="";
  ScrollController Listcontroller = new ScrollController();

  @override
  Widget build(BuildContext context) {
    String receivedEmail = ModalRoute.of(context)!.settings.arguments as String;
    return BlocConsumer<ChatCubit,ChatState>(
     listener: (context,state) =>
     {
       if(state is ChatSuccessState)
         {}
       else if(state is ChatInitialState)
         {

         }
       
           
             
             
           
     } ,
      builder: ( context,state )=> MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
                // to pop all screens in the stack
                Navigator.popUntil(context, ModalRoute.withName('/'));


                //Navigator.pop(context);
              },
            ),
            title: const Text("My Chat App!"),
            centerTitle: true,
          ),
          body: (StreamBuilder<QuerySnapshot>(
              stream:
                  kMessages.orderBy(messageTime, descending: true).snapshots(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  messagesList.clear();

                  int snapShotSize = snapshot.data!.size;
                  print("snapshot size is: $snapShotSize");

                  for (int i = 0; i < snapshot.data!.docs.length; i++) {
                    print("snapshot data is ${snapshot.data!.docs[i].id}");
                    messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
                  }

                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            reverse: true,
                            controller: Listcontroller,
                            itemCount: snapShotSize,
                            itemBuilder: (context, index) {
                              print("index  is: $index");
                              print("list size is  : ${messagesList.length}");
                              print("list is  : ${messagesList[index].messageVar}");

                              if (receivedEmail ==
                                  messagesList[index].messageEmailVar) {
                                return bubbleChatMyMessage(
                                    comingMessage:
                                        messagesList[index].messageVar);
                              } else {
                                return bubbleChatHisMessage(
                                    comingMessage:
                                        messagesList[index].messageVar);
                              }
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: TextField(
                          textInputAction: TextInputAction.newline,
                          onChanged: (changedVal){
                            onChangedTextMessage = changedVal;
                          },
                          controller: controller,
                          /*onSubmitted: (val) {
                            addToFirebase(textValue: val, receivedEmail: receivedEmail);
                            controller.clear();
                            Listcontroller.animateTo(0,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.ease);
                          },*/
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.send),
                              onPressed: () {
                                if (onChangedTextMessage.isNotEmpty)
                                {
                                  addToFirebase(
                                      textValue: onChangedTextMessage,
                                      receivedEmail: receivedEmail);
                                  Listcontroller.animateTo(0,
                                      duration: const Duration(milliseconds: 500),
                                      curve: Curves.ease);
                                  controller.clear();

                                }
                                onChangedTextMessage="";
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
                              borderSide: const BorderSide(color: kPrimaryColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
                return const Center(child: CircularProgressIndicator());
              })),
        ),
      ),
    );
  }
}
