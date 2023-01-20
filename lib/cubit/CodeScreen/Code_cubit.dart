
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_app_firebase/cubit/CodeScreen/code_state.dart';

import '../../componants/shared_componants/CodeModel.dart';
import '../../componants/shared_componants/CodeScreenCompnants.dart';

class CodeCubit extends Cubit<CodeState>
{
  CodeCubit():super(CodeInitialState());

  String codeEntered="";
  List<CodeModel> codesList=[];



  void addCodeFireStore( String codeId)
  async{

    try {
      await kCreatingCodes.add(
          {
            "code_id":codeId,
          }
      );
      emit(CodeSuccessState());
    } on Exception catch (e) {
      print("Error in adding the code $codeEntered ");
      emit(CodeFailedState());

    }

  }


  void fillCodeListFromFireStore(AsyncSnapshot<QuerySnapshot<Object?>> snapshot)  {
    codesList=[];

    for (int i = 0; i < snapshot.data!.docs.length; i++) {
      //print("snapshot data id is ${snapshot.data!.docs[i].id}");

      try {
        codesList.add(CodeModel.factoryFromJson(snapshot.data!.docs[i]));
        emit(CodeSuccessState());
      } on Exception catch (e) {
       emit(CodeFailedState());
      }

    }
  }


  int findCodeFromList()
  {
    int returnData=-2;
    for(int i= 0;i<=codesList.length;i++)
      {
        if (codesList[i].codeId==codeEntered)
          {
            returnData=i;
          }
        else {
          returnData=-1;
        }
      }
    return returnData;
  }


/*  void getIdFromListByIndex()
  {
    codeId= codesList[findCodeFromList()].codeId;
  }*/



/*  void addCodeToFireStore
  {
  kCreatingCodes.add( );

}*/

}