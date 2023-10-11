import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/counter_model.dart';

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
    Counter counter = context.read<Counter>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer<Counter>(
              builder: (context, counter, child) {
                return Column(
                  children: [
                    Text('${counter.count}',
                        key: const Key('counterState'),
                        style: Theme.of(context).textTheme.headlineMedium),
                    if (child != null) child,
                  ],
                );
              },
              child: ElevatedButton(
                onPressed: () => counter.reset(),
                child: const Text('Reset Counter'),
              ),
            ),
          ],
        ),
      ),
      drawer: const SideMenu(),
    );
  }
}
