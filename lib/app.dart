import 'package:flutter/material.dart';



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/onboard',
      routes: {
        // '/onboard': (context)=> OnboardScreen(),
        // '/dashboard':(context) => DashboardScreen(),
        // '/login': (context) => LoginScreen(),
        // '/register': (context) => RegisterScreen(), // Add your RegisterScreen here
      },
    );
  }
}
