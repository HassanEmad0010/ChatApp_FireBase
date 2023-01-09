import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:new_chat_app_firebase/cubit/login_cubit.dart';
import 'package:new_chat_app_firebase/cubit/login_state.dart';
import 'package:new_chat_app_firebase/modules/register_screen.dart';

import '../componants/shared_componants/comp.dart';
import '../modules/Chat_Screen.dart';

class LoginScreen extends StatelessWidget {
  GlobalKey<FormState> formKeyHome = GlobalKey();
  static String id = "HomeScreen";

    String enteredPassword="00", enteredEmail="00";

  bool isLoading = false;
  @override
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit,LoginState>(
     listener: (context, state) =>{
       if (state is LoginLoadingState)
         {
           isLoading=true,
         }
       else if(state is LoginSuccessState)
         {

        print("success log in"),
    showSnackBarMethod(
        context: context,
        dataSnackBar: BlocProvider.of<LoginCubit>(context).logoinFailedCode,
        isDone: true),
    Navigator.pushNamed(context, ChatScreen.id,
        arguments: enteredEmail),
    isLoading = false,
         }
       else if(state is LoginFailedState )
         {
         showSnackBarMethod(
         context: context, dataSnackBar:  BlocProvider.of<LoginCubit>(context).logoinFailedCode ),
         isLoading = false,
         }

     } ,
      builder:(context,LoginState)=> ModalProgressHUD(
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
                  textFormFeiled(
                      hintText: "Email",
                      onChanged: (String val) {
                        enteredEmail = val;
                      }),
                  const SizedBox(
                    height: 8,
                  ),
                  textFormFeiled(
                      onChanged: (String val) {
                        enteredPassword = val;
                      },
                      hintText: "Password",
                      isPassword: true),
                  const SizedBox(
                    height: 8,
                  ),
                  materialButton(
                      buttonText: "Sign-In",
                      onTap: () async {

                        if (formKeyHome.currentState!.validate()) {
                          if(enteredEmail.isNotEmpty&&enteredPassword.isNotEmpty) {
                            await BlocProvider.of<LoginCubit>(context).
                            userCredentialSignInWithEmailAndPassword(
                                enteredEmail: enteredEmail,
                                enteredPass: enteredPassword);

                            print("sign in pressed!");
                          }
                            //isLoading = true;
                        };
                      }),
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
      ),
    );
  }
}
