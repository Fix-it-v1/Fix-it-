import 'package:flutter/material.dart';

String uId = '';
String typeUser = '';
 const defaultProfileImagePathInFirebase = 'https://as1.ftcdn.net/v2/jpg/03/46/83/96/1000_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg';


String receiverId = '';
String userName = '';


void customSnakeBar({
 required  context,
 required widget,
 Color? backgroundColor,
}) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
     content: widget,
     backgroundColor: backgroundColor,
    ));
