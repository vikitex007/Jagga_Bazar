import 'package:flutter/material.dart';
import 'package:jaggabazar/view/login_screen.dart';
import 'package:jaggabazar/view/onboard_screen.dart';
import 'package:jaggabazar/view/register_screen.dart';



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/onboard',
      routes: {
        '/onboard': (context)=> OnboardScreen(),
        // '/dashboard':(context) => DashboardScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(), // Add your RegisterScreen here
      },
    );
  }
}
