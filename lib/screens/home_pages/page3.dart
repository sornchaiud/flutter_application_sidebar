import 'package:flutter/material.dart';

class Page3 extends StatefulWidget {
  static const routeName = '/about';

  const Page3({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Page3State();
  }
}

class _Page3State extends State<Page3> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Page3 Content'),
        ],
      ),
    );
  }
}
