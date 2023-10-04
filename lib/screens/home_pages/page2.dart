import 'package:flutter/material.dart';

class Page2 extends StatefulWidget {
  static const routeName = '/about';

  const Page2({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Page2State();
  }
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Page2 Content'),
        ],
      ),
    );
  }
}
