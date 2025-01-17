import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ovision/views/cadastro.dart';
import 'package:ovision/views/foto.dart';
import 'fotoo.dart';
import 'myhomepage.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green,
        primarySwatch: Colors.green,
        appBarTheme: AppBarTheme(
          elevation: 0
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: "Ovision",
      initialRoute: '/',
      routes: {
        '/' :(context) => Home(title: 'principal'),
        '/fotos' :(context) => Fotos(),
        '/cadastro':(context) => Cadastro(title: 'cadastro'),
      }
    );
  }
}
