import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/user/profile.dart';
import 'package:rate/rate.dart';

class carprntry extends StatefulWidget {
  const carprntry({Key? key}) : super(key: key);
  @override
  State<carprntry> createState() => _carprntryState();
}

class _carprntryState extends State<carprntry> {
  @override
  BuildContext? dcontext;
  dismissDialog(context) {
    if (dcontext == null) {
      Navigator.pop(context!);
    }
  }
  var searchController = TextEditingController();

  bool showSearchContent = false;

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(17.0),
            child: Column(
              children: [
                Text(
                  'Services',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  '(Choose Your Type Of Service)',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Color.fromRGBO(242, 164, 68, 1),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Container(
                      height: 33,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromRGBO(217, 217, 217, 1),
                      ),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Electrecity',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      height: 33,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromRGBO(255, 193, 114, 1),
                      ),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Carpentry',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      height: 33,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromRGBO(217, 217, 217, 1),
                      ),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Plumbing',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  height: 39,
                  child: TextFormField(
                    controller: searchController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(

                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(217, 217, 217, 1),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          15.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(217, 217, 217, 1),
                        ),
                        borderRadius: BorderRadius.circular(
                          15.0,
                        ),
                      ),
                      suffixIcon: IconButton(onPressed: (){
                        FocusManager.instance.primaryFocus?.unfocus();
                        searchController = TextEditingController();
                        setState(() {
                          showSearchContent  = false;
                          searchController.clear();
                        });
                      }, icon: Icon(Icons.cancel_outlined)),

                    ),
                    onChanged: (value) {
                      setState(() {
                        showSearchContent  = true;
                      });
                    },


                  ),
                ),
                SizedBox(height: 15,),
                (showSearchContent == true)?StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('providers')
                      .where(
                      'firstName', isLessThanOrEqualTo: searchController.text.toLowerCase())
                      .snapshots(),
                  //initialData: InitialData,
                  builder:
                      (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      print('Loading');
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return SizedBox(
                        height: 500,
                        child: ListView.builder(
                          itemCount:
                          (snapshot.data as dynamic).docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            print('success');
                            return (snapshot.data!.docs[index]['firstName']
                                .toLowerCase()
                                .contains(searchController.text.toLowerCase())  &&
                                snapshot.data!.docs[index]['provideType'] == 'Carpentry' )? buildUserItem(context, snapshot, index) : SizedBox(height: 0,);
                          },
                        ),
                      );
                    }
                  },
                ):SizedBox(height: 0,),

                SizedBox(
                  height: 16,
                ),
                (showSearchContent != true)?Container(
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
                              return (snapshot.data!.docs[index]['provideType'] == 'Carpentry')?buildUserItem(context, snapshot, index):SizedBox(height: 0,);
                            },
                            separatorBuilder: (context, index) {
                              return (snapshot.data!.docs[index]['provideType'] == 'Carpentry')? SizedBox(
                                height: 24,
                              ):SizedBox(height: 0,);
                            },
                            itemCount: snapshot.data!.docs.length,
                          );
                        }
                      }),
                ):SizedBox(height: 0,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildUserItem(context, AsyncSnapshot<QuerySnapshot> snapshot,
      int index) {
    double? sum;
    if (snapshot.data!.docs[index]['rate'].isNotEmpty) {
      sum = snapshot.data!.docs[index]['rate']
          .reduce((value, element) => value + element);
    }

    return Container(
      height: 79,
      width: 360,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: (showSearchContent == true)?Colors.green:Color.fromRGBO(217, 217, 217, 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Image(
                  image: NetworkImage(snapshot.data!.docs[index]['image']),
                  height: 70,
                  width: 70,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              profile(
                                openDialog: false,
                                userName:
                                '${snapshot.data!
                                    .docs[index]['firstName']} ${snapshot.data!
                                    .docs[index]['lastName']}',
                                userUId: snapshot.data!.docs[index]['uId'],
                                image: snapshot.data!.docs[index]['image'],
                                phone: snapshot.data!.docs[index]['phone'],
                                provideType: snapshot.data!.docs[index]
                                ['provideType'],
                                startFrom: snapshot.data!.docs[index]
                                ['startFrom'],
                              )));
                },
                child: Text(
                  '${snapshot.data!.docs[index]['firstName']} ${snapshot.data!
                      .docs[index]['lastName']}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              Row(
                children: [
                  (snapshot.data!.docs[index]['rate'].isEmpty)
                      ? Text('No rate')
                      : Text(
                    ' Technical/ ${sum! /
                        snapshot.data!.docs[index]['rate'].length}',
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
          Padding(
            padding: const EdgeInsets.only(top: 17.0, left: 40),
            child: Text(
              'Online',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Color.fromRGBO(31, 249, 12, 1),
              ),
            ),
          ),
        ],
      ),
    );
  }}
