import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ramzino/features/auth_feature/presentation/widgets/login_widgets.dart';
import '../../../../core/utils/const.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [kmainColor, ksecondColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Column(
          children: [
            Image.asset('assets/img/logo.png'),
            Container(
              padding: EdgeInsets.only(bottom: 20.h),
              child: Text(
                'ورود به حساب',
                style: kmediumTextStyle.copyWith(fontSize: 30),
              ),
            ),
            LoginForm()
          ],
        ),
      ),
    ));
  }
}
