import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:project/technical/ContactUs.dart';
import 'package:project/technical/controlller_technical_home/technical_home_cubit.dart';
import 'package:project/technical/yourProfile.dart';
class sitModel {
  final String pageName;
  final IconData icon;
  void Function()? onTap;
  sitModel({
    required this.pageName,
    required this.icon,
    required this.onTap,
  });
}
class Thome3 extends StatefulWidget {
  _home3State creatState() => _home3State();


  @override
  State<Thome3> createState() => _home3State();
}

class _home3State extends State<Thome3> {
  bool status = false;
  @override
  Widget build(BuildContext context) {
    List<sitModel> model = [
      sitModel(
          pageName: 'Your Profile',
          icon: Icons.account_circle,
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => yourProfile()));
          }),
      sitModel(
          pageName: 'Contact us',
          icon: Icons.chat,
          onTap: () {
            Navigator.push(
               context, MaterialPageRoute(builder: (context) => ContactUs()));
          }),
      sitModel(
          pageName: 'Log Out',
          icon: Icons.logout,
          onTap: () {
            TechnicalHomeCubit.get(context).signOut(context);

          }),
    ];
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<TechnicalHomeCubit, TechnicalHomeState>(
  builder: (context, state) {
    var cubit = TechnicalHomeCubit.get(context);
    return Column(
            children: [

              SizedBox(
                height: 30,
              ),
              Container(

                child: Image(
                  image: NetworkImage(cubit.dataTechnicalModel.image.toString()),
                ),
                height: 90.0,
                width: 90.0,
              ),
              SizedBox(height: 8),
              Text(
                "${cubit.dataTechnicalModel.firstName.toString()} ${cubit.dataTechnicalModel.lastName.toString()}",
                // style: Theme.of(context).textTheme.headlineSmall,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 8),
              Text(
                cubit.dataTechnicalModel.phone.toString(),
                //  style: Theme.of(context).textTheme.bodyLarge,
                style: TextStyle(
                  color: Color.fromRGBO(242, 164, 68, 1),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:  [

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(


                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0,),
                        color: Color.fromRGBO(217, 217, 217, 1),


                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.notifications,
                          color: Colors.black,
                        ),
                      ),

                    ),
                  ),
                  SizedBox(height: 5,),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      child: IconButton(
                        onPressed: (){},
                        icon: Row(
                          mainAxisAlignment: MainAxisAlignment.start,


                          children:  [
                            Text('Notifications',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8,),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13.0),
                      child: Container(
                        child: FlutterSwitch(
                          width: 45,
                          height: 25,
                          valueFontSize: 25,
                          value: status,
                          toggleSize: 15,
                          borderRadius: 30,
                          padding: 5,

                          onToggle: (val){
                            setState(() {
                              status = val;
                            });
                          },

                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Container(
                height: 400,
                child: ListView.separated(
                  itemCount: model.length,
                  itemBuilder: (context, index) {
                    return Container(
                      // height: 50,
                      child: ListTile(
                        title: Text(model[index].pageName,
                            style: TextStyle(fontSize: 20,
                              fontWeight: FontWeight.w700,)),
                        leading: CircleAvatar(
                            backgroundColor: Color.fromRGBO(217, 217, 217, 1),
                            child: Icon(model[index].icon,color: Colors.black,)),
                        trailing: Icon(Icons.arrow_forward_ios),

                        onTap: model[index].onTap,
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => SizedBox(
                    height: 5,
                  ),
                ),
              ),

            ],
          );
  },
),
        ),
      ),
    );
  }
}