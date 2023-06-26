class DataTechnicalModel {
  final String? uId;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? email;
  final String? birthDate;
  final String? gender;
  final String? image;
  final String? aboutMe;
  final String? city;
  final String? provideType;
  final String? startFrom;
  final List<dynamic>? rate;

  DataTechnicalModel({
    required this.uId,
    required this.rate,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.birthDate,
     this.aboutMe,
    required this.gender,
    required  this.image,
    required  this.city,
    required  this.phone,
    required  this.provideType,
    required  this.startFrom,
  });


  factory DataTechnicalModel.fromJson(Map<String, dynamic> json) =>
      DataTechnicalModel(
        uId: json['uId'],
        rate:  List<dynamic>.from(json["rate"].map((e) => e)),
        startFrom: json['startFrom'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        email:  json['email'],
        birthDate:  json['birthdate'],
        aboutMe:  json['aboutMe'],
        gender:  json['gender'],
        image:  json['image'],
        city:  json['city'],
        phone:  json['phone'],
        provideType:  json['provideType'],

      );


  Map<String , dynamic> toMap()
  {
    return
      {
        'uId':uId,
        'rate':rate,
        'firstName':firstName,
        'lastName':lastName,
        'email':email,
        'birthdate':birthDate,
        'gender':gender,
        'image':image,
        'phone':phone,
        'city':city,
        'provideType':provideType,
        'startFrom':startFrom,

      };
  }

}


