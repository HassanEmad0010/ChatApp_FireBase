
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../shared_componants/comp.dart';

/*TextStyle chatTextStyle= const TextStyle(color: Colors.white,
fontSize: 9,
);*/

 CollectionReference kMessages = FirebaseFirestore.instance.collection('messages');



bubbleChatHisMessage()
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
      const Text("Hi Hello world! Hello World hth t hth er fger er ggrg"
        ,style: TextStyle(color: Colors.white,
        fontSize: 9,
      ),
      ),
  ),
)  ;

}



bubbleChatMyMessage()
{
  return Container(

    padding: const EdgeInsets.only(left: 20),
    margin:const EdgeInsets.all(17),

    decoration: const BoxDecoration(
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(30),
        topRight: Radius.circular(30),
        topLeft: Radius.circular(30),

      ),
      color: Colors.blue,
    ),
    alignment: Alignment.centerLeft,
    height: 70,
    width: 210,

    child:
    const Text("Hello mesh World",style: TextStyle(color: Colors.white,
      fontSize: 9,
    ),
    ),
  )  ;

}


