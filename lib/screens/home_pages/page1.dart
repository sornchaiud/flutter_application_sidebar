import 'package:flutter/material.dart';

class Page1 extends StatefulWidget {
  static const routeName = '/about';

  const Page1({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Page1State();
  }
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Page1 Content'),
        ],
      ),
    );
  }
}
