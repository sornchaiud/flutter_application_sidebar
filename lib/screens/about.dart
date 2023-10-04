import 'package:flutter/material.dart';
import '../components/sidemenu.dart';

class About extends StatefulWidget {
  static const routeName = '/about';

  const About({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AboutState();
  }
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: const Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('About Us Screen'),
          ],
        ),
      ),
      drawer: const SideMenu(),
    );
  }
}
