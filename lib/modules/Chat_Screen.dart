//// hasanemad1@gmail.com

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_chat_app_firebase/componants/chat_componants/message.dart';
import 'package:new_chat_app_firebase/componants/shared_componants/comp.dart';
import 'package:new_chat_app_firebase/layout/HomeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import '../componants/chat_componants/chatcomp.dart';

class ChatScreen extends StatefulWidget
{
  static String id ="ChatId";

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController controller = new TextEditingController();

  List<Message> messagesList = [];



  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon:const Icon( Icons.logout),
            onPressed: () {
              Navigator.pushNamed(context, HomeScreen.id);
            },
          ),
          title:const Text("My Chat App!"),
        centerTitle: true,
        ),

        body: (
            FutureBuilder<QuerySnapshot>(

              future: kMessages.get(),
              builder:(BuildContext context,snapshot) {
      if ( snapshot.hasData ) {
      int snapShotSize=  snapshot.data!.size;
            print("snapshot size is: $snapShotSize");

            for (int i=0 ; i< snapshot.data!.docs.length;i++)
              {
                print ("snapshot data is ${snapshot.data!.docs[i].id}");
                messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
              }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: snapShotSize,
                      itemBuilder: (context, index) {
                        print("index  is: $index");
                        print("list size is  : ${messagesList.length}");
                        print("list is  : ${messagesList[index].messageVar}");

                    return bubbleChatHisMessage(comingMessage:messagesList[index].messageVar );
                  }

                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(16),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (val) {

                      kMessages.add({"message": val});

                      setState(() {

                      });
                      controller.clear();
                    },

                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () {

                            controller.clear();
                            setState(() {

                            });
                            controller.clear();
                          },),
                      enabledBorder: OutlineInputBorder(
                        //gapPadding: 10,
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Colors.blueAccent),

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


    }
    else
      {
        return const Center(child: CircularProgressIndicator());
      }
      return const Center(child: CircularProgressIndicator());
              }


            )

        ),


      ),


    );


  }
}
