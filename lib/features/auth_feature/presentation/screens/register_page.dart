import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ramzino/features/auth_feature/presentation/widgets/register_widgets.dart';

import '../../../../core/utils/const.dart';

import '../bloc/auth_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return SingleChildScrollView(
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
                      'ایجاد حساب',
                      style: kmediumTextStyle.copyWith(fontSize: 30),
                    ),
                  ),
                  RegisterForm(context: context)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
