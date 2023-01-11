import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../shared_componants/comp.dart';

/*TextStyle chatTextStyle= const TextStyle(color: Colors.white,
fontSize: 9,
);*/

CollectionReference kMessages =
    FirebaseFirestore.instance.collection('messages');
CollectionReference kUsersColors =
    FirebaseFirestore.instance.collection("users_colors");

String messageText = "message";
String messageTime = "messageTime";
String messageEmail = "messageEmail";

void addToFirebase({
  required String textValue,
  required String receivedEmail,
}) {
  kMessages.add({
    messageText: textValue,
    messageTime: DateTime.now(),
    messageEmail: receivedEmail,
  });
}

int _generateColorCode() {
  var rng = Random();
  for (var i = 0; i < 10; i++) {
    print("random number is  ${rng.nextInt(100)}");
  }
  return rng.nextInt(100);
}

Future<void> addUserColorFirebase({
  required String userEmail,
}) async {
  int userColorCode;
  userColorCode = _generateColorCode();
  kUsersColors.add({
    "color": userColorCode,
    "user": userEmail,
  });
}







bubbleChatHisMessage({
  required String comingMessage,
 required int colorNumber,
}) {
  return Align(
    alignment: Alignment.bottomLeft,
    child: Container(
      //padding to control the widget inside the container as the container
      padding: const EdgeInsets.only(left: 20, right: 30, top: 28, bottom: 28),
      //margin to control the container itself
      margin: const EdgeInsets.only(
        left: 5,
        top: 10,
        bottom: 10,
        right: 25,
      ),
      decoration:  BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomRight:const Radius.circular(30),
          topRight:const Radius.circular(30),
          topLeft:const Radius.circular(30),
        ),
        color:
        Color(0xA4150120+colorNumber*3),
        //Color.fromRGBO(colorNumber+100, colorNumber+10, colorNumber+20, 0.85),
      ),
      child: Text(
        comingMessage,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    ),
  );
}

bubbleChatMyMessage({
  required String comingMessage,
}) {
  return Align(
    alignment: Alignment.bottomRight,
    child: Container(
      //padding to control the widget inside the container as the container
      padding: const EdgeInsets.only(left: 20, right: 30, top: 28, bottom: 28),
      //margin to control the container itself
      margin: const EdgeInsets.only(
        left: 5,
        top: 10,
        bottom: 10,
        right: 25,
      ),

      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          // bottomRight: Radius.circular(30),
          bottomLeft: Radius.circular(30),
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
        color: Colors.green,
      ),

      child: Text(
        comingMessage,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    ),
  );
}
