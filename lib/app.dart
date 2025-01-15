import 'package:flutter/material.dart';
import 'package:jagga_bazar/view/dashboard_screen.dart';
import 'package:jagga_bazar/view/login_screen.dart';
import 'package:jagga_bazar/view/onboard_screen.dart';
import 'package:jagga_bazar/view/register_screen.dart';


import 'core/app_theme/app_theme.dart';



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getApplicationTheme(),

      initialRoute: '/dashboard',
      routes: {
        // '/onboard': (context)=> const OnboardScreen(),
        '/dashboard':(context) => DashboardScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => RegisterScreen(), // Add your RegisterScreen here
      },
    );
  }
}
