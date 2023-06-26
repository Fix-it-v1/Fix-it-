import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/user/controller_home/home_cubit.dart';
import 'package:project/user/google_maps_screen.dart';
import 'package:rate/rate.dart';

class home1 extends StatefulWidget {
  @override
  State<home1> createState() => _home1State();
}

class _home1State extends State<home1> {
  bool electrical = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getUserProfile(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  var cubit = HomeCubit.get(context);
                  return (state is GetProfileDataLoadingState)? const Center(child: CircularProgressIndicator()) :Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color.fromRGBO(217, 217, 217, 1),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.account_circle,
                              color: Colors.black,
                              size: 42,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              '${cubit.dataUserModel.firstName} ${cubit.dataUserModel.lastName}',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 23,
                                color: Color.fromRGBO(18, 34, 55, 1),
                              ),
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            IconButton(
                              onPressed: ()
                              {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> GoogleMapScreen(updateUserLocation: true,)));
                              },
                              icon: Icon(Icons.location_on),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/background.png'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 1,
                                blurRadius: 15,
                                color: Colors.grey,
                              ),
                            ]),
                        child: Stack(
                          children: [
                            Image(
                              image: AssetImage(
                                'assets/images/IMG-20230302-WA0008.jpg',
                              ),
                              height: 150.0,
                              width: 300.0,
                              fit: BoxFit.cover,
                            ),
                            Image(
                              image: AssetImage('assets/images/home.png'),
                              height: 130.0,
                              width: 130.0,
                            ),
                            Positioned(
                              top: 50,
                              right: 10,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'FIX IT ',
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    'EASILY NOW',
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(63, 191, 120, 1),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.menu,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'All Services',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 22,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[300],

                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.electrical_services , color: Colors.green,),
                            SizedBox(width: 10,),
                            Icon(Icons.carpenter , color: Colors.green,),
                            SizedBox(width: 10,),
                            Icon(Icons.plumbing , color: Colors.green,),
                          ],
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 17.0),
                      //   child: Row(
                      //     children: [
                      //       Expanded(
                      //         child: Container(
                      //           decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(20),
                      //             color: electrical
                      //                 ? Color.fromRGBO(242, 185, 113, 1)
                      //                 : Color.fromRGBO(217, 217, 217, 1),
                      //           ),
                      //           child: IconButton(
                      //             onPressed: () {},
                      //             icon: Icon(
                      //               Icons.electrical_services,
                      //             ),
                      //             color: Color.fromRGBO(63, 191, 120, 1),
                      //           ),
                      //         ),
                      //       ),
                      //       SizedBox(
                      //         width: 40,
                      //       ),
                      //       Expanded(
                      //         child: Container(
                      //           decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(20),
                      //             color: !electrical
                      //                 ? Color.fromRGBO(242, 185, 113, 1)
                      //                 : Color.fromRGBO(217, 217, 217, 1),
                      //           ),
                      //           child: IconButton(
                      //             onPressed: () {},
                      //             icon: Icon(
                      //               Icons.carpenter,
                      //             ),
                      //             color: Color.fromRGBO(63, 191, 120, 1),
                      //           ),
                      //         ),
                      //       ),
                      //       SizedBox(
                      //         width: 40,
                      //       ),
                      //       Expanded(
                      //         child: Container(
                      //           decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(20),
                      //             color: Color.fromRGBO(217, 217, 217, 1),
                      //           ),
                      //           child: IconButton(
                      //             onPressed: () {},
                      //             icon: Icon(
                      //               Icons.plumbing,
                      //             ),
                      //             color: Color.fromRGBO(63, 191, 120, 1),
                      //           ),
                      //         ),
                      //       ),
                      //       SizedBox(
                      //         width: 40,
                      //       ),
                      //       Expanded(
                      //         child: Container(
                      //           decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(20),
                      //             color: Color.fromRGBO(217, 217, 217, 1),
                      //           ),
                      //           child: IconButton(
                      //             onPressed: () {},
                      //             icon: Icon(
                      //               Icons.cleaning_services,
                      //             ),
                      //             color: Color.fromRGBO(63, 191, 120, 1),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: Row(
                          children: [
                            Text(
                              'Recommended',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Container(
                        height: 300,
                        width: 400,
                        child: StreamBuilder(
                          stream:  FirebaseFirestore.instance
                      .collection('providers')
                      .snapshots(),
                          builder: (context, snapshot) {
                            if(!snapshot.hasData)
                            {
                              return Container();
                            }else
                            {
                              return ListView.separated(
                                //scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return buildTechItem(snapshot ,index);
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: 25,
                                  );
                                },
                                itemCount: snapshot.data!.docs.length,
                              );

                            }
                          }
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTechItem(AsyncSnapshot snapshot  , int index) {
    double? sum;
    if(snapshot.data!.docs[index]['rate'].isNotEmpty)
    {
      sum = snapshot.data!.docs[index]['rate']
          .reduce((value, element) => value + element);
    }
    return (snapshot.data!.docs[index]['rate'].isNotEmpty && sum!/snapshot.data!.docs[index]['rate'].length >= 2.5  )? Row(
      children: [
        Image(
          image: NetworkImage(
            snapshot.data.docs[index]['image'],
          ),
          height: 40,
          width: 40,
        ),
        Column(
          children:
          [

            Text(
              '${snapshot.data!.docs[index]['firstName']} ${snapshot.data!.docs[index]['lastName']}',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Rate(
              iconSize: 20,
              color: Color.fromRGBO(255, 190, 30, 1),
              allowClear: true,
              allowHalf: true,
              initialValue:(snapshot.data!.docs[index]['rate'].isEmpty)? 0:sum!/snapshot.data!.docs[index]['rate'].length,
              readOnly: true,
              onChange: (value) => print(value),
            ),
          ],
        ),
      ],
    ) : SizedBox(height: 0,);
  }
}
