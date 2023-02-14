import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/bloc/login/login_account_bloc.dart';
import 'package:my_app/screens/otp/otp_screen.dart';

import '../../repository/auth_repository.dart';
import '../dashboard/dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const id = "login_screen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  final LoginAccountBloc accountBloc =
      LoginAccountBloc(LoginAccountInitialState());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height.h,
                width: MediaQuery.of(context).size.width.w,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Nhập số điện thoại để Đăng nhập"),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                          label: Text('Nhập số điện thoại'),
                          border: OutlineInputBorder()),
                    ),
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
                  onPressed: () {
                    context
                        .read<LoginAccountBloc>()
                        .add(SendOtpToPhoneEvent(phone: phoneController.text));
                    // Navigator.of(context).pushNamed(OtpScreen.id);
                  },
                  child: BlocConsumer<LoginAccountBloc, LoginAccountState>(
                    listener: (context, state) {
                      if (state is LoginAccountLoadedState) {
                        Navigator.of(context).pushNamed(DashBoardScreen.id);
                      } else if (state is PhoneAuthCodeSentSuccessState) {
                        Navigator.of(context).pushNamed(OtpScreen.id,
                            arguments: {
                              "verificationId": state.verificationId
                            });
                      } else if (state is LoginAccountErrorState) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(state.error)));
                      }
                    },
                    builder: (context, state) {
                      if (state is LoginAccountLoadingState) {
                        return Center(
                          child: SizedBox(
                            height: 50.h,
                            width: 50.w,
                            child: const CircularProgressIndicator(),
                          ),
                        );
                      } else {
                        return const Text("Login");
                      }
                    },
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
