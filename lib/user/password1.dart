import 'package:flutter/material.dart';
import 'package:project/user/password2.dart';

// ignore: camel_case_types
class password1 extends StatefulWidget {
  const password1({Key? key}) : super(key: key);

  @override
  State<password1> createState() => _password1State();
}

class _password1State extends State<password1> {
  var emailController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                        'Reset Your Password',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,

                             fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                             Container(
                                    decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(80),
                                      color: Color.fromRGBO(217, 217, 217, 0.5),

                                    ),
                               child: Image(
                                   image: AssetImage(
                                       'assets/images/forgot password.png',
                                   ),
                                 width: 179,
                                 height: 178,


                               ),
                             ),
                        SizedBox(
                          height: 97,
                        ),
                        Text(
                            'Please Enter Your Email Address To ',

                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          ' Receive a Verification Code',

                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        Form(
                          key: formKey,
                          child: TextFormField(
                            cursorColor: Colors.black,

                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.25)),
                              floatingLabelStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),
                              labelText: 'Email Address ',



                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(0, 0, 0, 0.25),

                                ),
                                borderRadius: BorderRadius.circular(15.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0,),

                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                ),
                                borderRadius: BorderRadius.circular(15.0,),
                              ),

                              prefixIcon: Icon(
                                Icons.email,
                                color: Color.fromRGBO(0, 0, 0, 0.25),
                              ),

                            ),
                            validator: (Value)
                            {
                              if(Value!.isEmpty)
                              {
                                return 'Email address must not be empty';
                              }
                              if (!RegExp(
                                  "^[a-zA-Z0-9-]+@[a-zA-Z0-9-]+(?:[a-zA-Z0-9-]+)*")
                                  .hasMatch(Value))
                              {
                                return "email must be valid";
                              }
                              return null;
                            },

                          ),
                        ),
                        SizedBox(
                          height: 40,
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
                                    builder: (context) => password2(),
                                  ),
                                );

                              },
                              icon: Text(
                                  'Send',
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
