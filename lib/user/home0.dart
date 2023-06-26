import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/user/carpentry.dart';
import 'package:project/user/controller_home/home_cubit.dart';
import 'package:project/user/home1.dart';
import 'package:project/user/home2.dart';
import 'package:project/user/home3.dart';
import 'package:project/user/home4.dart';
import 'package:project/user/plumbing.dart';

class home0 extends StatefulWidget {
  int? index;
   home0({Key? key , this.index}) : super(key: key);

  @override
  State<home0> createState() => _home0State();
}

class _home0State extends State<home0> {
  @override
  int currentIndex = 0;
  List<Widget> screens = [
    home1(),
    home2(),
    carprntry(),
    plumbing(),
    home3(),
    home4(),
  ];

  Widget build(BuildContext context) {
    if(widget.index != null)
    {
      currentIndex = widget.index!;
    }
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled,
              ),
              label: '',

            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.manage_accounts_sharp,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.carpenter,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.plumbing,
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
