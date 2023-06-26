import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/shared/constant.dart';
import 'package:project/technical/TorderDetials.dart';
import 'package:project/technical/controlller_technical_home/technical_home_cubit.dart';
import 'package:project/user/google_maps_screen.dart';
import 'package:rate/rate.dart';

class Thome2 extends StatefulWidget {
  @override
  State<Thome2> createState() => _Thome2State();
}

class _Thome2State extends State<Thome2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<TechnicalHomeCubit, TechnicalHomeState>(
          builder: (context, state) {
            var cubit = TechnicalHomeCubit.get(context);
            double sum = cubit.dataTechnicalModel.rate!.reduce((value, element) => value + element);

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
                                  cubit.dataTechnicalModel.provideType.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Color.fromRGBO(0, 0, 0, 0.5),
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Rate(
                                  iconSize: 20,
                                  color: Color.fromRGBO(255, 190, 30, 1),
                                  allowClear: true,
                                  allowHalf: true,
                                  initialValue: sum/cubit.dataTechnicalModel.rate!.length,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 310,
                          height: 480,
                          padding: EdgeInsets.all(12),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromRGBO(56, 55, 55, 0.25),
                                width: 4),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance.collection('providers').doc(uId).collection('services').snapshots(),
                            builder: (context, snapshot) {
                              if(!snapshot.hasData)
                              {
                                return Container();
                              }else
                              {
                                return ListView.builder(
                                  itemBuilder: (context, index) {
                                    return buildOrderTechItem(snapshot , index);
                                  },
                                  itemCount: snapshot.data!.docs.length,
                                );

                              }
                            }
                          ),
                        ),
                      ],
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

  Widget buildOrderTechItem(AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          child: Text(
            'Service ${index+1}',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TorderDetials(
                  index: index,
                  technicalName: snapshot.data!.docs[index]
                  ['technicalName'],
                  location: snapshot.data!.docs[index]
                  ['location'],
                  timeCreating: snapshot.data!.docs[index]
                  ['timeCreating'],
                  orderId: snapshot.data!.docs[index].id,
                  technicalUid: snapshot.data!.docs[index]
                  ['senderId'],
                  rate: snapshot.data!.docs[index]
                  ['rate'],
                )));
          },
        ),
        Text(
          snapshot.data!.docs[index]['timeCreating'],
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w100,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Text(
              'Completed',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: Color.fromRGBO(0, 172, 0, 1),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.check,
              color: Color.fromRGBO(0, 172, 0, 1),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Got Rated',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w100,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Rate(
              iconSize: 20,
              color: Color.fromRGBO(255, 190, 30, 1),
              allowClear: true,
              allowHalf: true,
              initialValue: snapshot.data!.docs[index]['rate'],
              readOnly: true,
              onChange: (value) => print(value),
            ),
          ],
        ),
        Divider(
          thickness: 1,
          color: Colors.grey,
        ),
      ],
    );
  }
}
