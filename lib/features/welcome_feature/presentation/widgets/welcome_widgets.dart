import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ramzino/features/welcome_feature/presentation/bloc/welcome_bloc.dart';

import '../../../../config/routes/names.dart';
import '../../../../core/utils/const.dart';

Widget buildButton1(
    String text, PageController pageController, BuildContext context) {
  return ElevatedButton(
      onPressed: () {
        var index = context.read<WelcomeBloc>().state.index;
        if (index < 2) {
          pageController.nextPage(
              duration: const Duration(milliseconds: 1500),
              curve: Curves.fastEaseInToSlowEaseOut);
        } else {
          sharedPreferencesService.setBool(storageDeviceOpenFirstTime, false);
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.registerPage, (route) => false);
        }
      },
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          fixedSize: Size(300.w, 40.h),
          backgroundColor: kbuttonColor),
      child: Text(text, style: kmediumTextStyle.copyWith(fontSize: 25)));
}

Widget buildButton2(String text, BuildContext context) {
  return ElevatedButton(
      onPressed: () {
        sharedPreferencesService.setBool(storageDeviceOpenFirstTime, false);
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.registerPage, (route) => false);
      },
      style: ElevatedButton.styleFrom(
        side: BorderSide(color: kbuttonColor, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        fixedSize: Size(300.w, 40.h),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: Text(text,
          style: kmediumTextStyle.copyWith(fontSize: 25, color: kbuttonColor)));
}

Widget buildDotsIndicator(BuildContext context) {
  return DotsIndicator(
      reversed: true,
      position: context.read<WelcomeBloc>().state.index,
      mainAxisAlignment: MainAxisAlignment.center,
      dotsCount: 3,
      decorator: const DotsDecorator(
        color: ksecondColor,
        size: Size.square(7),
        activeColor: kmainColor,
        activeSize: Size.square(12),
      ));
}

class pageViewBuilder extends StatelessWidget {
  const pageViewBuilder({
    super.key,
    required this.txt1,
    required this.txt2,
    required this.txt3,
    required this.describtion,
  });
  final String txt1, txt2, txt3;
  final String describtion;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 250.h, left: 20.w, right: 20.w),
      child: Column(
        crossAxisAlignment: RcrossAxisAlignment,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  txt1,
                  style: kLargeTextStyle.copyWith(fontSize: 60.sp),
                  textDirection: TextDirection.rtl,
                ),
                Text(
                  txt2,
                  style: kLargeTextStyle.copyWith(fontSize: 60.sp),
                  textDirection: TextDirection.rtl,
                ),
                Text(
                  txt3,
                  style: kLargeTextStyle.copyWith(
                      fontSize: 60.sp, color: Colors.redAccent),
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 35.h),
            child: Text(
              describtion,
              style: kmediumTextStyle,
              textDirection: TextDirection.rtl,
            ),
          )
        ],
      ),
    );
  }
}
