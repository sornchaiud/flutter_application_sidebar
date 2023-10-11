import 'dart:async'; // สำหรับจัดการข้อมูลแบบ async

import 'package:flutter/material.dart';

import '../models/article.dart';

class Home extends StatefulWidget {
  static const routeName = '/';

  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  // กำนหดตัวแปรข้อมูล articles
  late Future<List<Article>> articles;

  @override
  void initState() {
    super.initState();
    articles = fetchArticle();
  }

  Future<void> _refresh() async {
    setState(() {
      articles = fetchArticle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: FutureBuilder<List<Article>>(
          // ชนิดของข้อมูล
          future: articles, // ข้อมูล Future
          builder: (context, snapshot) {
            // มีข้อมูล และต้องเป็น done ถึงจะแสดงข้อมูล ถ้าไม่ใช่ ก็แสดงตัว loading
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: [
                  Container(
                    // สร้างส่วน header ของลิสรายการ
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.orange.withAlpha(100),
                    ),
                    child: Row(
                      children: [
                        Text(
                            'Total ${snapshot.data!.length} items'), // แสดงจำนวนรายการ
                      ],
                    ),
                  ),
                  Expanded(
                    // ส่วนของลิสรายการ
                    child: snapshot.data!.isNotEmpty // กำหนดเงื่อนไขตรงนี้
                        ? RefreshIndicator(
                            onRefresh: _refresh,
                            child: ListView.separated(
                              // กรณีมีรายการ แสดงปกติ
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                Article article = snapshot.data![index];

                                Widget card; // สร้างเป็นตัวแปร
                                card = Card(
                                    margin: const EdgeInsets.all(
                                        5.0), // การเยื้องขอบ
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title: Text(article.title),
                                        ),
                                        const Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            TextButton(
                                              child: const Text('Like'),
                                              onPressed: () {/* ... */},
                                            ),
                                            const SizedBox(width: 8),
                                            TextButton(
                                              child: const Text('Comment'),
                                              onPressed: () {/* ... */},
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Container(
                                                color:
                                                    Colors.orange.withAlpha(50),
                                                alignment:
                                                    Alignment.centerRight,
                                                child: TextButton(
                                                  child: const Text('Share'),
                                                  onPressed: () {/* ... */},
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ));
                                return card;
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const SizedBox(),
                            ),
                          )
                        : const Center(
                            child: Text('No items')), // กรณีไม่มีรายการ
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              // กรณี error
              return Text('${snapshot.error}');
            }
            // กรณีสถานะเป็น waiting ยังไม่มีข้อมูล แสดงตัว loading
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
