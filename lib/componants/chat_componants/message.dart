class Message {

  final String messageVar;


  Message(this.messageVar);


  factory Message.fromJson ( jsonData)
  {
    return Message(jsonData['message']) ;
  }

}