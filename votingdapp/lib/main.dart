import 'package:flutter/material.dart';
import 'package:votingdapp/pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Home(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.grey,
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.yellow))),
            appBarTheme: AppBarTheme(elevation: 0)));
  }
}
