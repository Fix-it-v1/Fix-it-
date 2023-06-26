import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/technical/Thome1.dart';
import 'package:project/technical/Thome2.dart';
import 'package:project/technical/Thome3.dart';
import 'package:project/technical/Thome4.dart';
import 'package:project/technical/controlller_technical_home/technical_home_cubit.dart';

class Thome0 extends StatefulWidget {


  @override
  State<Thome0> createState() => _Thome0State();
}

class _Thome0State extends State<Thome0> {
  @override
  int currentIndex = 0;
  List<Widget> Tscreens = [
    Thome1(),
    Thome2(),
    Thome3(),
    Thome4(),
  ];

  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TechnicalHomeCubit()..getTechnicalProfile(),
      child: Scaffold(
        body: Tscreens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.article_outlined,
              ),
              label: '',

            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message_outlined,
              ),
              label: '',
            ),
          ],
          elevation: 0,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          fixedColor: Color.fromRGBO(242, 164, 68, 1),

        ),
      ),
    );
  }
}
