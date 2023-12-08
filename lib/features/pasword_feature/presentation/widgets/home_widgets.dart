import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ramzino/core/widgets/common_widgets.dart';
import 'package:ramzino/features/auth_feature/presentation/bloc/auth_bloc.dart'
    as auth;
import 'package:ramzino/features/pasword_feature/business/entities/password_entity.dart';
import 'package:ramzino/features/pasword_feature/skeleton/page_resources.dart';

/// Home page Widgets
///
class MyIcons {
  static Image creditCardIcon = Image.asset(
    'assets/img/credit-cart.png',
    color: ksecondColor,
    fit: BoxFit.contain,
    height: 40,
    width: 40,
    matchTextDirection: true,
  );
  static Image socialIcon = Image.asset(
    'assets/img/social-media.png',
    color: ksecondColor,
    fit: BoxFit.contain,
    height: 40,
    width: 40,
    matchTextDirection: true,
  );
  static Image webSiteIcon = Image.asset(
    'assets/img/web-site.png',
    color: ksecondColor,
    fit: BoxFit.contain,
    height: 40,
    width: 40,
    matchTextDirection: true,
  );
  static Image otherIcon = Image.asset(
    'assets/img/other.png',
    color: ksecondColor,
    fit: BoxFit.contain,
    height: 40,
    width: 40,
    matchTextDirection: true,
  );
}

class DashboardContainer extends StatelessWidget {
  const DashboardContainer({
    super.key,
    required TextEditingController searchTextControl,
    required this.context,
  }) : _searchTextControl = searchTextControl;

  final TextEditingController _searchTextControl;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height * 0.53,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [kmainColor, ksecondColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25))),
      child: Padding(
        padding: EdgeInsets.fromLTRB(15.w, 30.h, 15.w, 5.h),
        child: Column(
          crossAxisAlignment: RcrossAxisAlignment,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: RmainAxisAlignment,
              children: [
                /// USERNAME  VIEWER
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: ktextColor)),
                  child: Row(
                    children: [
                      Text(
                        context
                            .read<auth.AuthBloc>()
                            .state
                            .userEntity!
                            .username,
                        style: kmediumTextStyle,
                      ),
                      const Icon(
                        Icons.person,
                        color: ktextColor,
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            _SearchInput(
                textController: _searchTextControl, hintText: 'جستجو...'),
            SizedBox(height: 10.h),
            Text(
              'مدیریت',
              style: kmediumTextStyle,
            ),
            Padding(
              padding: EdgeInsets.only(right: 8.w, top: 5.h),
              child: Text(
                'رمز ها',
                style: kLargeTextStyle,
              ),
            ),
            Expanded(child: _BuildGridView(context))
          ],
        ),
      ),
    );
  }
}

class _SearchInput extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  const _SearchInput(
      {required this.textController, required this.hintText, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: const Offset(12, 26),
            blurRadius: 50,
            spreadRadius: 0,
            color: Colors.grey.withOpacity(.1)),
      ]),
      child: TextField(
        textDirection: TextDirection.rtl,
        controller: textController,
        onChanged: (value) {
          //Do something wi
        },
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.grey,
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintTextDirection: TextDirection.rtl,
          hintStyle: const TextStyle(color: Colors.grey),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(18.0)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(18.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(18.0)),
          ),
        ),
      ),
    );
  }
}

class _BuildGridView extends StatelessWidget {
  final BuildContext context;
  const _BuildGridView(this.context);

