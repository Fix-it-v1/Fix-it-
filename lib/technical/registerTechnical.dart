import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/capitails.dart';
import 'package:project/shared/constant.dart';
import 'package:project/shared/shared_preferneces.dart';
import 'package:project/technical/Thome0.dart';
import 'package:project/technical/clippers.dart';
import 'package:project/technical/controller_technical_auth/auth_tech_cubit.dart';
import 'package:project/technical/login.dart';

List<String> list = <String>['Electricity', 'Carpentry', 'Plumping'];

class registerTechnical extends StatefulWidget {

  @override
  State<registerTechnical> createState() => _registerTechnicalState();
}

class _registerTechnicalState extends State<registerTechnical> {
  String _value = 'male';

  var emailController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var cityController = TextEditingController();
  var dayController = TextEditingController();
  var yearController = TextEditingController();
  var monthController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  String dropdownValue = list.first;
  var formKey = GlobalKey<FormState>();

  bool isPasswordShow = true;

  File? image;

  final imagePicker = ImagePicker();

  Future uploadImage() async {
    var pickedimage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedimage != null) {
      setState(() {
        image = File(pickedimage.path);
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => AuthTechCubit(),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TechnicalBuilder(),
                  IconButton(
                    iconSize: 100,
                    icon: image == null
                        ? Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: const Icon(
                            Icons.account_circle,
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                          ),
                        ),
                        IconButton(
                          onPressed: uploadImage,
                          icon: const Padding(
                            padding: EdgeInsetsDirectional.only(
                              start: 55,
                              top: 40,
                            ),
                            child: Icon(
                              Icons.add,
                              color: Color.fromRGBO(63, 191, 120, 1),
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    )
                        : ClipRRect(
                      clipBehavior: Clip.hardEdge,
                      borderRadius: BorderRadius.circular(100),
                      child: Image.file(
                        image!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    onPressed: uploadImage,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                inputFormatters:
                                [
                                  UpperCaseTextFormatter(),
                                ],
                                controller: firstNameController,
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  labelStyle: const TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, 0.25)),
                                  floatingLabelStyle: const TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                  ),
                                  labelText: 'First Name',
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromRGBO(0, 0, 0, 0.25),
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      15.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        15.0,
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      15.0,
                                    ),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.account_circle,
                                    color: Color.fromRGBO(0, 0, 0, 0.25),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 14.0,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: lastNameController,
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  labelStyle: const TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 0.25),
                                  ),
                                  floatingLabelStyle: const TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                  ),
                                  labelText: 'last Name',
                                  border: OutlineInputBorder(
                                    borderSide:
                                    const BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(
                                      15.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        15.0,
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      15.0,
                                    ),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.account_circle,
                                    color: Color.fromRGBO(0, 0, 0, 0.25),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          controller: phoneController,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            labelStyle: const TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 0.25)),
                            floatingLabelStyle:
                            const TextStyle(color: Colors.black),
                            labelText: ' Mobile Number',
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(
                                15.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  15.0,
                                )),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(
                                15.0,
                              ),
                            ),
                            prefixIcon: const Icon(
                              Icons.add_call,
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Date of birth',
                              style: TextStyle(
                                fontSize: 23.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: TextFormField(
                                    controller: dayController,
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      labelStyle: const TextStyle(
                                          color: Color.fromRGBO(0, 0, 0, 0.25)),
                                      floatingLabelStyle:
                                      const TextStyle(color: Colors.black),
                                      labelText: 'Day',
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          15.0,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            15.0,
                                          )),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          15.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: monthController,
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      labelStyle: const TextStyle(
                                          color: Color.fromRGBO(0, 0, 0, 0.25)),
                                      floatingLabelStyle:
                                      const TextStyle(color: Colors.black),
                                      labelText: 'Month',
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          15.0,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            15.0,
                                          )),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          15.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: yearController,
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      labelStyle: const TextStyle(
                                          color: Color.fromRGBO(0, 0, 0, 0.25)),
                                      floatingLabelStyle:
                                      const TextStyle(color: Colors.black),
                                      labelText: 'Year',
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          15.0,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            15.0,
                                          )),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          15.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          controller: cityController,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            labelStyle: const TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 0.25)),
                            floatingLabelStyle:
                            const TextStyle(color: Colors.black),
                            labelText: 'City',
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(
                                15.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  15.0,
                                )),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(
                                15.0,
                              ),
                            ),
                            prefixIcon: const Icon(
                              Icons.account_balance_sharp,
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.accessibility_new,
                              color: Colors.grey.shade600,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                              'Gender :',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 'male',
                              groupValue: _value,
                              onChanged: (value) {
                                setState(() {
                                  _value = value!;
                                });
                              },
                            ),
                            const Text(
                              'Male',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Radio(
                              value: 'female',
                              groupValue: _value,
                              onChanged: (value) {
                                setState(() {
                                  _value = value!;
                                });
                              },
                            ),
                            const Text(
                              'Female',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Container(
                                margin: EdgeInsets.all(
                                10),
                                decoration: BoxDecoration
                                  (                                color: Colors.grey[300],

                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                                child: DropdownButton(
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black),
                        value: dropdownValue,
                                    icon: const Icon(Icons.arrow_downward,color: Colors.green,),
                                    elevation: 16,
                                    items:
                                    list.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 10.0),
                                          child: Text(value),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value)
                                    {

                                      setState(() {
                                        dropdownValue = value!;
                                      });
                                      print(value);
                                      print(dropdownValue);
                                    }),
                              ),
                            ),


                          ],
                        ),
                        GestureDetector(
                          onTap: getImage,
                          child: postImage == null
                              ? DottedBorder(
                            dashPattern: [8, 4],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.camera_alt,
                                    color: Color.fromRGBO(0, 0, 0, 0.25),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    'Add ID photo',
                                    style: TextStyle(
                                      color:
                                      Color.fromRGBO(0, 0, 0, 0.25),
                                      fontSize: 23,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                              : Center(
                            child: Row(
                              children: [
                                Image.file(
                                  File(postImage!),
                                  fit: BoxFit.fill,
                                  height: 65,
                                  width: 130,
                                ),
                                //Text(' ID photo')
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          decoration: InputDecoration(
                            labelStyle: const TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                            ),
                            floatingLabelStyle: const TextStyle(
                              color: Colors.black,
                            ),
                            labelText: 'Email Address ',
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(
                                15.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                15.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(
                                15.0,
                              ),
                            ),
                            prefixIcon: const Icon(
                              Icons.email,
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                            ),
                          ),
                          validator: (Value) {
                            if (Value!.isEmpty) {
                              return 'Email address must not be empty';
                            }
                            if (!RegExp(r'\S+@\S+\.\S+').hasMatch(Value)) {
                              return "email must be valid";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.visiblePassword,
                          controller: passwordController,
                          decoration: InputDecoration(
                            labelStyle: const TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 0.25)),
                            floatingLabelStyle: const TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1)),
                            labelText: 'password',
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(0, 0, 0, 0.25),
                              ),
                              borderRadius: BorderRadius.circular(
                                15.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                15.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(0, 0, 0, 1),
                              ),
                              borderRadius: BorderRadius.circular(
                                15.0,
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                isPasswordShow
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: const Color.fromRGBO(0, 0, 0, 0.25),
                              ),
                              onPressed: () {
                                setState(() {
                                  isPasswordShow = !isPasswordShow;
                                });
                              },
                            ),
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                            ),
                          ),
                          obscureText: isPasswordShow,
                          validator: (Value) {
                            if (Value!.isEmpty) {
                              return 'password must not be empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),


                        BlocConsumer<AuthTechCubit, AuthTechState>(
                          listener: (context, state) {
                            if (state is RegisterTechSuccessState)
                            {
                              PreferenceUtils.setString(SharedKeys.uId, uId);
                              PreferenceUtils.setString(SharedKeys.userType, 'technical');
                              Navigator.pushAndRemoveUntil(
                                  context, MaterialPageRoute(builder: (context) => Thome0()), (
                                  route) => false);
                              customSnakeBar(context: context , widget: const Text('Registration successfully') , backgroundColor: Colors.green);

                            }
                            if(state is RegisterTechErrorState)
                            {
                              customSnakeBar(context: context , widget:  Text(state.error) , backgroundColor: Colors.red);

                            }
                          },
                          builder: (context, state) {
                            return Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(63, 191, 120, 1),
                                borderRadius: BorderRadius.circular(
                                  15.0,
                                ),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: MaterialButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    AuthTechCubit.get(context).technicalSignUp(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      firstName: firstNameController.text,
                                      lastName: lastNameController.text,
                                      birthDate: "${dayController.text}/${monthController.text}/${yearController.text}",
                                      gender: _value,
                                      image: image != null ? image!.path : defaultProfileImagePathInFirebase,
                                      city: cityController.text,
                                      phone: phoneController.text,
                                      provideType: dropdownValue,
                                    );
                                  }
                                },
                                child: const Text(
                                  'SIGNUP',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(82, 89, 85, 1),
                            borderRadius: BorderRadius.circular(
                              15.0,
                            ),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: MaterialButton(
                            onPressed: ()
                            {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                  builder: (context) => const TechnicalLogin()));
                            },
                            child: const Text(
                              'LOGIN',
                              style: TextStyle(
                                color: Colors.white,
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

  Widget TechnicalBuilder() =>
      SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              child: Container(
                height: 100,
                width: double.infinity,
                color: const Color.fromRGBO(63, 191, 120, 1),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(
                    textAlign: TextAlign.center,
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              clipper: clippers(),
            ),
          ],
        ),
      );

  String? postImage;
  final ImagePicker _picker = ImagePicker();

  Future getImage() async {
    final XFile? image =
    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (image != null) {
      postImage =
          image.path /*base64Encode(File(image.path).readAsBytesSync())*/;
      print(postImage);
      setState(() {
        postImage = image.path;
      });
      //emit(ForumImageSuccessState());
    } else {
      print('Image not selected');
      setState(() {});
      //emit(ForumImageErrorState());
    }
  }
}
