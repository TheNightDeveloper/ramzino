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
      height: MediaQuery.sizeOf(context).height * 0.55,
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
            SizedBox(
              height: 15.h,
            ),
            _SearchInput(
                textController: _searchTextControl, hintText: 'جستجو...'),
            SizedBox(
              height: 15.h,
            ),
            Text(
              'مدیریت',
              style: kmediumTextStyle,
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.only(
                right: 10.w,
              ),
              child: Text(
                'رمز ها',
                style: kLargeTextStyle,
              ),
            ),
            Expanded(child: _buildGridView(context))
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

class _buildGridView extends StatelessWidget {
  final BuildContext context;
  const _buildGridView(this.context);

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
        // GestureDetector(
        //   onTap: () => BlocProvider.of<PasswordBloc>(context).add(
        //       AddPasswordEvent(PasswordParams(
        //           title: 'telegram',
        //           username: 'sadegh',
        //           password: '1234',
        //           describtion: 'this is a test'))),
        //   child: _gridCard(
        //     title: 'اپلیکیشن',
        //     icon: Icon(Icons.apps),
        //   ),
        // ),
        // _gridCard(
        //   title: 'حساب بانکی',
        //   icon: Icon(Icons.monetization_on),
        // ),
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
      width: 150,
      height: 150,
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
        children: [
          CircleAvatar(
              maxRadius: 18.h,
              backgroundColor: Colors.transparent,
              // foregroundColor: kbgColor,
              child: icon),
          SizedBox(
            height: 8.h,
          ),
          Text(title,
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: kmediumTextStyle.copyWith(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800)),
          SizedBox(
            height: 5.h,
          ),
          Text(
            ' $subtitle رمز ',
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: kmediumTextStyle.copyWith(
              color: Colors.black,
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    ),
  );
}
/////

class TabsContainer extends StatelessWidget {
  const TabsContainer({
    super.key,
    required TabController tabController,
    required this.context,
  }) : _tabController = tabController;
  final BuildContext context;
  final TabController _tabController;
  final List<Widget> tabs = const [
    Tab(
      child: Text(
        'مورد علاقه ',
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.center,
      ),
    ),
    Tab(
      child: Text(
        'اخیر ',
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
      height: MediaQuery.sizeOf(context).height * 0.38,
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
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                        color: kbuttonColor,
                        borderRadius: BorderRadius.circular(15)),
                    isScrollable: false,
                    labelStyle: kmediumTextStyle,
                    labelColor: Colors.black,
                    controller: _tabController,
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
                child: TabBarView(controller: _tabController, children: [
                  /// favorites
                  ListView.builder(
                      itemCount: state.favoriteList.isEmpty
                          ? 1
                          : state.favoriteList.length,
                      itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.h),
                            child: Card(
                              elevation: 2,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                  ),
                                  child: state.favoriteList.isNotEmpty
                                      ? ListTile(
                                          title: Text(
                                            '${state.favoriteList[index].title}',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.sp),
                                          ),
                                          subtitle: Text(
                                            '${state.favoriteList[index].username}',
                                            textAlign: TextAlign.right,
                                          ),
                                          leading:
                                              Icon(Icons.arrow_back_ios_new),
                                          trailing: logoGenerator(
                                              state.favoriteList[index]),
                                        )
                                      : SizedBox.square(
                                          dimension: 50.h,
                                          child: Center(
                                            child: Text(
                                              'چیزی برای نمایش وجود ندارد',
                                              style: kmediumTextStyle.copyWith(
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        )),
                            ),
                          )),

                  /// recent use
                  ListView.builder(
                      itemCount: state.recentUsedList.isEmpty
                          ? 1
                          : state.recentUsedList.length,
                      itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.h),
                            child: Card(
                              elevation: 2,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                  ),
                                  child: state.recentUsedList.isNotEmpty
                                      ? ListTile(
                                          title: Text(
                                            '${state.recentUsedList[index].title}',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.sp),
                                          ),
                                          subtitle: Text(
                                            '${state.recentUsedList[index].username}',
                                            textAlign: TextAlign.right,
                                          ),
                                          leading:
                                              Icon(Icons.arrow_back_ios_new),
                                          trailing: logoGenerator(
                                              state.recentUsedList[index]),
                                        )
                                      : SizedBox.square(
                                          dimension: 50.h,
                                          child: Center(
                                            child: Text(
                                              'چیزی برای نمایش وجود ندارد',
                                              style: kmediumTextStyle.copyWith(
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        )),
                            ),
                          )),

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
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.h),
                                child: Card(
                                  elevation: 2,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Container(
                                      margin: EdgeInsets.all(2.w),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white,
                                      ),
                                      child: state.allPasswords.isNotEmpty
                                          ? ListTile(
                                              onTap: () {
                                                print(
                                                    state.allPasswords.length);
                                              },
                                              onLongPress: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext ctx) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            'Please Confirm'),
                                                        content: const Text(
                                                            'Are you sure to remove the box?'),
                                                        actions: [
                                                          // The "Yes" button
                                                          TextButton(
                                                              onPressed: () {
                                                                BlocProvider.of<
                                                                            PasswordBloc>(
                                                                        context)
                                                                    .add(DeletePasswordEvent(
                                                                        index));

                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: const Text(
                                                                  'Yes')),
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: const Text(
                                                                  'No'))
                                                        ],
                                                      );
                                                    });
                                              },
                                              title: Text(
                                                // " ${state.allPasswords[index].title}",
                                                " ${state.allPasswords[index].title}",
                                                textAlign: TextAlign.right,
                                                style: kLargeTextStyle.copyWith(
                                                    color: Colors.black87,
                                                    fontSize: 16.sp),
                                              ),
                                              subtitle: Text(
                                                " ${state.allPasswords[index].username}",
                                                textAlign: TextAlign.right,
                                                style:
                                                    kmediumTextStyle.copyWith(
                                                        color: Colors.grey,
                                                        fontSize: 14.sp),
                                              ),
                                              trailing: logoGenerator(
                                                  state.allPasswords[index]),
                                              leading: const Icon(
                                                Icons.arrow_back_ios_new,
                                                size: 25,
                                                color: ksecondColor,
                                              ),
                                            )
                                          : SizedBox.square(
                                              dimension: 50.h,
                                              child: Center(
                                                child: Text(
                                                  '!چیزی برای نمایش وجود ندارد',
                                                  style:
                                                      kmediumTextStyle.copyWith(
                                                          color: Colors.grey),
                                                ),
                                              ),
                                            )),
                                ),
                              );
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
