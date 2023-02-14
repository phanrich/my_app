import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});
  static const id = "otp_screen";

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController smsCodeCtrl = TextEditingController();
  String _smsCode = "";
  String _smsCodeRadom = "";
  void setSmsCode(String value) => _smsCode = value;

  randomCode() {
    var rndnumber = "";
    var rnd = Random();
    for (var i = 0; i < 6; i++) {
      rndnumber = rndnumber + rnd.nextInt(9).toString();
    }
    setState(() {
      _smsCodeRadom = rndnumber;
    });
  }

  @override
  void initState() {
    super.initState();
    randomCode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OTP"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height.h,
              width: MediaQuery.of(context).size.width.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Nhập số otp để đăng nhập"),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildInputBox(),
                ],
              ),
            ),
          ),
          SafeArea(
              child: SizedBox(
            width: MediaQuery.of(context).size.width.w,
            height: 60.h,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(OtpScreen.id),
                  child: const Text("Gửi OTP")),
            ),
          ))
        ],
      )),
    );
  }

  _buildInputBox() {
    return Center(
      child: Stack(children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(6, (index) {
              return Container(
                height: MediaQuery.of(context).size.width * 58 / 375,
                width: MediaQuery.of(context).size.width * 47 / 375,
                color: Colors.transparent,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: index < smsCodeCtrl.text.length
                        ? smsCodeCtrl.text[index] != ""
                            ? Colors.red.withOpacity(0.1)
                            : Colors.grey.shade50
                        : Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        color: index < smsCodeCtrl.text.length
                            ? smsCodeCtrl.text[index] != ""
                                ? Colors.red
                                : Colors.grey.shade200
                            : Colors.grey.shade200,
                        width: 1),
                  ),
                  child: Text(
                    index < smsCodeCtrl.text.length
                        ? smsCodeCtrl.text[index]
                        : "",
                  ),
                ),
              );
            }),
          ),
        ),
        Opacity(
            opacity: 0,
            child: TextField(
                maxLength: 6,
                keyboardType: TextInputType.number,
                controller: smsCodeCtrl,
                onChanged: (value) {
                  setState(() {
                    _smsCode = value;
                  });
                }, // provider.setSmsCode,
                cursorColor: Colors.transparent,
                style: const TextStyle(fontSize: 24)))
      ]),
    );
  }
}
