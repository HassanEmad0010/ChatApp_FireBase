


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_app_firebase/cubit/CodeScreen/Code_cubit.dart';

import '../../cubit/login/login_cubit.dart';
import '../../modules/Chat_Screen.dart';
import 'CodeModel.dart';
import 'comp.dart';


//backend for CodeScreen



CollectionReference kCreatingCodes= FirebaseFirestore.instance.collection("Creating_Codes");






Widget codeScreenText(
{
  required String textData,
  required double maxHeight,maxWidth,
}
)
{
  return Text(
  textData ,
    style: TextStyle(
    color: Colors.white,
      fontSize: maxWidth/8,

    ),



  );

}


Widget joinCreateButton(
{
  required String title,
  required double maxWidth, maxHeight,
  required Color color,
}
    )
{
  return
    Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.elliptical(maxWidth/10, maxHeight/10)),
      ),
      width: double.infinity,
      child: Center(child: codeScreenText(textData: title, maxHeight: maxHeight,maxWidth:maxWidth )),

    );
}



