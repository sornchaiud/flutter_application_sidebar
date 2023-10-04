import 'package:flutter/material.dart';
import '../components/sidemenu.dart';

class Contact extends StatefulWidget {
  static const routeName = '/contact';

  const Contact({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ContactState();
  }
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Contact Screen'),
          ],
        ),
      ),
      drawer: const SideMenu(),
    );
  }
}
