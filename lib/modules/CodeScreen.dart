import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_app_firebase/componants/shared_componants/comp.dart';
import 'package:new_chat_app_firebase/layout/LoginScreen.dart';
import 'package:new_chat_app_firebase/modules/Chat_Screen.dart';

import '../componants/shared_componants/CodeScreenCompnants.dart';
import '../componants/shared_componants/Media_Query.dart';
import '../cubit/login/login_cubit.dart';

class CodeScreen extends StatelessWidget
{
 static String id="CodeScreenID";
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    Map<String, double> sizeMap = getSizesByMediaQ(mediaQueryData);
    double? maxHeight = sizeMap["maxHeight"];
    double? maxWidth = sizeMap["maxWidth"];
    var scafoldKey=GlobalKey<ScaffoldState>();


    LoginCubit loginCubit=BlocProvider.of<LoginCubit>(context);
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
        padding:  EdgeInsets.all(maxHeight!/15),
        child: Column (
         // mainAxisSize: MainAxisSize.max,
          children: [


            Expanded(
              child: GestureDetector(

                onTap: (){
                  print("join pressed!");

                  showDialog(context: context, builder:
                  (context)=>   Center(
                    child: buildPopUpDialog(maxHeight, maxWidth, context, loginCubit,Colors.cyan,"Enter the code"),
                  ),
                  );

                },
                child: joinCreateButton(maxWidth:maxWidth!,maxHeight: maxHeight,title: "Join",color: Colors.cyan),
              ),
            ),
            sizedBoxSpacer(
              height: maxHeight/20,
              width: double.infinity,
            ),
            Expanded(
              child: GestureDetector(
                onTap: (){
                  print("create pressed!");
                  showDialog(context: context, builder:
                      (context)=>   Center(
                    child: buildPopUpDialog(maxHeight, maxWidth, context, loginCubit,Colors.lightBlueAccent,"Press the code"),
                  ),
                  );

                },

                child: joinCreateButton(maxWidth:maxWidth,maxHeight: maxHeight,title: "Create!",color: Colors.lightBlueAccent),

              ),
            ),


        ],),
      ),

    );


  }


}