import 'package:flutter/material.dart';
import 'package:rate/rate.dart';

class TorderDetials extends StatelessWidget {
  final String technicalName;
  final String technicalUid;
  final String location;
  final String timeCreating;
  final String orderId;
  final int index;
  final double rate;

   TorderDetials({super.key, required this.technicalName, required this.technicalUid, required this.location, required this.timeCreating, required this.orderId, required this.index, required this.rate});


  @override
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
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(onPressed: () {
                        Navigator.pop(context);
                      },
                        icon: Icon(
                          Icons.keyboard_arrow_left,
                          color: Colors.black,

                        ),),
                      Text(
                        'Service Details',
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
                    'Service ${index+1} details',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Column(
                    children: [
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
                          SizedBox(width: 120.0,),
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
                            padding: const EdgeInsets.only(right: 40.0,),
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
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 20,
                        child: ElevatedButton(
                          onPressed: () async{
                            showDialog(context: context, builder: (context){
                              return AlertDialog(
                                icon: Image(
                                  width: 118,
                                  height: 105,
                                  image: AssetImage('assets/images/WhatsApp_Image_2023-04-06_at_03.45.41-removebg-preview.png',),
                                ),
                                title: Text('Rate Your Customer?',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                actions: <Widget>[
                                  Center(
                                    child: Rate(
                                      iconSize: 35,
                                      color: Color.fromRGBO(255, 190, 30, 1),
                                      allowClear: true,
                                      allowHalf: true,
                                      initialValue: 3.5,
                                      readOnly: false,
                                      onChange: (value) => print(value),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  TextField(
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(8),
                                      border: OutlineInputBorder( borderRadius: BorderRadius.circular(15),),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Container(
                                    width: double.infinity,
                                    height:35 ,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(63, 191, 120, 1),
                                      borderRadius: BorderRadius.circular(15.0,),
                                    ),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: TextButton(onPressed: ()
                                    {
                                    },
                                      child: Text('Send',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              );
                            },
                            );
                          },
                          child: Text('Rate Me',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 20,
                              color: Color.fromRGBO(0, 0, 0, 0.58),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(primary: Colors.transparent,elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              //side: BorderSide(width: double.infinity,),
                            ),
                          ),

                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40,),
                  Row(
                    children: [
                      Icon(Icons.circle,color: Colors.black,size: 10.0,),
                      SizedBox(width: 8.0,),
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
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Got Rated',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.end,
                      ),
                      SizedBox(width: 10,),
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
                  SizedBox(height: 20,),
                  Divider(
                    height: 13.0,
                    thickness: 3.0,
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image:AssetImage('assets/images/WhatsApp_Image_2023-04-01_at_16.20.39-removebg-preview.png',) ,
                        height: 31,
                        width: 31,
                      ),
                      SizedBox(width: 10.0,),
                      Text(
                        'The Service',
                        style: TextStyle(
                          fontSize: 23.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ) ,
                  SizedBox(height: 10,),
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
                ]
            ),
          ),
        ),
      ),
    );
  }
}
