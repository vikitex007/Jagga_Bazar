import 'package:flutter/material.dart';

ThemeData getApplicationTheme(){
  return  ThemeData(
    // primarySwatch: Colors.orange,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Montserrat Italic',

    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle:  const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontFamily: 'Montserrat Regular',
            ), backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            )
        )
    ),

    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: EdgeInsets.all(15),
      border: OutlineInputBorder(),
      labelStyle: TextStyle(
        fontSize: 20,
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black,
        ),
      ),
    ),
  );


}
