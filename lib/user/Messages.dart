import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:project/shared/constant.dart';
import 'package:project/user/controller_home/home_cubit.dart';

class Messages extends StatelessWidget {
  final String userId;
  final String image;
  final String userName;
  final String rate;

  Messages(
      {Key? key,
      required this.userId,
      required this.image,
      required this.userName,
      required this.rate,
      })
      : super(key: key);

  var messageController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
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
                                image: NetworkImage(image),
                                height: 70,
                                width: 70,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              userName,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  ' Technical/ $rate',
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
                          .collection('users')
                          .doc(uId)
                          .collection('chats')
                          .doc(userId)
                          .collection('messages')
                          .orderBy(
                            'timeCreating',
                          )
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Container();
                        } else {
                          return ListView.separated(
                            itemBuilder: (context, index) {
                              if (uId ==
                                  snapshot.data!.docs[index]['senderId']) {
                                return Container(
                                  width:
                                      MediaQuery.of(context).size.width * .5,
                                  child: Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Color.fromRGBO(
                                                  63, 191, 120, 1),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 8.0,
                                                horizontal: 3,
                                              ),
                                              child: Text(
                                                snapshot.data!.docs[index]
                                                    ['message'],
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
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Container(
                                  width: 150,
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
                            separatorBuilder: (context, index) => SizedBox(
                              height: 10,
                            ),
                            itemCount: snapshot.data!.docs.length,
                          );
                        }
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0 , vertical: 16),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 270,
                        child: Container(
                          height: 40,
                          child: TextFormField(
                            controller: messageController,
                            cursorColor: Colors.black,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return '';
                              }
                            },
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
                      BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          return InkWell(
                            onTap: ()
                            {
                              var now = DateTime.now();
                              var dateTime =
                              DateFormat.yMMMEd().add_jms().format(now);
                              if (formKey.currentState!.validate()) {
                                HomeCubit.get(context).sendMessage(
                                  receiverId: userId,
                                  message: messageController.text,
                                  timeCreating: dateTime,
                                );
                                messageController.clear();
                              }
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
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