  @override
  Widget build(BuildContext context) {
    final state = context.read<PasswordBloc>().state;
    return GridView(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
      physics: const NeverScrollableScrollPhysics(),
      // controller: FixedExtentScrollController(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 1,
          // childAspectRatio: 1.6,
          mainAxisExtent: 97.h),
      children: [
        GestureDetector(
          onTap: () {},
          child: _gridCard(
              title: 'شبکه اجتماعی',
              icon: MyIcons.socialIcon,
              subtitle: state.socialList.length.toString()),
        ),
        GestureDetector(
            child: _gridCard(
                title: 'کارت اعتباری',
                icon: MyIcons.creditCardIcon,
                subtitle: state.creditCardList.length.toString())),
        GestureDetector(
          child: _gridCard(
              title: 'وبسایت',
              icon: MyIcons.webSiteIcon,
              subtitle: state.webSiteList.length.toString()),
        ),
        GestureDetector(
          child: _gridCard(
              title: 'متفرقه',
              icon: MyIcons.otherIcon,
              subtitle: state.otherList.length.toString()),
        ),
      ],
    );
  }
}

Widget _gridCard(
    {required String title, required String subtitle, required Image icon}) {
  return Padding(
    padding: EdgeInsets.all(5.h),
    child: Container(
      // width: 120,
      // height: 120,
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.5),
        boxShadow: [
          BoxShadow(
              offset: const Offset(10, 20),
              blurRadius: 10,
              spreadRadius: 0,
              color: Colors.grey.withOpacity(.15)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
              maxRadius: 15.h,
              backgroundColor: Colors.transparent,
              // foregroundColor: kbgColor,
              child: icon),
          Text(title,
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: kmediumTextStyle.copyWith(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800)),
          Text(
            ' $subtitle رمز ',
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: kmediumTextStyle.copyWith(
              color: Colors.black,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    ),
  );
}
/////

class TabsContainer extends StatefulWidget {
  const TabsContainer({
    super.key,
    required TabController tabController,
    required this.context,
  }) : _tabController = tabController;
  final BuildContext context;
  final TabController _tabController;

  @override
  State<TabsContainer> createState() => _TabsContainerState();
}

class _TabsContainerState extends State<TabsContainer> {
  bool _passwordVisibility = false;
  final List<Widget> tabs = const [
    Tab(
      child: Text(
        'پرکاربردها ',
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.center,
      ),
    ),
    Tab(
      child: Text(
        'همه',
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.center,
      ),
    )
  ];

  Widget logoGenerator(PasswordEntity item) {
    // Widget logo;
    switch (item.type) {
      case PasswordType.creditCard:
        {
          return MyIcons.creditCardIcon;
        }
      case PasswordType.social:
        {
          return MyIcons.socialIcon;
        }
      case PasswordType.other:
        {
          return MyIcons.otherIcon;
        }
      case PasswordType.webSite:
        {
          return MyIcons.webSiteIcon;
        }
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    var state = context.read<PasswordBloc>().state;
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height * .41,
      decoration: const BoxDecoration(
        color: kbgColor,
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(15.w, 15.h, 15.w, 5.h),
        child: Column(
          crossAxisAlignment: RcrossAxisAlignment,
          children: [
            Text(
              'رمز های من',
              style: kLargeTextStyle.copyWith(
                  color: Colors.black87, fontSize: 25.sp),
            ),
            SizedBox(
              height: 10.h,
            ),
            Column(
              children: [
                TabBar(
                    unselectedLabelColor: Colors.grey,
                    indicatorWeight: 1,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                        color: kbuttonColor,
                        borderRadius: BorderRadius.circular(15)),
                    isScrollable: false,
                    labelStyle: kmediumTextStyle,
                    labelColor: Colors.black,
                    controller: widget._tabController,
                    tabs: tabs),
              ],
            ),
            Expanded(
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      ksecondColor,
                      Colors.transparent,
                      Colors.transparent,
                      ksecondColor
                    ],
                    stops: [
                      0.0,
                      0.13,
                      0.92,
                      1.0
                    ], // 10% purple, 80% transparent, 10% purple
                  ).createShader(bounds);
                },
                blendMode: BlendMode.dstOut,
                child: TabBarView(controller: widget._tabController, children: [
                  /// most use
                  ListView.builder(
                    itemCount: state.mostUseList.isEmpty
                        ? 1
                        : state.mostUseList.length,
                    itemBuilder: (context, index) => Card(
                        elevation: 2,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        ///// EXPANSION TILE
                        child: state.mostUseList.isNotEmpty
                            ? ExpansionTile(
                                backgroundColor: Colors.white,
                                collapsedShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                collapsedBackgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                title: Text(
                                  state.mostUseList[index].title!,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp),
                                ),
                                subtitle: Text(
                                  state.mostUseList[index].username!,
                                  textAlign: TextAlign.right,
                                ),
                                leading: DropDownMenuFb1(
                                    mostUseTitle: 'حذف از پرکاربرد ها',
                                    onDelete: () {
                                      BlocProvider.of<PasswordBloc>(context)
                                          .add(DeletePasswordEvent(
                                              passID: state
                                                  .mostUseList[index].id!));
                                      Navigator.pop(context);
                                    },
                                    onAddtoMostUse: () {
                                      BlocProvider.of<PasswordBloc>(context)
                                          .add(AddToMostUseEvent(
                                              passId: state
                                                  .mostUseList[index].id!));
                                      Navigator.pop(context);
                                    }),
                                trailing:
                                    logoGenerator(state.mostUseList[index]),
                                children: [
                                  Divider(
                                    thickness: 1,
                                    color: Colors.grey.withOpacity(0.4),
                                  ),
                                  ListTile(
                                    leading: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            Icons.copy,
                                            color:
                                                kbuttonColor.withOpacity(0.5),
                                          ),
                                          onPressed: () async {
                                            await Clipboard.setData(
                                                    ClipboardData(
                                                        text: state
                                                            .mostUseList[index]
                                                            .password!))
                                                .then((_) =>
                                                    Fluttertoast.showToast(
                                                        msg: 'رمز کپی شد!'));
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            _passwordVisibility
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color:
                                                kbuttonColor.withOpacity(0.6),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _passwordVisibility =
                                                  !_passwordVisibility;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    dense: true,
                                    title: Text('رمز :',
                                        textAlign: TextAlign.right,
                                        textDirection: TextDirection.rtl,
                                        style: kmediumTextStyle.copyWith(
                                            color: Colors.black45)),
                                    subtitle: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10.h),
                                      child: Text(
                                          _passwordVisibility
                                              ? state
                                                  .mostUseList[index].password!
                                              : '******',
                                          textAlign: TextAlign.right,
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12.sp)),
                                    ),
                                  ),
                                  ListTile(
                                    dense: true,
                                    title: Text('توضیحات  :',
                                        textAlign: TextAlign.right,
                                        textDirection: TextDirection.rtl,
                                        style: kmediumTextStyle.copyWith(
                                            color: Colors.black45)),
                                    subtitle: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10.h),
                                      child: Text(
                                        state.mostUseList[index].describtion!,
                                        textAlign: TextAlign.right,
                                        textDirection: TextDirection.rtl,
                                        style: kmediumTextStyle.copyWith(
                                            color: Colors.black87),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : SizedBox.square(
                                dimension: 50.h,
                                child: Center(
                                  child: Text(
                                    '!رمز پرکاربردی وجود ندارد',
                                    style: kmediumTextStyle.copyWith(
                                        color: Colors.grey),
                                  ),
                                ),
                              )),
                  ),

                  /// all
                  ListView.builder(
                      itemCount: state.allPasswords.isEmpty
                          ? 1
                          : state.allPasswords.length,
                      itemBuilder: (context, index) =>
                          BlocBuilder<PasswordBloc, PasswordState>(
                            builder: (context, state) {
                              if (state is LoadingState) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return Card(
                                  elevation: 2,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  ///// EXPANSION TILE
                                  child: state.allPasswords.isNotEmpty
                                      ? ExpansionTile(
                                          backgroundColor: Colors.white,
                                          collapsedShape:
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          collapsedBackgroundColor:
                                              Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          title: Text(
                                            state.allPasswords[index].title!,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.sp),
                                          ),
                                          subtitle: Text(
                                            state.allPasswords[index].username!,
                                            textAlign: TextAlign.right,
                                          ),
                                          leading: DropDownMenuFb1(
                                              passwordEntity:
                                                  state.allPasswords[index],
                                              mostUseTitle: state
                                                      .allPasswords[index]
                                                      .isMostUse!
                                                  ? 'حذف از پرکاربرد ها'
                                                  : 'افزودن به پرکاربردها',
                                              onDelete: () {
                                                BlocProvider.of<PasswordBloc>(
                                                        context)
                                                    .add(DeletePasswordEvent(
                                                        passID: state
                                                            .allPasswords[index]
                                                            .id!));
                                                Navigator.pop(context);
                                              },
                                              onAddtoMostUse: () {
                                                BlocProvider.of<PasswordBloc>(
                                                        context)
                                                    .add(AddToMostUseEvent(
                                                        passId: state
                                                            .allPasswords[index]
                                                            .id!));
                                                Navigator.pop(context);
                                              }),
                                          trailing: logoGenerator(
                                              state.allPasswords[index]),
                                          children: [
                                            Divider(
                                              thickness: 1,
                                              color:
                                                  Colors.grey.withOpacity(0.4),
                                            ),
                                            ListTile(
                                              leading: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  IconButton(
                                                    icon: Icon(
                                                      Icons.copy,
                                                      color: kbuttonColor
                                                          .withOpacity(0.5),
                                                    ),
                                                    onPressed: () async {
                                                      await Clipboard.setData(
                                                              ClipboardData(
                                                                  text: state
                                                                      .allPasswords[
                                                                          index]
                                                                      .password!))
                                                          .then((_) => Fluttertoast
                                                              .showToast(
                                                                  msg:
                                                                      'رمز کپی شد!'));
                                                    },
                                                  ),
                                                  IconButton(
                                                    icon: Icon(
                                                      _passwordVisibility
                                                          ? Icons.visibility
                                                          : Icons
                                                              .visibility_off,
                                                      color: kbuttonColor
                                                          .withOpacity(0.6),
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        _passwordVisibility =
                                                            !_passwordVisibility;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                              dense: true,
                                              title: Text('رمز :',
                                                  textAlign: TextAlign.right,
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style:
                                                      kmediumTextStyle.copyWith(
                                                          color:
                                                              Colors.black45)),
                                              subtitle: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10.h),
                                                child: Text(
                                                    _passwordVisibility
                                                        ? state
                                                            .allPasswords[index]
                                                            .password!
                                                        : '******',
                                                    textAlign: TextAlign.right,
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12.sp)),
                                              ),
                                            ),
                                            ListTile(
                                              dense: true,
                                              title: Text('توضیحات  :',
                                                  textAlign: TextAlign.right,
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style:
                                                      kmediumTextStyle.copyWith(
                                                          color:
                                                              Colors.black45)),
                                              subtitle: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10.h),
                                                child: Text(
                                                  state.allPasswords[index]
                                                      .describtion!,
                                                  textAlign: TextAlign.right,
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style:
                                                      kmediumTextStyle.copyWith(
                                                          color:
                                                              Colors.black87),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      : SizedBox.square(
                                          dimension: 50.h,
                                          child: Center(
                                            child: Text(
                                              '!رمز پرکاربردی وجود ندارد',
                                              style: kmediumTextStyle.copyWith(
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ));
                            },
                          ))
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext ctx) {
                return AlertDialog(
                  title: const Text('Please Confirm'),
                  content: const Text('Are you sure to remove the box?'),
                  actions: [
                    // The "Yes" button
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Yes')),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('No'))
                  ],
                );
              });
        },
        child: const Text('Delete'));
  }
}
