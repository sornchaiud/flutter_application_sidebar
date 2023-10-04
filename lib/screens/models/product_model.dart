import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product {
  int id;
  String title;
  num price;
  String description;
  String category;
  String image;
  Rating? rating;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: json['rating'] != null ? Rating.fromJson(json['rating']) : null,
    );
  }
}

class Rating {
  num? rate;
  int? count;

  Rating({
    this.rate,
    this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(rate: json['rate'], count: json['count']);
  }
}

// สรัางฟังก์ชั่นดึงข้อมูล คืนค่ากลับมาเป็นข้อมูล Future ประเภท List ของ Product
Future<List<Product>> fetchProduct() async {
  // ทำการดึงข้อมูลจาก server ตาม url ที่กำหนด
  String url = 'https://fakestoreapi.com/products';
  final response = await http.get(Uri.parse(url));

  // เมื่อมีข้อมูลกลับมา
  if (response.statusCode == 200) {
    // ส่งข้อมูลที่เป็น JSON String data ไปทำการแปลง เป็นข้อมูล List<Product
    // โดยใช้คำสั่ง compute ทำงานเบื้องหลัง เรียกใช้ฟังก์ชั่นชื่อ parseProducts
    // ส่งข้อมูล JSON String data ผ่านตัวแปร response.body
    return compute(parseProducts, response.body);
  } else {
    // กรณี error
    throw Exception('Failed to load product');
  }
}

// ฟังก์ชั่นแปลงข้อมูล JSON String data เป็น เป็นข้อมูล List<Product>
List<Product> parseProducts(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Product>((json) => Product.fromJson(json)).toList();
}
