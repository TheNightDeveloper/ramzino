import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ramzino/core/utils/const.dart';

import '../../../../config/routes/names.dart';

class MenuContainer extends StatefulWidget {
  final BuildContext context;
  const MenuContainer({super.key, required this.context});

  @override
  State<MenuContainer> createState() => _MenuContainerState();
}

class _MenuContainerState extends State<MenuContainer> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: kbgColor,
      elevation: 20,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Container(
          margin: EdgeInsets.only(top: 2.h),
          height: 575.h,
          width: double.infinity,
          decoration: const BoxDecoration(
              color: kbgColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25), topLeft: Radius.circular(25))),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 25.h,
              horizontal: 15.w,
            ),
            child: Column(
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, AppRoutes.profileSettingPage);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: kbgColor,
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.grey.withOpacity(0.4)))),
                      // color: kbgColor,
                      height: 50.h,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.grey,
                          ),
                          Text(
                            'اطلاعات حساب کاربری',
                            style: kmediumTextStyle.copyWith(
                                color: Colors.black87),
                          )
                        ],
                      ),
                    )),
                Container(
                  decoration: BoxDecoration(
                      color: kbgColor,
                      border: Border(
                          bottom:
                              BorderSide(color: Colors.grey.withOpacity(0.4)))),
                  // color: kbgColor,
                  height: 50.h,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _CustomGlowSwitch(),
                      Text(
                        'حالت تاریک',
                        style: kmediumTextStyle.copyWith(color: Colors.black87),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: kbgColor,
                      border: Border(
                          bottom:
                              BorderSide(color: Colors.grey.withOpacity(0.4)))),
                  // color: kbgColor,
                  height: 50.h,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _CustomGlowSwitch(),
                      Text(
                        'جایگذاری خودکار',
                        style: kmediumTextStyle.copyWith(color: Colors.black87),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

SliverAppBar buildSliverAppBar() {
  return SliverAppBar(
    backgroundColor: Colors.white,
    pinned: false,
    floating: true,
    expandedHeight: 300,
    flexibleSpace: FlexibleSpaceBar(
      titlePadding: EdgeInsets.all(5.h),
      collapseMode: CollapseMode.pin,
      centerTitle: true,
      title: Text(
        'حساب کاربری',
        style: kLargeTextStyle.copyWith(color: Colors.black87, fontSize: 20.sp),
      ),
      background: Image.asset('assets/img/profile.png'),
    ),
  );
}

class _CustomGlowSwitch extends StatefulWidget {
  const _CustomGlowSwitch();

  @override
  State<_CustomGlowSwitch> createState() => _CustomGlowSwitchState();
}

class _CustomGlowSwitchState extends State<_CustomGlowSwitch> {
  bool switchSelected = false;
  @override
  Widget build(BuildContext context) {
    return GlowSwitch(
      onChanged: (value) {
        setState(() {
          switchSelected = value;
        });
      },
      value: switchSelected,
      activeColor: kbuttonColor,
      blurRadius: 2,
    );
  }
}
