import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:new_chat_app_firebase/cubit/register/register_cubit.dart';
import 'package:new_chat_app_firebase/cubit/register/register_state.dart';
import 'package:new_chat_app_firebase/layout/LoginScreen.dart';

import '../componants/shared_componants/comp.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatelessWidget {
  late String nameData;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) => {
        if (state is RegisterLoadingState)
          {
            isLoading = true,
          }
        else if (state is RegisterSuccessState)
          {
            isLoading = false,
            showSnackBarMethod(
                context: context,
                dataSnackBar:
                    "Your registered email is: ${BlocProvider.of<RegisterCubit>(context).emailData}",
                isDone: true),
            Navigator.pushNamed(context, LoginScreen.id),
          }
        else if (state is RegisterFailedState)
          {
            isLoading = false,
            showSnackBarMethod(
                context: context,
                dataSnackBar:
                    BlocProvider.of<RegisterCubit>(context).registerFailedCode,
                isDone: false),
          }
      },
      builder: (context, RegisterState) => ModalProgressHUD(
        blur: 3,
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          appBar: AppBar(
            elevation: 20,
            title: const Text(
              "Log in",
              style: TextStyle(color: Colors.cyan, letterSpacing: 2),
            ),
            backgroundColor: kPrimaryColor,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const Image(
                            image: AssetImage("assets/DALLE.ChapChat.png")),
                        textFormFeiled(
                          hintText: "Email",
                          textInputType: TextInputType.emailAddress,
                          onChanged: (String data) {
                            BlocProvider.of<RegisterCubit>(context).emailData =
                                data;
                          },
                        ),
                        textFormFeiled(
                            hintText: "New Password",
                            isPassword: true,
                            onChanged: (data) {
                              BlocProvider.of<RegisterCubit>(context)
                                  .passwordData = data;
                            }),
                        materialButton(
                          buttonText: "Confirm",
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              await BlocProvider.of<RegisterCubit>(context)
                                  .userCredentialEmailPass(
                                      email: BlocProvider.of<RegisterCubit>(
                                              context)
                                          .emailData,
                                      pass: BlocProvider.of<RegisterCubit>(
                                              context)
                                          .passwordData);
                            }
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an account ?",
                                style: TextStyle(color: Colors.yellow)),
                            TextButton.icon(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.login_outlined,
                                  color: Colors.green,
                                ),
                                label: const Text(
                                  "Sign in now",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ],
                        ),
                      ],
                    ),
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
