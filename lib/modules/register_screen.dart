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

  bool isLoading= false;

  GlobalKey<FormState> formKey= GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit,RegisterState>(
      listener: (context,state)=>{
        if(state is RegisterLoadingState)
          {
            isLoading=true,

          }
        else if(state is RegisterSuccessState)
          {
            isLoading=false,
        showSnackBarMethod(context: context,
            dataSnackBar: "Your registered email is: ${BlocProvider.of<RegisterCubit>(context).emailData}",isDone: true),


        Navigator.pushNamed(context, LoginScreen.id),

    }
        else if (state is RegisterFailedState)
          {
            isLoading=false,
      showSnackBarMethod(context: context,
          dataSnackBar: BlocProvider.of<RegisterCubit>(context).registerFailedCode ,isDone: false),
          }

      },

      builder:(context,RegisterState)=> ModalProgressHUD(
       blur: 3,
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 8,
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
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    "Register",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  textFormFeiled(
                      onChanged: (String val) {
                        nameData=val;

                      },
                      hintText: "Name",
                      textInputType: TextInputType.name),
                  const SizedBox(
                    height: 8,
                  ),
                  textFormFeiled(
                      //onChanged: (String val) {},
                      hintText: "Address",
                      textInputType: TextInputType.streetAddress),
                  const SizedBox(
                    height: 8,
                  ),
                  textFormFeiled(
                      //onChanged: (String val) {},
                      hintText: "Phone Number",
                      textInputType: TextInputType.number),
                  const SizedBox(
                    height: 8,
                  ),
                  textFormFeiled(
                    hintText: "Email",
                    textInputType: TextInputType.emailAddress,
                    onChanged: (String data) {
                      BlocProvider.of<RegisterCubit>(context).emailData = data;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  textFormFeiled(
                      hintText: "New Password",
                      isPassword: true,
                      onChanged: (data) {
                        BlocProvider.of<RegisterCubit>(context).passwordData = data;
                      }),
                  const SizedBox(
                    height: 8,
                  ),
                  materialButton(
                    buttonText: "Confirm",
                    onTap: () async {

                      if (formKey.currentState!.validate() ) {

                            await BlocProvider.of<RegisterCubit>(context).userCredentialEmailPass(email: BlocProvider.of<RegisterCubit>(context).emailData, pass: BlocProvider.of<RegisterCubit>(context).passwordData);

                      }
                    },
                  ),
                  const SizedBox(
                    height: 8,
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
                  const SizedBox(
                    height: 8,
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
