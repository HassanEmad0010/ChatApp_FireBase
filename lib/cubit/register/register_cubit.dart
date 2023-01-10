import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_app_firebase/cubit/register/register_state.dart';

import '../../componants/chat_componants/chatcomp.dart';

class RegisterCubit extends Cubit<RegisterState> {
   late String registerFailedCode;
   late String emailData ;
   late String passwordData;
   RegisterCubit() : super(RegisterInitialState());


   Future<void> userCredentialEmailPass({required String email, required String pass}) async {
     emit(RegisterLoadingState());
     try {
       await FirebaseAuth.instance
           .createUserWithEmailAndPassword(
         email: email,
         password: pass,
       );
      await addUserColorFirebase(userEmail: emailData);
     emit(RegisterSuccessState());
     } on FirebaseAuthException catch (e) {
       registerFailedCode=e.code;
       emit(RegisterFailedState());
       }
     on Exception catch (e) {
       emit(RegisterFailedState());
       registerFailedCode= e.toString();
     }
   }



}
