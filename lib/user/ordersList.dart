import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/shared/constant.dart';
import 'package:project/user/orderDetails.dart';
import 'package:rate/rate.dart';

class ordersList extends StatefulWidget {
  @override
  State<ordersList> createState() => _ordersListState();
}

class _ordersListState extends State<ordersList> {
  @override
  Widget build(BuildContext context) {
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
                  Text(
                    'Orders List',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 310,
                    height: 600,
                    padding: EdgeInsets.all(12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromRGBO(56, 55, 55, 0.25), width: 4),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(uId)
                            .collection('ordersList')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Container();
                          } else {
                            return ListView.builder(
                              itemBuilder: (context, index) {
                                return buildOrderItem(snapshot, index);
                              },
                              itemCount: snapshot.data!.docs.length,
                            );
                          }
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOrderItem(
      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Image(
                image: AssetImage(
                  'assets/images/WhatsApp_Image_2023-04-01_at_16.20.39-removebg-preview.png',
                ),
                height: 31,
                width: 31,
              ),
            ),
          ],
        ),
        TextButton(
          child: Text(
            'Order ${index + 1}',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => orderDetails(
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
              'You Rated',
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
              initialValue: snapshot.data!.docs[index]
              ['rate'],
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
