import 'package:flutter/material.dart';

// สร้างข้อมูล app state ชื่อ Counter ใช้งานร่วมกับ ChangeNotifier
class Counter with ChangeNotifier {
  int _count = 0; // กำหนดชนิดข้อมูล และค่าเริ่มต้น

  // กำหนด getter คือค่าจากตัวแปร _count
  int get count => _count;

  // กำหนดคำสั่ง และการทำงาน
  void increment() {
    _count++; // เพิ่มจำนวน
    notifyListeners(); // แจ้งเตือนการเปลี่ยนแปลงข้อมูล
  }

  // กำหนดคำสั่ง และการทำงาน
  void reset() {
    _count = 0; // รีเซ็ตค่า
    notifyListeners(); // แจ้งเตือนการเปลี่ยนแปลงข้อมูล
  }

  // ใช้กำหนดค่า count เริ่มต้นใหม่
  void setCount(int newCount) {
    _count = newCount;
    notifyListeners(); // แจ้งเตือนการเปลี่ยนแปลงข้อมูล
  }
}
