class Message {

  final String messageVar;
  final String messageEmailVar;


  Message(this.messageVar, this.messageEmailVar);


  factory Message.fromJson ( jsonData)
  {
    return Message(jsonData['message'],jsonData["messageEmail"]) ;
  }

}