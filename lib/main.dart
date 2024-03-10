import 'package:flutter/material.dart';
import 'pages/home_page.dart';




void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contacts App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        primarySwatch: Colors.orange,
        primaryColor: Colors.white,
        hintColor: Colors.orange,
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white),
          headline6: TextStyle(color: Colors.white),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(color: Colors.white),
          iconTheme: IconThemeData(color: Colors.orange),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.white),
          fillColor: Colors.grey[850],
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black, backgroundColor: Colors.orange,
          ),
        ),
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
