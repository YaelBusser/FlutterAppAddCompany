import 'package:first_app/router_app.dart';
import 'package:first_app/ui/screens/add_company.dart';
import 'package:first_app/ui/screens/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Liste des entreprises',
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)
                .copyWith(background: Colors.white)),
        debugShowCheckedModeBanner: false,
        home: const Home(),
        routes: RouterApp.routes);
  }
}
