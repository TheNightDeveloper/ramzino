import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ramzino/features/welcome_feature/presentation/bloc/welcome_bloc.dart';
import 'package:ramzino/features/welcome_feature/presentation/widgets/welcome_widgets.dart';

import '../../../../core/utils/const.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WelcomeBloc, WelcomeState>(
        builder: (context, state) {
          return Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [kmainColor, ksecondColor],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
            width: MediaQuery.sizeOf(context).width,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                PageView(
                  controller: pageController,
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  onPageChanged: (page) {
                    // print(page);
                    context.read<WelcomeBloc>().add(Trigger(page));
                  },
                  children: const [
                    pageViewBuilder(
                      describtion:
                          'استفاده از رمز های غیر ایمن برای حساب هایتان را متوقف کنید. با استفاده از قابلیت ایجاد رمز رمزینو، امنیت را به حریم شخصی خود هدیه دهید',
                      txt1: 'ساخت',
                      txt2: 'رمز',
                      txt3: 'امن',
                    ),
                    pageViewBuilder(
                      txt1: 'تمام',
                      txt2: 'رمزهایتان',
                      txt3: 'در یکجا',
                      describtion:
                          'ذخیره و مدیریت تمامی رمز هایتان در یک محل امن، تنها کافیست یک شاه رمز را به خاطر بسپارید',
                    ),
                    pageViewBuilder(
                      txt1: 'تایپ نکن،',
                      txt2: 'رمزها خودکار',
                      txt3: 'تایپ میشن',
                      describtion:
                          'امنیت رمزهاتو با تایپ کردن به خطر ننداز، بزار رمزینو خودش برات مینویسه',
                    ),
                  ],
                ),
                Positioned(
                    bottom: 110.h,
                    child: buildButton1('بعدی', pageController, context)),
                Positioned(bottom: 60.h, child: buildButton2('ورود', context)),
                Positioned(
                  bottom: 30.h,
                  child: buildDotsIndicator(context),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
