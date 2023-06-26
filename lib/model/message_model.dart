class MessageModel {
  final String senderId;
  final String receiverId;
  final String timeCreating;
  final String? message;



  const MessageModel({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.timeCreating,

  });
  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    senderId: json['senderId'],
    receiverId: json['receiverId'],
    message: json['message'],
    timeCreating: json['timeCreating'],

  );

  Map<String , dynamic> toMap()
  {
    return
      {
        'timeCreating':timeCreating,
        'message':message,
        'senderId':senderId,
        'receiverId':receiverId,
      };
  }
}