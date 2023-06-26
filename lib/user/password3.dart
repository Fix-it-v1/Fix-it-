import 'package:flutter/material.dart';

class password3 extends StatefulWidget {
  const password3({Key? key}) : super(key: key);

  @override
  State<password3> createState() => _password3State();
}

class _password3State extends State<password3> {
  @override
  var passwordController = TextEditingController();
  var PasswordController = TextEditingController();

  bool isPasswordShow = true;
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
              child: Center(
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
                          'Create A New Password',
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
                                              'assets/images/password.png',
                                          ),
                                      ),
                                    ),
                                    width: 170,
                                    height: 179,
                                  ),
                          SizedBox(
                            height: 60,
                          ),
                          Text(
                              'your new password must be different',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            'than before password',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                          SizedBox(
                            height: 70,
                          ),
                          TextFormField(
                            cursorColor: Colors.black,

                            keyboardType: TextInputType.visiblePassword,
                            controller: passwordController,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.25)),
                              floatingLabelStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),
                              labelText: 'New password',

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

                              suffixIcon: IconButton(

                                icon: Icon(
                                  isPasswordShow ? Icons.visibility_off : Icons.visibility,
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                ),

                                onPressed: ()
                                {
                                  setState(() {
                                    isPasswordShow   = !isPasswordShow ;
                                  });
                                },
                              ),

                              prefixIcon: Icon(

                                Icons.lock,
                                color: Color.fromRGBO(0, 0, 0, 0.25),
                              ),
                            ),
                            obscureText: isPasswordShow,

                            validator: (Value)
                            {
                              if(Value!.isEmpty)
                              {
                                return 'password must not be empty';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.visiblePassword,
                            controller: PasswordController,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.25)),
                              floatingLabelStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),
                              labelText: 'Confirm password',

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

                              suffixIcon: IconButton(

                                icon: Icon(
                                  isPasswordShow ? Icons.visibility_off : Icons.visibility,
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                ),

                                onPressed: ()
                                {
                                  setState(() {
                                    isPasswordShow   = !isPasswordShow ;
                                  });
                                },
                              ),

                              prefixIcon: Icon(

                                Icons.lock,
                                color: Color.fromRGBO(0, 0, 0, 0.25),
                              ),
                            ),
                            obscureText: isPasswordShow,

                            validator: (Value)
                            {
                              if(Value!.isEmpty)
                              {
                                return 'password must not be empty';
                              }
                              return null;
                            },
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
                              onPressed: (){},
                              icon: Text(
                                'Save',
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
      ),
    );
  }
}
