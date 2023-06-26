class RequestModel {
  final String receiverId;
  final String senderId;
  final String technicalName;
  final String timeCreating;
  final String technicalPhone;
  final String userName;
  final String requestType;
  final String location;
  final double? rate;

  RequestModel({required this.receiverId,
    required this.senderId,
    required this.technicalName,
    required this.timeCreating,
    required this.technicalPhone,
    required this.userName,
    required this.requestType,
    required this.location,
    required this.rate,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) =>
      RequestModel(
          receiverId: json['receiverId'],
          senderId: json['senderId'],
          technicalName: json['technicalName'],
          timeCreating: json['timeCreating'],
          technicalPhone: json['technicalPhone'],
          userName: json['userName'],
          requestType: json['requestType'],
          location: json['location'],
          rate: json['rate'],
      );

  Map<String , dynamic> toMap()
  {
    return
      {
        'timeCreating':timeCreating,
        'receiverId':receiverId,
        'senderId':senderId,
        'technicalName':technicalName,
        'userName':userName,
        'location':location,
        'requestType':requestType,
        'technicalPhone':technicalPhone,
        'rate':rate,

      };
  }


}