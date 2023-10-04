import 'package:flutter/material.dart';

class Page4 extends StatefulWidget {
  static const routeName = '/about';

  const Page4({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Page4State();
  }
}

class _Page4State extends State<Page4> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Page4 Content'),
        ],
      ),
    );
  }
}
