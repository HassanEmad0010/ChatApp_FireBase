import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_chat_app_firebase/modules/register_screen.dart';

import '../componants/shared_componants/comp.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
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
            textFormFeiled(hintText: "Email", onChanged: (String val) {}),
            const SizedBox(
              height: 8,
            ),
            textFormFeiled(
                onChanged: (String val) {},
                hintText: "Password",
                isPassword: true),
            const SizedBox(
              height: 8,
            ),
            materialButton(buttonText: "Sign-In"),
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
    );
  }
}
