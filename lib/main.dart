import 'package:charity/shared/network/dio.dart';
import 'package:flutter/material.dart';

import 'modules/register/register_screen.dart';

void main() async{
  await DioHelperPayment.init();
  runApp(const MyApp(
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'futura'
      ),
      debugShowCheckedModeBanner: false,
      title: 'Payment',

      home: RegisterScreen(),
    );
  }
}




