import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_app_firebase/cubit/login/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
    String logoinFailedCode="00";

  LoginCubit() : super(LoginInitialState());
  Future<void> userCredentialSignInWithEmailAndPassword(
      {required String enteredEmail, required String enteredPass}) async {
    emit(LoginLoadingState());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: enteredEmail, password: enteredPass);
      emit(LoginSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      logoinFailedCode=e.code;
      emit(LoginFailedState());

    }

    on Exception  catch (e) {
      print(e);
      logoinFailedCode=e.toString();
      emit(LoginFailedState());

    }
  }
}
