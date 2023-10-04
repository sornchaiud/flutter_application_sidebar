import 'dart:math';
import 'dart:async'; // สำหรับจัดการข้อมูลแบบ async
import 'dart:convert'; // สำหรับจัดการข้อมูล JSON data

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // มีคำสั่งสำหรับจัดการข้อมูลอยู่ background

class Home extends StatefulWidget {
  static const routeName = '/';

  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  // จำลองข้อมูล สร้างลิสรายการ 100 รายการ
  List<String> items = List<String>.generate(100, (i) => 'Item ${i + 1}');

  // กำนหดตัวแปรข้อมูล articles
  late Future<List<Article>> articles;

  @override
  void initState() {
    print("initState"); // สำหรับทดสอบ
    super.initState();
    articles = fetchArticle(); // ทำตามสัญญา กำหนดค่า โดยให้ไปดึงจากฟังก์ชั่น
  }

  void _refreshData() {
    setState(() {
      print("setState"); // สำหรับทดสอบ
      // Random rng = Random(); // ข้อมูล Random
      // int rd_number = rng.nextInt(20); // สุ่มค่าจาก 0 - 20
      // print(rd_number); // สำหรับทดสอบ
      // // สร้างลิสรายการใหม่
      // items = List<String>.generate(rd_number, (i) => 'Item ${i + 1}');
      articles = fetchArticle(); // โหลดข้อมูลใหม่
    });
  }

  @override
  Widget build(BuildContext context) {
    print("build"); // สำหรับทดสอบ
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: FutureBuilder<List<Article>>(
          // ชนิดของข้อมูล
          future: articles, // ข้อมูล Future
          builder: (context, snapshot) {
            print("builder"); // สำหรับทดสอบ
            print(snapshot.connectionState); // สำหรับทดสอบ
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              // กรณีมีข้อมูล
              return Column(
                children: [
                  Container(
                    // สร้างส่วน header ของลิสรายการ
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color:
                          const Color.fromRGBO(0, 150, 136, 1).withAlpha(100),
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
                    child: snapshot.data!.length > 0 // กำหนดเงื่อนไขตรงนี้
                        ? ListView.separated(
                            // กรณีมีรายการ แสดงปกติ
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(snapshot.data![index].title),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(),
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
      floatingActionButton: FloatingActionButton(
        // ปุ่มสำหรับดึงข้อมูลใหม่
        onPressed: _refreshData,
        child: const Icon(Icons.refresh),
      ),
    );
  }

  // สรัางฟังก์ชั่นดึงข้อมูล คืนค่ากลับมาเป็นข้อมูล Future ประเภท List ของ Article
  Future<List<Article>> fetchArticle() async {
    // ทำการดึงข้อมูลจาก server ตาม url ที่กำหนด
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );

    // เมื่อมีข้อมูลกลับมา
    if (response.statusCode == 200) {
      // ส่งข้อมูลที่เป็น JSON String data ไปทำการแปลง เป็นข้อมูล List<Article
      // โดยใช้คำสั่ง compute ทำงานเบื้องหลัง เรียกใช้ฟังก์ชั่นชื่อ parseArticles
      // ส่งข้อมูล JSON String data ผ่านตัวแปร response.body
      return compute(parseArticles, response.body);
    } else {
      // 4xx, 5xx
      // กรณี error
      throw Exception('Failed to load article');
    }
  }

  // ฟังก์ชั่นแปลงข้อมูล JSON String data เป็น เป็นข้อมูล List<Article>
  List<Article> parseArticles(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Article>((json) => Article.fromJson(json)).toList();
  }
}

class Article {
  final int userId;
  final int id;
  final String title;
  final String body;

  Article({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  // ส่วนของ name constructor ที่จะแปลง json string มาเป็น Article object
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
