


import 'package:flutter/material.dart';

import '../../cubit/login/login_cubit.dart';
import '../../modules/Chat_Screen.dart';
import 'comp.dart';

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



SizedBox buildPopUpDialog(double maxHeight, double? maxWidth, BuildContext context, LoginCubit loginCubit,Color color,String textHint) {
  return SizedBox(
    height: maxHeight/2,
    width: double.infinity,
    child:Scaffold(
        backgroundColor:Colors.transparent,
        body:

        Center(
          child: Padding(
            padding:EdgeInsets.all(maxHeight/100),
            child: Container(
              height: maxHeight/3,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.all(Radius.circular(maxHeight/15),
                ),),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    joinCreateButton(maxWidth:maxWidth!/10,maxHeight: maxHeight/10,title: "",color: color),

                    textFormFeiled(hintText: textHint),
                    MaterialButton(
                      elevation: 2,
                      hoverColor: Colors.blue,
                      focusColor: Colors.green,
                        color: Colors.transparent,
                        textColor: Colors.white,
                        onPressed: (){
                      Navigator.pushNamed(context, ChatScreen.id,
                          arguments: loginCubit.enteredEmail);
                    }, child: Text(textHint)),

                  ],
                ),
              ),
            ),
          ),
        )
    ),
  );
}
