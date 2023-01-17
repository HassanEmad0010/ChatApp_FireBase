import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:new_chat_app_firebase/cubit/register/register_cubit.dart';
import 'package:new_chat_app_firebase/cubit/register/register_state.dart';
import 'package:new_chat_app_firebase/layout/LoginScreen.dart';

import '../componants/shared_componants/Media_Query.dart';
import '../componants/shared_componants/comp.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatelessWidget {
  late String nameData;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    RegisterCubit registerCubit = BlocProvider.of<RegisterCubit>(context);
    MediaQueryData mediaQueryData = MediaQuery.of(context);

    Map<String, double> sizeMap = getSizesByMediaQ(mediaQueryData);
    double? maxHeight = sizeMap["maxHeight"];
    double? maxWidth = sizeMap["maxWidth"];

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
                    "Your registered email is: ${registerCubit.emailData}",
                isDone: true),
            Navigator.pushNamed(context, LoginScreen.id),
          }
        else if (state is RegisterFailedState)
          {
            isLoading = false,
            showSnackBarMethod(
                context: context,
                dataSnackBar:
                registerCubit.registerFailedCode,
                isDone: false),
          }
      },
      builder: (context, RegisterState) => ModalProgressHUD(
        blur: 3,
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          appBar: AppBar(
            elevation: maxHeight!/20,
            title: const Text(
              "Log in",
              style: TextStyle(color: Colors.cyan, letterSpacing: 2),
            ),
            backgroundColor: kPrimaryColor,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.all(maxWidth!/20),
              child: Column(
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        getLogoDesign(maxHeight,maxWidth),

                        textFormFeiled(
                          hintText: "Email",
                          textInputType: TextInputType.emailAddress,
                          onChanged: (String data) {
                            registerCubit.emailData =
                                data;
                          },
                        ),
                        sizedBoxSpacer(height: maxHeight/70),
                        textFormFeiled(
                            hintText: "New Password",
                            isPassword: true,
                            onChanged: (data) {
                              registerCubit
                                  .passwordData = data;
                            }),
                        sizedBoxSpacer(height: maxHeight / 70),

                        materialButton(
                          buttonText: "Confirm",
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              await registerCubit
                                  .userCredentialEmailPass(
                                      email: registerCubit
                                          .emailData,
                                      pass: registerCubit
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
