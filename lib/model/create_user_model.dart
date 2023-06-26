class DataUserModel {
  final String? uId;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? email;
  final String? birthDate;
  final String? gender;
  final String? image;
  final String? city;

  DataUserModel({
   required this.uId,
   required this.firstName,
   required this.lastName,
   required this.email,
   required this.birthDate,
   required this.gender,
   required  this.image,
   required  this.city,
   required  this.phone,
  });


  factory DataUserModel.fromJson(Map<String, dynamic> json) =>
      DataUserModel(
        uId: json['uId'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        email:  json['email'],
        birthDate:  json['birthdate'],
        gender:  json['gender'],
        image:  json['image'],
        city:  json['city'],
        phone:  json['phone'],

      );


  Map<String , dynamic> toMap()
  {
    return
      {
        'uId':uId,
        'firstName':firstName,
        'lastName':lastName,
        'email':email,
        'birthdate':birthDate,
        'gender':gender,
        'image':image,
        'phone':phone,
        'city':city,

      };
  }

}


