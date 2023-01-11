import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_app_firebase/cubit/chat/chat_state.dart';

import '../../componants/shared_componants/comp.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitialState());



}
