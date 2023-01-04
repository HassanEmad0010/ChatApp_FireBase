
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_chat_app_firebase/componants/shared_componants/comp.dart';
import 'package:new_chat_app_firebase/layout/HomeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../componants/chat_componants/chatcomp.dart';

class ChatSceen extends StatelessWidget
{
  static String id ="ChatId";
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController controller = new TextEditingController();
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

            Column (
            children: [
                Expanded(
                  child: ListView.builder(itemBuilder: (context,index)
            {
              return bubbleChatHisMessage() ;
            }
            ),
                ),

               Padding(
                padding: EdgeInsets.all(16),
                child: TextField(
                  controller: controller,
                  onSubmitted: (val){

                    kMessages.add({"message":val});
                    controller.clear();
                  },
//hasanemad1@gmail.com

                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.send),
                    enabledBorder:OutlineInputBorder(
                      //gapPadding: 10,
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.blueAccent),

                    ),
                    border:OutlineInputBorder(
                      //gapPadding: 10,
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: kPrimaryColor),

                    ),


                  ),

                ),
              ),
            ],
      )

        ),


      ),


    );


  }






}
