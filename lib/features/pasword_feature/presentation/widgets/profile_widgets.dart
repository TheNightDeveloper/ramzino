import 'package:ramzino/features/pasword_feature/skeleton/page_resources.dart';

import '../../../auth_feature/presentation/bloc/auth_bloc.dart';

class MenuContainer extends StatefulWidget {
  final BuildContext context;
  const MenuContainer({super.key, required this.context});

  @override
  State<MenuContainer> createState() => _MenuContainerState();
}

class _MenuContainerState extends State<MenuContainer> {
  final TextEditingController _passwordController =
      TextEditingController(text: 'username');
  // final TextEditingController _passwordController =
  //     TextEditingController(text: 'password');

  @override
  Widget build(BuildContext context) {
    String username = context.read<AuthBloc>().state.userEntity!.username;
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
              vertical: 15.h,
              horizontal: 15.w,
            ),
            child: Column(
              children: [
                /// DARK MODE SWITCH
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
                       _CustomSwitch(),
                      Text(
                        'حالت تاریک',
                        style: kmediumTextStyle.copyWith(
                            color: Colors.black87, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),

                /// FINGERPRINT LOGIN SWITCH
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
                       _CustomSwitch(),
                      Text(
                        'ورود با شناسایی اثرانگشت ',
                        style: kmediumTextStyle.copyWith(
                            color: Colors.black87, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),

                ExpansionTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  backgroundColor: Colors.white,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(
                    'اطلاعات حساب کاربری',
                    textAlign: TextAlign.right,
                    style: kmediumTextStyle.copyWith(
                        color: Colors.black87, fontWeight: FontWeight.bold),
                  ),
                  children: [
                    Divider(
                      thickness: 1,
                      color: Colors.grey.withOpacity(0.4),
                    ),
                    ListTile(
                      leading: IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: kbuttonColor,
                        ),
                        onPressed: () {},
                      ),
                      dense: true,
                      title: Text('نام کاربری:',
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          style:
                              kmediumTextStyle.copyWith(color: Colors.black45)),
                      subtitle: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Text(username,
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            style:
                                kmediumTextStyle.copyWith(color: Colors.black)),
                      ),
                    ),
                    ListTile(
                      leading: IconButton(
                        icon: const Icon(Icons.edit, color: kbuttonColor),
                        onPressed: () {},
                      ),
                      dense: true,
                      title: Text('رمز عبور :',
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          style:
                              kmediumTextStyle.copyWith(color: Colors.black45)),
                      subtitle: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Text(
                          '********',
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          style:
                              TextStyle(color: Colors.black, fontSize: 12.sp),
                        ),
                      ),
                    )
                  ],
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

class _CustomSwitch extends StatefulWidget {
  

  @override
  State<_CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<_CustomSwitch> {
  bool isSwitchOn = false;
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          useMaterial3: true,
        ),
        child: Switch(
          value: isSwitchOn,
          activeColor: kbuttonColor,
          onChanged: (value) {
            setState(() {
              isSwitchOn = value;
            });
          },
        ));
  }
}
