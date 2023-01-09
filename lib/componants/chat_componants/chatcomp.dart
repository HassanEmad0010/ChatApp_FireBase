
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../shared_componants/comp.dart';

/*TextStyle chatTextStyle= const TextStyle(color: Colors.white,
fontSize: 9,
);*/

 CollectionReference kMessages = FirebaseFirestore.instance.collection('messages');

  String messageText = "message";
  String messageTime= "messageTime";
  String messageEmail= "messageEmail";


  void addToFirebase(
{
  required String textValue,
  required String receivedEmail,
})
  {
    kMessages.add({
      messageText: textValue,
      messageTime: DateTime.now(),
      messageEmail:receivedEmail,
    });
  }


bubbleChatHisMessage(
{
  required String comingMessage,
}
    )
{
return Align(
  alignment: Alignment.bottomLeft,
  child:   Container(
    //padding to control the widget inside the container as the container
    padding: const EdgeInsets.only(
        left: 20,
        right: 30 ,
        top: 28,
        bottom: 28),
    //margin to control the container itself
    margin:const EdgeInsets.only(
     left: 5,
      top: 10,
      bottom: 10,
      right: 25,
    ),

    decoration: const BoxDecoration(
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(30),
        topRight: Radius.circular(30),
        topLeft: Radius.circular(30),

      ),
      color: kPrimaryColor,
    ),

    child:
       Text(comingMessage
        ,style: const TextStyle(color: Colors.white,
        fontSize: 16,
      ),
      ),
  ),
)  ;

}


bubbleChatMyMessage(
    {
      required String comingMessage,
    }
    )
{
  return Align(
    alignment: Alignment.bottomRight,
    child:   Container(
      //padding to control the widget inside the container as the container
      padding: const EdgeInsets.only(
          left: 20,
          right: 30 ,
          top: 28,
          bottom: 28),
      //margin to control the container itself
      margin:const EdgeInsets.only(
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

      child:
      Text(comingMessage
        ,style: const TextStyle(color: Colors.white,
          fontSize: 16,
        ),
      ),
    ),
  )  ;

}


