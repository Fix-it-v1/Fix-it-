import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:project/shared/constant.dart';
import 'package:project/technical/controlller_technical_home/technical_home_cubit.dart';
import 'package:project/user/controller_home/home_cubit.dart';
import 'package:project/user/google_maps_screen.dart';
import 'package:rate/rate.dart';

class Thome1 extends StatefulWidget {
  @override
  State<Thome1> createState() => _Thome1State();
}

class _Thome1State extends State<Thome1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<TechnicalHomeCubit, TechnicalHomeState>(
          builder: (context, state) {
            var cubit = TechnicalHomeCubit.get(context);
            double? sum;
            if(cubit.dataTechnicalModel.rate!.isNotEmpty)
            {
              sum = cubit.dataTechnicalModel.rate!.reduce((value, element) => value+element);
            }

            return Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/IMG-20230302-WA0008.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Row(
                          children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image(
                                  image: NetworkImage(
                                    cubit.dataTechnicalModel.image.toString(),
                                  ),
                                  height: 40,
                                  width: 40,
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.white,
                              ),
                            ),
                            Column(

                              children: [
                                Text(
                                  '${cubit.dataTechnicalModel.firstName.toString()} ${cubit.dataTechnicalModel.lastName.toString()}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  cubit.dataTechnicalModel.provideType
                                      .toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Color.fromRGBO(0, 0, 0, 0.5),
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                cubit.dataTechnicalModel.rate!.isEmpty ? Text('No rate yet'):Rate(
                                  iconSize: 20,
                                  color: Color.fromRGBO(255, 190, 30, 1),
                                  allowClear: true,
                                  allowHalf: true,
                                  initialValue: sum!/cubit.dataTechnicalModel.rate!.length,
                                  readOnly: true,
                                  onChange: (value) => print(value),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 70,
                            ),
                            IconButton(
                              onPressed: ()
                              {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> GoogleMapScreen(updateTechnicalLocation: true,)));

                              },
                              icon: Icon(Icons.location_on),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Icon(
                                Icons.format_list_bulleted,
                                color: Color.fromRGBO(242, 164, 68, 0.9),
                              ),
                            )),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          'Recently Orders',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 400,
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('providers')
                              .doc(uId)
                              .collection('requests')
                              .orderBy('timeCreating')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Container();
                            } else {
                              return ListView.separated(
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  print(snapshot.data!.docs[index]['location']);

                                  return buildRecentItem(snapshot, index);
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: 24,
                                  );
                                },
                                itemCount: snapshot.data!.docs.length,
                              );
                            }
                          }),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildRecentItem(AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot, int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  snapshot.data!.docs[index]['requestType'],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: 120,
                ),
                Image(
                  image: AssetImage(
                    'assets/images/WhatsApp_Image_2023-04-01_at_16.20.39-removebg-preview.png',
                  ),
                  height: 31,
                  width: 31,
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'order ${index + 1}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(0, 0, 0, 0.5),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Color.fromRGBO(245, 197, 77, 1),
                ),
                Text(
                  snapshot.data!.docs[index]['location'],
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
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
                Container(
                  width: 115,
                  height: 38,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.red,
                  ),
                  child: IconButton(
                    onPressed: ()
                    {
                      TechnicalHomeCubit.get(context).deleteRequestWhenAcceptOrReject(requestId:  snapshot.data!.docs[index].id);
                    },
                    icon: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'Reject',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        //SizedBox(width:5 ,),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            child: Icon(
                              Icons.clear,
                              color: Colors.red,
                            )),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 14,
                ),
                SizedBox(
                  height: 38,
                  width: 115,
                  child: ElevatedButton(
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
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
                                  height: 4,
                                ),
                                Text(
                                  snapshot.data!.docs[index]['requestType'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Name',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  snapshot.data!.docs[index]['userName'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            icon: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image(
                                  image: AssetImage(
                                    'assets/images/WhatsApp_Image_2023-04-06_at_03.10.02-removebg-preview.png',
                                  ),
                                  width: 182,
                                  height: 183,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
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
                                    Text(
                                      snapshot.data!.docs[index]['location'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
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
                                  height: 4,
                                ),
                                Text(
                                  snapshot.data!.docs[index]['technicalPhone'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
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
                                  create: (context) => TechnicalHomeCubit(),
                                  child: BlocConsumer<TechnicalHomeCubit,
                                      TechnicalHomeState>(
                                    listener: (context , state)
                                    {
                                      if(state is AcceptRequestSuccessState)
                                      {
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    builder: (context, state) {
                                      return TextButton(
                                        onPressed: () {
                                          var now = DateTime.now();
                                          var dateTime =
                                          DateFormat.yMMMEd().add_jms().format(now);
                                          TechnicalHomeCubit.get(context)
                                              .acceptRequest(
                                            receiverId: snapshot
                                                .data!.docs[index]['senderId'],
                                            technicalName: snapshot.data!
                                                .docs[index]['technicalName'],
                                            timeCreating: dateTime,
                                            technicalPhone: snapshot.data!
                                                .docs[index]['technicalPhone'],
                                            userName: snapshot.data!.docs[index]
                                                ['userName'],
                                            requestType: snapshot.data!
                                                .docs[index]['requestType'],
                                            location: snapshot.data!.docs[index]
                                                ['location'],
                                            requestId: snapshot.data!.docs[index].id,
                                          );
                                        },
                                        child: InkWell(
                                          onTap: ()
                                          {
                                            // TechnicalHomeCubit.get(context).deleteRequestWhenAcceptOrReject(requestId:  snapshot.data!.docs[index].id);
                                          },
                                          child: Text(
                                            'Close',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Accept',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            child: Icon(
                              Icons.check,
                              color: Colors.green,
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
