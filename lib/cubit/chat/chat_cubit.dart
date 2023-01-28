import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_app_firebase/cubit/chat/chat_state.dart';

import '../../componants/chat_componants/chatcomp.dart';
import '../../componants/chat_componants/message.dart';
import '../../componants/shared_componants/comp.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitialState());
  List<Message> messagesList = [];

  void addMessageToList(AsyncSnapshot<QuerySnapshot<Object?>> snapshot, ChatCubit chatCubit) {
    for (int i = 0; i < snapshot.data!.docs.length; i++) {
      // print("snapshot data id is ${snapshot.data!.docs[i].id}");
      chatCubit.messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
      //usersColorsList.add(UserColor.fromJson(snapshot.data!.docs[i]));
    }
  }



  void addToFirebase({
    required String textValue,
    required String receivedEmail,
    required String receivedCode,
    required String codeNumber,
  }) async {

   try {
     CollectionReference<Object?> kMessages = createCodeDocAndGetMesseagesCollection(codeNumber);

     await kMessages.add({
        messageText: textValue,
        messageTime: DateTime.now(),
        messageEmail: receivedEmail,
        messageCode:receivedCode,
      });
     emit(ChatSuccessAddMessageState());
   } on Exception catch (e) {
     emit(ChatFailedAddMessageState());

   }


  }

  CollectionReference<Object?> createCodeDocAndGetMesseagesCollection(String codeNumber) {
      CollectionReference kMessages =
    FirebaseFirestore.instance.collection("USERDATA").doc(codeNumber).collection('USER_MESSAGES');
    return kMessages;
  }


}
