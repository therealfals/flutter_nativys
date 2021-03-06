
import 'package:flutter/material.dart';

import 'form_screen.dart';
import 'home_appli.dart';
import 'my_account.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     routes: {
       '/login':(context)=>FormScreen(),
       '/my-account':(context)=>MyAccount()
     },
     title: 'Coding with babs',
     theme: ThemeData(
      appBarTheme: AppBarTheme(
      )
     ),
     //home: FormScreen(),
     home: HomeAppli(),
     debugShowCheckedModeBanner: false
   );
  }

}