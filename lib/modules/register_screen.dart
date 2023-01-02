import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../componants/shared_componants/comp.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late String emailData;

  late String passwordData;

  late String nameData;

  bool isLoading= false;

  GlobalKey<FormState> formKey= GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
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
                    emailData = data;
                    print("email is: " + emailData);
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                textFormFeiled(
                    hintText: "New Password",
                    isPassword: true,
                    onChanged: (data) {
                      passwordData = data;
                    }),
                const SizedBox(
                  height: 8,
                ),
                materialButton(
                  buttonText: "Confirm",
                  onTap: () async {

                    if (formKey.currentState!.validate()) {
                      isLoading=true;
                      setState(() {

                      });
                      try {
                      //  Firebase.initializeApp();
                        await userCredentialEmailPass(email: emailData,pass: passwordData);
                        showSnackBarMethod(context: context, dataSnackBar: "Your registered email is: $emailData",isDone: true);
                        isLoading=false;
                        Navigator.pop(context);

                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                        } else if (e.code == 'email-already-in-use') {
                        }
                        showSnackBarMethod(context: context, dataSnackBar: e.code.toString());
                      } catch (e) {
                        print(e);
                      }
                      setState(() {
                        isLoading=false;
                      });
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
    );
  }
}
