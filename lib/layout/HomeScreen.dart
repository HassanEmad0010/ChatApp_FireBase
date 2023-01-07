import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:new_chat_app_firebase/modules/register_screen.dart';

import '../componants/shared_componants/comp.dart';
import '../modules/Chat_Screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
  static String id= "HomeScreen";

}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<FormState> formKeyHome= GlobalKey();

  late String enteredPassword, enteredEmail;

  bool isLoading=false;
  @override
  void initState() {
    isLoading=false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,


      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formKeyHome,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(
                  flex: 2,
                ),
                const Icon(
                  Icons.messenger_outline,
                  size: 60,
                  color: Colors.green,
                ),
                const Text(
                  "My Chat",
                  style: TextStyle(fontSize: 30, color: Colors.yellow),
                  textAlign: TextAlign.center,
                ),
                const Text(
                  "Sign In",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                const SizedBox(
                  height: 8,
                ),
                textFormFeiled(hintText: "Email",
                    onChanged: (String val) {
                      enteredEmail=val;
                    }),
                const SizedBox(
                  height: 8,
                ),
                textFormFeiled(
                    onChanged: (String val) {
                      enteredPassword=val;
                    },
                    hintText: "Password",
                    isPassword: true),
                const SizedBox(
                  height: 8,
                ),
                materialButton(buttonText: "Sign-In",
                onTap: () async{
                  if( formKeyHome.currentState!.validate())
                    {
                      setState(() {
                        isLoading =true;

                      });



                      try{
                        await userCredentialSignInWithEmailAndPassword(enteredEmail: enteredEmail,enteredPass: enteredPassword);
                        //await userCredentialEmailPass(email: "hassan", pass: "1234");
                        print ("success log in");
                        showSnackBarMethod(context: context, dataSnackBar: "Success Log-In",isDone: true);
                        Navigator.pushNamed(context, ChatScreen.id);
                        isLoading=false;
                        setState(() {

                        });

                      }
                      on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {

                          print('No user found for that email.');

                        } else if (e.code == 'wrong-password') {
                          print('Wrong password provided for that user.');
                        }
                        showSnackBarMethod(context: context,
                            dataSnackBar:e.code );
                        setState(() {
                          isLoading =false;

                        });
                      }
                      catch (e) {
                        print(e);
                        showSnackBarMethod(context: context,
                            dataSnackBar:e.toString() );
                      }
                      print ("sign in pressed!") ;
                    };

                }

                ),

                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account ?",
                        style: TextStyle(color: Colors.yellow)),
                    TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return RegisterScreen();
                              },
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.login_outlined,
                          color: Colors.green,
                        ),
                        label: Text(
                          "Register now",
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                ),
                const Spacer(
                  flex: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
