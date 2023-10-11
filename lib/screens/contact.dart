import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

import '../validations/validation.dart';

class Contact extends StatefulWidget {
  static const routeName = '/contact';

  const Contact({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ContactState();
  }
}

class _ContactState extends State<Contact> with Validators {
  // สร้างฟอร์ม key หรือ id ของฟอร์มสำหรับอ้างอิง
  final _formKey = GlobalKey<FormState>();

  late DateFormat dateFormat; // รูปแบบการจัดการวันที่และเวลา

  // กำหนดตัวแปรรับค่า
  final _text1 = TextEditingController();
  final _text2 = TextEditingController();
  final _text3 = TextEditingController();
  final _text4 = TextEditingController();

  // กำหนดสถานะการแสดงแบบรหัสผ่าน
  bool _isHidden = true;

  void _selectDate() async {
    DateTime now = DateTime.now();
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2017, 1),
      lastDate: DateTime(now.year + 10, 12),
      helpText: 'Select a date',
    );
    if (newDate != null) {
      setState(() {
        _text1.value =
            TextEditingValue(text: dateFormat.format(newDate).toString());
      });
    }
  }

  // เกียวกับการใช้เวลา
  /// แปลงเวลาจากวันที่ TimeOfDay.fromDateTime(DateTime.now())
  /// เวลาปัจจุบัน TimeOfDay.now()
  /// แบบกำหนดเอง TimeOfDay(hour: 7, minute: 15),
  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime != null) {
      setState(() {
        _text2.value = TextEditingValue(text: newTime.format(context));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // กำหนดรูปแบบการจัดการวันที่และเวลา
    Intl.defaultLocale = 'en';
    initializeDateFormatting();
    dateFormat = DateFormat('d/MM/y', 'en');
  }

  @override
  void dispose() {
    _text1.dispose(); // ยกเลิกการใช้งานที่เกี่ยวข้องทั้งหมดถ้ามี
    _text2.dispose();
    _text3.dispose();
    _text4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
      ),
      body: SingleChildScrollView(
        child: Form(
          // ใช้งาน Form
          key: _formKey, // กำหนด key
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                // กำหนด widget ที่จะใช้งานกับฟอร์ม
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.card_giftcard),
                  ),
                  controller: _text4, // ผูกกับ TextFormField ที่จะใช้
                  validator: Validators.required('Please enter some text'),
                  // keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    // FilteringTextInputFormatter.digitsOnly,//
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]')),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isHidden =
                              !_isHidden; // เมื่อกดก็เปลี่ยนค่าตรงกันข้าม
                        });
                      },
                      icon: Icon(_isHidden // เงื่อนไขการสลับ icon
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  ),
                  controller: _text3, // ผูกกับ TextFormField ที่จะใช้
                  validator: Validators.required('Please enter some text'),
                  obscureText:
                      _isHidden, // ก่อนซ่อนหรือแสดงข้อความในรูปแบบรหัสผ่าน
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.date_range),
                  ),
                  controller: _text1, // ผูกกับ TextFormField ที่จะใช้
                  validator: Validators.required('Please enter some text'),
                  onTap: _selectDate,
                  readOnly: true,
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.alarm),
                  ),
                  controller: _text2, // ผูกกับ TextFormField ที่จะใช้
                  validator: Validators.required('Please enter some text'),
                  onTap: _selectTime,
                  readOnly: true,
                ),
                SizedBox(
                  height: 5.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    // อ้างอิงฟอร์มที่กำลังใช้งาน ตรวจสอบความถูกต้องข้อมูลในฟอร์ม
                    if (_formKey.currentState!.validate()) {
                      //หากผ่าน
                      // แสดงข้อความจำลอง ใน snackbar
                      ScaffoldMessenger.of(context).showSnackBar(
                        // นำค่าข้อมูลไปแสดงหรือใช้งานผ่าน controller
                        SnackBar(
                            content: Text(
                                'Date: ${_text1.text} Time: ${_text2.text}')),
                      );
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
