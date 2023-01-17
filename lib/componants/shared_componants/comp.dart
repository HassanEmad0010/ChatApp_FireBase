
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../chat_componants/userColorModel.dart';

const kPrimaryColor = Colors.indigo;
const kTextFillColor = Colors.white;
// const AssetImage logoImage = AssetImage("assets/DALLE.ChapChat.png") ;
List<UserColor> usersColorsList=[];

void fillUserColorList ({required int userColorFromFirebase, required emailColorFromFirebase})
{
  usersColorsList.add(UserColor.fromJson(
    {

      "color":userColorFromFirebase,
      "user":emailColorFromFirebase,
    }
  )
  );
  print("added to color list, the size of list is ${usersColorsList.length}");
 // print("color is ${usersColorsList[2].color} ");
}

int getUserColorByMail({required String userEmail})
{
 late int colrVar;
 print("email to search is $userEmail");
 printColorsList();
  for (int i=0 ;i<usersColorsList.length;i++)
    {
     if(userEmail== usersColorsList[i].email)
       {
         colrVar= usersColorsList[i].color;
         print("Color of email: $userEmail is: $colrVar");
       }
     else
       {
         colrVar=0;
         print("color of mail: $userEmail not found!");
       }
    }
  return colrVar;
}

void printColorsList()
{
  print("color list size is: ${usersColorsList.length}");
  for (int i=0 ;i<usersColorsList.length;i++)
    {
      print("color list of index $i is ${usersColorsList[i].color}  email is ${usersColorsList[i].email}  ");
    }

}

 Widget getLogoDesign (double height, double width)
{
  return  SizedBox(
    height: height / 3,
    width: width / 2,
    child: const Image(
        image: AssetImage("assets/DALLE.ChapChat.png")),
  );
}


textFormFeiled(
{
 required String hintText,
  bool isPassword =false,
  TextInputType textInputType=TextInputType.text,
   Function(String)? onChanged,

}
    )
{
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: TextFormField(
      validator:(data){

        if (data!.isEmpty && (hintText=="Email"|| hintText=="New Password"||hintText=="Password" ) )
      //    if (data!.isEmpty)
          {
            return "Sorry but $hintText Can't be empty";
          }
      } ,


      onChanged: onChanged,

      obscureText:isPassword ,
      keyboardType: isPassword? TextInputType.visiblePassword :textInputType,
      style: const TextStyle(color: kTextFillColor),
      decoration:  InputDecoration(
        fillColor: Colors.white,
        hintText: hintText ,
        hintStyle:const TextStyle(color: Colors.white) ,
        enabledBorder:const OutlineInputBorder(
          gapPadding: 10,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.greenAccent),
        ),
        focusedBorder:const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.greenAccent),
          gapPadding: 10,
        ),
        border:const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          gapPadding: 10,
        ),

      ),





    ),
  );






}

materialButton(
{
  required String buttonText ,
  VoidCallback? onTap,
}

    )
{
  return MaterialButton(onPressed: onTap,
    textColor: Colors.white,
    color: Colors.lightBlue,
    child:Text(buttonText),
  );


}








void showSnackBarMethod({required BuildContext context, required String dataSnackBar,bool isDone=false }) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: 
   isDone? Text("Done! $dataSnackBar"): Text(" Registration Failed: $dataSnackBar ")   ));
}