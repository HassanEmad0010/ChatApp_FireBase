

import 'dart:convert';

class CodeModel {
  String codeId;

  CodeModel({required this.codeId});


  @override
  int get hashCode => codeId.hashCode;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CodeModel &&
            runtimeType == other.runtimeType &&
            codeId == other.codeId;
  }


  factory CodeModel.factoryFromJson  (var jsonData  )
  {
    return CodeModel(codeId: jsonData["code_id"]);
  }

}

/*
some facts:
override of hasu code and equals came from ChatGpt suggestion for me
to help me to use the contains method from the list correctly:
   bool contains=  codeCubit.codesList.contains(CodeModel(codeId: "9090"));
   why this code always returns false ??
   chatgpt:
   This code snippet is checking if the list "codesList" of the object "codeCubit"
   contains an object of the type "CodeModel" with the property "codeId" equal to "9090".
    If the list does contain such an object, the variable "contains" is assigned the value "true",
    otherwise it is assigned the value "false."
    */
