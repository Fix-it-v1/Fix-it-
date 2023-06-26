import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:project/shared/constant.dart';
import 'package:project/user/controller_home/home_cubit.dart';
import 'package:project/user/google_maps_screen.dart';
import 'package:project/user/home0.dart';
import 'package:rate/rate.dart';

class profile extends StatefulWidget {
  final String? placeDes;
  final String? userName;
  final String? userUId;
  final String? image;
  final String? phone;
  final String? provideType;
  final String? startFrom;
  late bool openDialog = false;

  profile(
      {super.key,
      this.placeDes,
      required this.openDialog,
      this.image,
      this.userName,
      this.phone,
      this.provideType,
      this.userUId,
      this.startFrom,
      });

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  void initState() {
    super.initState();

    if (widget.openDialog) {
      Timer.run(() => showDialog(
          context: context,
          builder: (context) {
            return customAlertDialogMethod();
          }));
    }
  }


  @override
  BuildContext? dcontext;

  dismissDialog(context) {
    if (dcontext == null) {
      Navigator.pop(context!);
    }
  }

  var phoneController = TextEditingController();
  var requestController = TextEditingController();
  var formKey = GlobalKey<FormState>();


  Widget build(BuildContext context) {
    if(widget.userName != null)
    {
      receiverId = widget.userUId!;
      userName = widget.userName!;
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
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
                      '${widget.userName}’s Profile',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Image(
                      image: NetworkImage(widget.image.toString()),
                      height: 88,
                      width: 88,
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  widget.userName.toString(),
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
                      widget.provideType.toString(),
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
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                      width: 11,
                    ),
                    Text(
                      'Start From ${widget.startFrom}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
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
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                      width: 11,
                    ),
                    Text(
                      widget.phone.toString(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
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
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromRGBO(217, 217, 217, 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Text(
                      'Hello, I am Ahmed.',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                SizedBox(
                  height: 42,
                  width: 340,
                  child: ElevatedButton(
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return customAlertDialogMethod();
                        },
                      );
                    },
                    child: Text(
                      'Request',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(63, 191, 120, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        //side: BorderSide(width: double.infinity,),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Form customAlertDialogMethod() {
    return Form(
      key: formKey,
      child: AlertDialog(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'The Request',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: requestController,
              validator: (Value) {
                if (Value!.isEmpty) {
                  return 'request must not be empty';
                }
              },
              cursorColor: Colors.black,
              decoration: InputDecoration(
                labelStyle:
                    const TextStyle(color: Color.fromRGBO(0, 0, 0, 0.25)),
                floatingLabelStyle: const TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(
                    15.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                  15.0,
                )),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(
                    15.0,
                  ),
                ),
                prefixIcon: const Icon(
                  Icons.miscellaneous_services_outlined,
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                ),
              ),
            ),
          ],
        ),
        icon: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Location',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                ),
                (widget.placeDes == null)
                    ? InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  GoogleMapScreen()));
                        },
                        child: Text(
                          'select your addrees',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      )
                    : InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  GoogleMapScreen()));
                  },
                      child: Text(
                          widget.placeDes.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                    ),
              ],
            ),
          ],
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Phone Number',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              validator: (Value) {
                if (Value!.isEmpty) {
                  return 'phone must not be empty';
                }
              },
              cursorColor: Colors.black,
              decoration: InputDecoration(
                labelStyle: const TextStyle(color: Color.fromRGBO(0, 0, 0, 0.25)),
                floatingLabelStyle: const TextStyle(color: Colors.black),
                labelText: ' Mobile Number',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(
                    15.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                  15.0,
                )),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(
                    15.0,
                  ),
                ),
                prefixIcon: const Icon(
                  Icons.add_call,
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                ),
              ),
            ),
          ],
        ),
        actions: [
        Container(
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
          color: Color.fromRGBO(63, 191, 120, 1),
          borderRadius: BorderRadius.circular(
            15.0,
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: BlocProvider(
  create: (context) => HomeCubit()..getUserProfile(),
  child: BlocConsumer<HomeCubit, HomeState>(
  listener: (context, state) {
   if(state is SendUserRequestSuccessState)
   {
     Navigator.pushAndRemoveUntil(
         context, MaterialPageRoute(builder: (context) => home0()), (
         route) => false);
   }
  },
  builder: (context, state) {
    return TextButton(
          onPressed: () {
            var now = DateTime.now();
            var dateTime =
            DateFormat.yMMMEd().add_jms().format(now);
            if (formKey.currentState!.validate()) {
              if (widget.placeDes != null) {
                HomeCubit.get(context).sendRequest(
                  receiverId: receiverId,
                  technicalName: userName,
                  timeCreating: dateTime,
                  technicalPhone: phoneController.text,
                  userName: '${ HomeCubit.get(context).dataUserModel.firstName} ${ HomeCubit.get(context).dataUserModel.lastName}',
                  requestType: requestController.text,
                  location: widget.placeDes.toString(),
                );
              }
            }
          },
          child: Text(
            'Confirm',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        );
  },
),
),
      ),
        ],
      ),
    );
  }
}
