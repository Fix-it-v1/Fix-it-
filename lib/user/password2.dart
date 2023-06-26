import 'package:flutter/material.dart';
import 'package:project/user/password3.dart';

class password2 extends StatefulWidget {
  const password2({Key? key}) : super(key: key);

  @override
  State<password2> createState() => _password2State();
}

class _password2State extends State<password2> {
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
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(onPressed: () {
                        Navigator.pop(context);
                      },
                        icon: Icon(
                          Icons.keyboard_arrow_left,
                          color: Colors.black,

                        ),
                      ),
                      SizedBox(width: 20,),
                      Text(
                        'Verify Your Email',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,

                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(80),
                                        color: Color.fromRGBO(217, 217, 217, 0.5),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Image(
                                            image: AssetImage(
                                                'assets/images/email.png',
                                            ),
                                        ),
                                      ),
                                     height: 142,
                                      width: 142,

                                    ),
                          SizedBox(
                            height: 50,
                          ),
                          Text('Please Enter Your 4-digit code sent to',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 3,),
                          Text('mohamed_sayed95@gmail.com',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 90,),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    width: 45,
                                    height: 52,
                                    child: TextFormField(
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                        floatingLabelStyle: TextStyle(color: Colors.black),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.black,),

                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15.0,)
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            15.0,
                                          ),
                                        ),

                                      ),

                                    ),
                                  ),
                                ),
                                SizedBox(width: 35,),
                                Expanded(
                                  child: Container(
                                    width: 45,
                                    height: 52,
                                    child: TextFormField(
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                        floatingLabelStyle: TextStyle(color: Colors.black),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.black,),

                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15.0,)
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            15.0,
                                          ),
                                        ),

                                      ),

                                    ),
                                  ),
                                ),
                                SizedBox(width: 35,),
                                Expanded(
                                  child: Container(
                                    width: 45,
                                    height: 52,
                                    child: TextFormField(
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                        floatingLabelStyle: TextStyle(color: Colors.black),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.black,),

                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15.0,)
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            15.0,
                                          ),
                                        ),

                                      ),

                                    ),
                                  ),
                                ),
                               SizedBox(width: 35,
                               ),
                                Expanded(
                                  child: Container(
                                    width: 45,
                                    height: 52,
                                    child: TextFormField(
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                        floatingLabelStyle: TextStyle(color: Colors.black),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.black,),

                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15.0,)
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            15.0,
                                          ),
                                        ),

                                      ),

                                    ),
                                  ),
                                ),



                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          TextButton(
                              onPressed: (){},
                              child: Text(
                                  'Resend the code',
                                style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                ),
                              ),
                          ),

                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromRGBO(63, 191, 120, 1),
                            ),

                            child: IconButton(
                              onPressed: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => password3(),
                                  ),
                                );

                              },
                              icon: Text(
                                'verify',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,


                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
