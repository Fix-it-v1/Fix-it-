import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/user/Messages.dart';

class home4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(17.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22.0,
                        vertical: 17,
                      ),
                      child: Text(
                        'Messages',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 23,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 550,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('providers')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Container();
                        } else {
                          return ListView.separated(
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return buildChatItem(context, snapshot, index);
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
        ),
      ),
    );
  }

  Widget buildChatItem(context, AsyncSnapshot snapshot, int index) {
    double? sum;
    if(snapshot.data!.docs[index]['rate'].isNotEmpty)
    {
      sum = snapshot.data!.docs[index]['rate']
          .reduce((value, element) => value + element);
    }

    return Container(
      height: 79,
      width: 360,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromRGBO(217, 217, 217, 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image(
                  image: NetworkImage(snapshot.data!.docs[index]['image']),
                  height: 70,
                  width: 70,
                ),
              ),
            ),
          ),
          Column(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Messages(
                      userId: snapshot.data!.docs[index]['uId'],
                      image: snapshot.data!.docs[index]['image'],
                      userName:
                          '${snapshot.data!.docs[index]['firstName']} ${snapshot.data!.docs[index]['lastName']}',
                      rate: (snapshot.data!.docs[index]['rate'].isEmpty)?'0':'${sum!/snapshot.data!.docs[index]['rate'].length}',
                    );
                  }));
                },
                child: Text(
                  '${snapshot.data!.docs[index]['firstName']} ${snapshot.data!.docs[index]['lastName']}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              Row(
                children: [
                  (snapshot.data!.docs[index]['rate'].isEmpty)?Text('No rate'):Text(
                    ' Technical/ ${sum! / snapshot.data!.docs[index]['rate'].length}',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(0, 0, 0, 0.35),
                    ),
                  ),

                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.star,
                    color: Color.fromRGBO(252, 214, 14, 1),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            width: 45,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 17.0,
            ),
            child: IconButton(
              icon: Icon(
                Icons.phone,
                color: Color.fromRGBO(31, 249, 12, 1),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
