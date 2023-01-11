import 'package:firebase_auth/firebase_auth.dart';

class UserColor {
  final int color;
  final String email;

  UserColor( this.color,  this.email);


  factory UserColor.fromJson(dynamic jsonData)
  {
    return UserColor(jsonData["color"], jsonData["user"]);
  }


}