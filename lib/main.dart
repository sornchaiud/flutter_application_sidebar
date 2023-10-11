import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/counter_model.dart';

import 'screens/home.dart';
import 'screens/contact.dart';
import 'screens/profile.dart';
import 'screens/about.dart';
import 'screens/settings.dart';
import 'screens/products.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Counter()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.pink,
          useMaterial3: true,
        ),
        title: 'First Flutter App',
        initialRoute: '/', // สามารถใช้ home แทนได้
        routes: {
          Home.routeName: (context) => Home(),
          About.routeName: (context) => About(),
          Profile.routeName: (context) => Profile(),
          Contact.routeName: (context) => Contact(),
          Settings.routeName: (context) => Settings(),
          ProductPage.routeName: (context) => ProductPage(),
        },
      ),
    );
  }
}
