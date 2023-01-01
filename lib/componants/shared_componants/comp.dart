
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kPrimaryColor = Colors.deepPurple;
const kTextFillColor = Colors.white;



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

        if (data!.isEmpty && (hintText=="Email"|| hintText=="New Password" ) )
          {
            return "Can't be empty";
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
    textColor: kPrimaryColor,
    color: Colors.white,
    child:Text(buttonText),
  );


}



Future<void> userCredentialEmailPass({required String email, required String pass}) async {
  UserCredential userCredential = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(
    email: email,
    password: pass,

  );
}

void showSnackBarMethod({required BuildContext context, required String dataSnackBar,bool isDone=false }) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: 
   isDone? Text(" Registration Done, your Email: $dataSnackBar"): Text(" Registration Failed: $dataSnackBar ")   ));
}