import 'package:flutter/material.dart';
import 'package:project/technical/login.dart';
import 'package:project/user/login_user.dart';

class SelectUserOrTechnical extends StatelessWidget {
  const SelectUserOrTechnical({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/background.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 40.0),
                          child: Image(image: AssetImage('assets/images/a2-removebg-preview.png'),),
                        ),
                const SizedBox(height: 40,),
                const Text('choose who you are ?',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 23,
                    color: Color.fromRGBO(113, 110, 110, 1),
                  ),

                ),
                const SizedBox(height: 30,),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromRGBO(63, 191, 120, 1),
                  ),
                  child: IconButton(
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context) => const UserLogin(),
                            ),
                        );
                      },
                      icon: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.account_circle,),
                          const SizedBox(width: 80,),
                          const Text('Customer',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                          ),
                          const SizedBox(width: 80,),
                          const Icon(Icons.account_circle,),
                        ],
                      ),
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromRGBO(63, 191, 120, 1),
                  ),
                  child: IconButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TechnicalLogin(),
                        ),
                      );
                    },
                    icon: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.manage_accounts_sharp,),
                        const SizedBox(width: 80,),
                        const Text('Technician',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 80,),
                        const Icon(Icons.manage_accounts_sharp,),
                      ],
                    ),
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
