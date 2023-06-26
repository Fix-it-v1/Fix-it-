import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:project/shared/constant.dart';
import 'package:project/technical/controlller_technical_home/technical_home_cubit.dart';

class Tmessages extends StatelessWidget {
  final String userId;
  final String image;
  final String userName;

  var messageController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  Tmessages(
      {super.key,
      required this.userId,
      required this.image,
      required this.userName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TechnicalHomeCubit(),
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Padding(
                  padding: const EdgeInsets.all(17.0),
                  child: Container(
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
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Image(
                                image: NetworkImage(image),
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
                                // Navigator.push(context, MaterialPageRoute(builder: (context){
                                // return Messages();
                                //}));
                              },
                              child: Text(
                                userName,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 65,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 17.0,
                          ),
                          child: Icon(
                            Icons.phone,
                            color: Color.fromRGBO(31, 249, 12, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
             Expanded(
               child: StreamBuilder(
                 stream: FirebaseFirestore.instance
                     .collection('providers')
                     .doc(uId)
                     .collection('chats')
                     .doc(userId)
                     .collection('messages')
                     .orderBy('timeCreating' , )
                     .snapshots(),
                 builder: (context, snapshot) {
                   if(!snapshot.hasData)
                   {
                     return Container();
                   }else{
                     return ListView.separated(
                       itemBuilder: (context , index)
                     {
                       if (uId ==
                           snapshot.data!.docs[index]['senderId'])
                       {
                         return  Container(
                           width: MediaQuery.of(context).size.width*.5,
                           child: Expanded(
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.end,
                               children: [
                                 Padding(
                                   padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                   child: Container(
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(10),
                                       color: Color.fromRGBO(63, 191, 120, 1),
                                     ),
                                     child: Padding(
                                       padding: const EdgeInsets.symmetric(
                                         vertical: 8.0,
                                         horizontal: 3,
                                       ),
                                       child: Text(
                                         snapshot.data!.docs[index]['message'],
                                         style: TextStyle(
                                           fontSize: 15,
                                           fontWeight: FontWeight.w600,
                                           color: Colors.white,

                                         ),
                                         maxLines: 5,
                                       ),
                                     ),
                                   ),
                                 ),
                               ],
                             ),
                           ),
                         );
                       }
                       return  Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 16.0),
                         child: Container(
                           width: 340,
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(10),
                             color: Color.fromRGBO(129, 123, 123, 1),
                           ),
                           child: Padding(
                             padding: const EdgeInsets.symmetric(
                               vertical: 8.0,
                               horizontal: 3,
                             ),
                             child: Text(
                               snapshot.data!.docs[index]['message'],
                               style: TextStyle(
                                 fontSize: 15,
                                 fontWeight: FontWeight.w600,
                                 color: Colors.white,
                               ),
                             ),
                           ),
                         ),
                       );

                     },
                       separatorBuilder: (context , index) =>  SizedBox(
                         height: 10,
                       ),

                       itemCount: snapshot.data!.docs.length,
                     );

                   }
                 }
               ),
             ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 270,
                        child: Container(
                          height: 40,
                          child: TextFormField(
                            controller: messageController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return '';
                              }
                            },
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
                            ),
                          ),
                        ),
                      ),
                      BlocBuilder<TechnicalHomeCubit, TechnicalHomeState>(
                        builder: (context, state) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0 , vertical: 15),
                            child: InkWell(
                              onTap: () {
                                var now = DateTime.now();
                                var dateTime =
                                    DateFormat.yMMMEd().add_jms().format(now);
                                if (formKey.currentState!.validate()) {
                                  TechnicalHomeCubit.get(context).sendMessage(
                                      receiverId: userId,
                                      message: messageController.text,
                                      timeCreating: dateTime,
                                  );
                                  messageController.clear();
                                }
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.black,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    ),
                                  )),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
