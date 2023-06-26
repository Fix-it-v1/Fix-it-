import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/shared/constant.dart';
import 'package:project/technical/controlller_technical_home/technical_home_cubit.dart';
import 'package:project/user/controller_home/home_cubit.dart';
import 'package:rate/rate.dart';

class orderDetails extends StatelessWidget {
  final String technicalName;
  final String technicalUid;
  final String location;
  final String timeCreating;
  final String orderId;
  final int index;
  final double rate;

  orderDetails(
      {super.key,
      required this.technicalName,
      required this.location,
      required this.index,
      required this.timeCreating,
      required this.orderId,
      required this.technicalUid,
      required this.rate,
      });

  @override
  double? rateValue;

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(uId)
                    .collection('ordersList')
                    .doc(orderId)
                    .snapshots(),
                builder: (context, snapshot) {
                  print(snapshot.data!.data());
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                            Text(
                              'Order Details',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.black12,
                          height: 20.0,
                          thickness: 4.0,
                        ),
                        Text(
                          'Order ${index + 1} details',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 24.0,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              timeCreating,
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              width: 120.0,
                            ),
                            Text(
                              'EGP200.00',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 40.0,
                              ),
                              child: Text(
                                'Cash',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w200,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 100,
                              height: 20,
                              child: ElevatedButton(
                                onPressed: () async {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        icon: Image(
                                          width: 118,
                                          height: 105,
                                          image: AssetImage(
                                            'assets/images/WhatsApp_Image_2023-03-23_at_12.36.25_AM-removebg-preview.png',
                                          ),
                                        ),
                                        title: Text(
                                          'Rate Your Technician?',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        actions: <Widget>[
                                          Center(
                                            child: Rate(
                                              iconSize: 35,
                                              color: Color.fromRGBO(
                                                  255, 190, 30, 1),
                                              allowClear: true,
                                              allowHalf: true,
                                              initialValue: 5,
                                              readOnly: false,
                                              onChange: (value) {
                                                rateValue = value;
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          TextField(
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.all(8),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          BlocProvider(
                                            create: (context) => HomeCubit(),
                                            child: BlocBuilder<HomeCubit,
                                                HomeState>(
                                              builder: (context, state) {
                                                return Container(
                                                  width: double.infinity,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        63, 191, 120, 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      15.0,
                                                    ),
                                                  ),
                                                  clipBehavior: Clip
                                                      .antiAliasWithSaveLayer,
                                                  child: TextButton(
                                                    onPressed: () {
                                                      HomeCubit.get(context)
                                                          .addAndUpdateRate(
                                                        orderId: orderId,
                                                        rateValue: rateValue!,
                                                        technicalId:
                                                            technicalUid,
                                                      );
                                                    },
                                                    child: Text(
                                                      'Send',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  'Rate Me',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 20,
                                    color: Color.fromRGBO(0, 0, 0, 0.58),
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.transparent,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    //side: BorderSide(width: double.infinity,),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: Icon(
                                Icons.circle,
                                color: Colors.black,
                                size: 10.0,
                              ),
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              location,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'You Rated Ahmed',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w300,
                              ),
                              textAlign: TextAlign.end,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Rate(
                              iconSize: 20,
                              color: Color.fromRGBO(255, 190, 30, 1),
                              allowClear: true,
                              allowHalf: true,
                              initialValue: rate,
                              readOnly: true,
                              onChange: (value) => print(value),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Divider(
                          height: 13.0,
                          thickness: 3.0,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage(
                                'assets/images/WhatsApp_Image_2023-04-01_at_16.20.39-removebg-preview.png',
                              ),
                              height: 31,
                              width: 31,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              'You order with ${technicalName}',
                              style: TextStyle(
                                fontSize: 23.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 30.0,
                          thickness: 3.0,
                        ),
                        Image(
                          image: AssetImage(
                            'assets/images/WhatsApp_Image_2023-03-27_at_02.04.56-removebg-preview.png',
                          ),
                          height: 200,
                          width: 361,
                        ),
                      ]);
                }),
          ),
        ),
      ),
    );
  }
}
