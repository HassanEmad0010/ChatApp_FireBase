
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kPrimaryColor = Colors.deepPurple;
const kTextFillColor = Colors.white;



textFormFeiled(
{
 required String hintText,
  bool isPassword =false,
  TextInputType textInputType=TextInputType.text,
  required Function(String) onChanged,

}
    )
{
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: TextFormField(
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