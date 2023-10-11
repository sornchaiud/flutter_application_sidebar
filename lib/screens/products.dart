import 'package:flutter/material.dart';

import '../models/product_model.dart';

class ProductPage extends StatefulWidget {
  static const routeName = '/products';

  const ProductPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProductState();
  }
}

class _ProductState extends State<ProductPage> {
  // กำนหดตัวแปรข้อมูล products
  late Future<List<Product>> products;
  // ตัว ScrollController สำหรับจัดการการ scroll ใน ListView
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    products = fetchProduct();
  }

  Future<void> _refresh() async {
    setState(() {
      products = fetchProduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('products'),
      ),
      body: Center(
        child: FutureBuilder<List<Product>>(
          // ชนิดของข้อมูล
          future: products, // ข้อมูล Future
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              bool _visible =
                  false; // กำหนดสถานะการแสดง หรือมองเห็น เป็นไม่แสดง

              if (snapshot.connectionState == ConnectionState.waiting) {
                // เมื่อกำลังรอข้อมูล
                _visible = true; // เปลี่ยนสถานะเป็นแสดง
              }

              if (_scrollController.hasClients) {
                //เช็คว่ามีตัว widget ที่ scroll ได้หรือไม่ ถ้ามี
                // เลื่อน scroll มาด้านบนสุด
                _scrollController.animateTo(0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn);
              }
              return Column(
                children: [
                  Visibility(
                    child: const LinearProgressIndicator(),
                    visible: _visible,
                  ),
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
                            child: ListView.builder(
                              // กรณีมีรายการ แสดงปกติ
                              controller:
                                  _scrollController, // กำนหนด controller ที่จะใช้งานร่วม
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                Product product = snapshot.data![index];
                                Widget card; // สร้างเป็นตัวแปร
                                card = Card(
                                  margin:
                                      const EdgeInsets.all(8.0), // การเยื้องขอบ
                                  child: Column(
                                    children: [
                                      ListTile(
                                        leading: Image.network(
                                          product.image,
                                          width: 100.0,
                                        ),
                                        title: Text(product.title),
                                        subtitle:
                                            Text('Price: \$ ${product.price}'),
                                        trailing: Icon(Icons.more_vert),
                                        onTap: () {
                                          Navigator.of(context).push(
                                              _viewProduct(context, product));
                                        },
                                      ),
                                    ],
                                  ),
                                );
                                return card;
                              },
                              // separatorBuilder:
                              //     (BuildContext context, int index) =>
                              //         const SizedBox(),
                            ),
                          )
                        : const Center(
                            child: Text('No items')), // กรณีไม่มีรายการ
                  )
                ],
              );
            }

            return const RefreshProgressIndicator();
          },
        ),
      ),
    );
  }

  // สร้างฟังก์ชั่น ที่คืนค่าเป็น route ของ object ฟังก์ชั่นนี้ มี context และ product เป็น parameter
  static Route<Object?> _viewProduct(BuildContext context, Product product) {
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) => // ใช้ arrow aฟังก์ชั่น
          Dismissible(
        // คืนค่าเป็น dismissible widget
        direction: DismissDirection.vertical, // เมื่อปัดลงในแนวตั้ง
        key: const Key('key'), // ต้องกำหนด key ใช้ค่าตามนี้ได้เลย
        onDismissed: (_) => Navigator.of(context).pop(), // ปัดลงเพื่อปิด
        child: Scaffold(
          extendBodyBehindAppBar: false, // แสดงพื้นที่ appbar แยก ให้ขายเต็มจอ
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.close, color: Colors.black),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: Container(
            child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        product.image,
                        scale: 2,
                      ),
                      SizedBox(width: 10.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title,
                          ),
                          SizedBox(height: 5.0),
                          Text('Price: \$ ${product.price}'),
                          SizedBox(height: 10.0),
                          // Text(
                          //   'Detail: ${product.description}',
                          //   softWrap: false,
                          // ),
                        ],
                      )
                    ],
                  )
                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: <Widget>[
                  //     Center(
                  //       child: Image.network(product.image),
                  //     ),
                  //     SizedBox(height: 10.0),
                  //     Text(
                  //       product.title,
                  //       style: Theme.of(context).textTheme.headline6,
                  //     ),
                  //     SizedBox(height: 5.0),
                  //     Text('Price: \$ ${product.price}'),
                  //     SizedBox(height: 10.0),
                  //     Text('Detail: ${product.description}'),
                  //   ],
                  // ),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
