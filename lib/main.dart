import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project/select_t_or_c.dart';
import 'package:project/technical/Thome0.dart';
import 'package:project/technical/login.dart';
import 'package:project/user/home0.dart';
import 'package:project/shared/constant.dart';
import 'package:project/shared/shared_preferneces.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await PreferenceUtils.init();


  Widget widget;
  uId = PreferenceUtils.getString(SharedKeys.uId);
  typeUser = PreferenceUtils.getString(SharedKeys.userType);
  print(uId);
  print(typeUser);

  (uId == '') ? widget = const SelectUserOrTechnical() : widget =  (typeUser == 'user')? home0() : Thome0();

  runApp(MyApp(
    startWidget: widget,

  ));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;

  const MyApp({super.key, this.startWidget});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  startWidget,
    );
  }
}
