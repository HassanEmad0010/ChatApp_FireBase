import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../componants/shared_componants/comp.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatelessWidget {
  late String emailData;
  late String passwordData;
  late String nameData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.all(3.0),
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
                onChanged: (String val) {},
                hintText: "Address",
                textInputType: TextInputType.streetAddress),
            const SizedBox(
              height: 8,
            ),
            textFormFeiled(
                onChanged: (String val) {},
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
                if (emailData != null && passwordData != null) {
                  try {
                  //  Firebase.initializeApp();

                    UserCredential userCredential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: emailData,
                      //"hassan@gmail.com",
                      password: passwordData,

                      // "1234"
                    );

                    print("Welcome: ");
                    print( userCredential.user!.displayName);
                    print("your email is");
                      print( userCredential.user!.email);


                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                    }
                  } catch (e) {
                    print(e);
                  }
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
                    icon: Icon(
                      Icons.login_outlined,
                      color: Colors.green,
                    ),
                    label: Text(
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
    );
  }
}
