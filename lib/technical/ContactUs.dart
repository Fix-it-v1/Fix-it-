import 'package:flutter/material.dart';

class ContactUs extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: AssetImage(
                  'assets/images/WhatsApp Image 2023-04-07 at 01.21.22.jpg',
                ),
              ),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 43,
                      child: TextFormField(

                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(217, 217, 217, 1),

                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0,),

                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(217, 217, 217, 1),
                            ),
                            borderRadius: BorderRadius.circular(15.0,),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Text(
                      'Email',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 43,
                      child: TextFormField(

                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(217, 217, 217, 1),

                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0,),

                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(217, 217, 217, 1),
                            ),
                            borderRadius: BorderRadius.circular(15.0,),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Text(
                      'Message',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 70,
                      child: TextFormField(

                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(217, 217, 217, 1),

                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0,),

                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(217, 217, 217, 1),
                            ),
                            borderRadius: BorderRadius.circular(15.0,),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                        color: Color.fromRGBO(63, 191, 120, 1),
                      ),
                      child: IconButton(
                        onPressed: (){},
                        icon: Text('Save',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ) ,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
