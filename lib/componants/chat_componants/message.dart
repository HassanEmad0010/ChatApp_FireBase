class Message {

  final String messageVar;
  final String messageEmailVar;
  final String messageCode;


  Message(this.messageVar, this.messageEmailVar,this.messageCode);


  factory Message.fromJson ( jsonData)
  {
    return Message(jsonData['message'],jsonData["messageEmail"],jsonData["messageCode"]) ;
  }

}