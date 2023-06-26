import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/technical/controlller_technical_home/technical_home_cubit.dart';
import 'package:rate/rate.dart';

class yourProfile extends StatefulWidget {
  @override
  State<yourProfile> createState() => _yourProfileState();
}

class _yourProfileState extends State<yourProfile> {
  File? image;

  final imagePicker = ImagePicker();

  Future uploadImage() async {
    var pickedimage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedimage != null) {
      setState(() {
        image = File(pickedimage.path);
      });
    } else {}
  }

  String? startFrom;
  String? phone;
  String? about;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => TechnicalHomeCubit()..getTechnicalProfile(),
          child: BlocBuilder<TechnicalHomeCubit, TechnicalHomeState>(
            builder: (context, state) {
              var cubit = TechnicalHomeCubit.get(context);
              return Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/IMG-20230302-WA0008.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_left,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Your Profile',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        iconSize: 100,
                        icon: image == null
                            ? Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image(
                                      image: NetworkImage(
                                        cubit.dataTechnicalModel.image
                                            .toString(),
                                      ),
                                    ),
                                    //  Icon(Icons.account_circle,
                                    //   color: Color.fromRGBO(0,0,0,0.25),
                                    //),
                                  ),
                                  IconButton(
                                    onPressed: uploadImage,
                                    icon: Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                        start: 55,
                                        top: 60,
                                      ),
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : ClipRRect(
                                clipBehavior: Clip.hardEdge,
                                borderRadius: BorderRadius.circular(100),
                                child: Image.file(
                                  image!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                        onPressed: uploadImage,
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Text(
                        '${cubit.dataTechnicalModel.firstName.toString()} ${cubit.dataTechnicalModel.lastName.toString()}',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Row(
                          children: [
                            Text(
                              'Service',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        width: 300,
                        height: 34,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color.fromRGBO(217, 217, 217, 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            cubit.dataTechnicalModel.provideType.toString(),
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color.fromRGBO(217, 217, 217, 1),
                              ),
                              child: Image(
                                image: AssetImage(
                                    'assets/images/WhatsApp_Image_2023-03-21_at_9.03.45_PM-removebg-preview.png'),
                                height: 32,
                                width: 32,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Start From ',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 90,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromRGBO(217, 217, 217, 1),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 140,
                                height: 30,
                                child: TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      startFrom = value;
                                    });
                                  },
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                      hintText:
                                          '${cubit.dataTechnicalModel.startFrom} L.E',
                                      hintStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color.fromRGBO(217, 217, 217, 1),
                              ),
                              child: Image(
                                image: AssetImage(
                                    'assets/images/WhatsApp_Image_2023-04-02_at_00.18.23-removebg-preview.png'),
                                height: 32,
                                width: 32,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Phone Number',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromRGBO(217, 217, 217, 1),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 140,
                                height: 30,
                                child: TextFormField(
                                  keyboardType: TextInputType.phone,
                                  onChanged: (value) {
                                    setState(() {
                                      phone = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      hintText:
                                          '${cubit.dataTechnicalModel.phone}',
                                      hintStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              'About',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        width: 340,
                        height: 130,
                        padding: EdgeInsets.only(left: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color.fromRGBO(217, 217, 217, 1),
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            setState(() {
                              about = value;
                            });
                          },
                          decoration: InputDecoration(
                              hintText: (cubit.dataTechnicalModel.aboutMe ==
                                      null)
                                  ? 'Hello, I\'m ${cubit.dataTechnicalModel.firstName.toString()} ${cubit.dataTechnicalModel.lastName.toString()}'
                                  : cubit.dataTechnicalModel.aboutMe,
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                              border: InputBorder.none),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(63, 191, 120, 1),
                            borderRadius: BorderRadius.circular(
                              15.0,
                            ),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: MaterialButton(
                            onPressed: () {
                              if (startFrom != null) {
                                cubit.updateProfileStartFrom(
                                    startFrom: startFrom!);
                              }
                              if (phone != null) {
                                cubit.updateProfilePhone(phone: phone!);
                              }
                              if (image != null) {
                                cubit.uploadProfileImage(image);
                              }
                              if (about != null) {
                                cubit.updateProfileAbout(about: about!);
                              }
                            },
                            child: Text(
                              'Save',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
