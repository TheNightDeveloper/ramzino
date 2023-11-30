import 'package:ramzino/core/params/password_params.dart';

import 'package:ramzino/core/utils/enums.dart';

import 'package:ramzino/features/auth_feature/presentation/widgets/widgets_resource.dart';
import 'package:ramzino/features/pasword_feature/presentation/bloc/password_bloc.dart';
import 'package:uuid/uuid.dart';

class SearchInput extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  const SearchInput({
    required this.textController,
    required this.hintText,
    Key? key,
  }) : super(key: key);

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
          fillColor: const Color.fromARGB(255, 208, 208, 208),
          hintText: hintText,
          hintTextDirection: TextDirection.rtl,
          hintStyle: const TextStyle(color: Colors.grey),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(18.0)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Color.fromARGB(255, 208, 208, 208), width: 1.0),
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

class ListBuilder extends StatelessWidget {
  final String listTitle, title, subTitle;
  final Image? tileImage;
  final ScrollController scrollController;
  final int itemLen;
  const ListBuilder(
      {required this.listTitle,
      required this.title,
      required this.subTitle,
      required this.itemLen,
      this.tileImage,
      required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: RcrossAxisAlignment,
      children: [
        SizedBox(
          height: 15.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: () {},
                child: Text(
                  'همه',
                  style: kmediumTextStyle.copyWith(color: Colors.black87),
                )),
            Text(
              listTitle,
              style: kLargeTextStyle.copyWith(
                  color: Colors.black87, fontSize: 20.sp),
            ),
          ],
        ),
        ShaderMask(
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
          child: Container(
            margin: EdgeInsets.only(top: 15.h),
            constraints: BoxConstraints(minHeight: 105.h, maxHeight: 220.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              // border: Border.all(
              //     color: kbuttonColor.withOpacity(0.5),
              //     width: 2.h,
              //     strokeAlign: BorderSide.strokeAlignOutside),
            ),
            child: ListView.separated(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
              shrinkWrap: true,
              itemCount: itemLen,
              itemBuilder: (context, index) => Card(
                elevation: 2,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    title: Text(
                      title,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.sp),
                    ),
                    subtitle: Text(
                      subTitle,
                      textAlign: TextAlign.right,
                    ),
                    leading: const Icon(Icons.more_vert),
                    trailing: tileImage,
                  ),
                ),
              ),
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  thickness: 2,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

SliverAppBar sliverAppbar(TextEditingController textEditingController) {
  return SliverAppBar(
    backgroundColor: kbgColor,
    expandedHeight: 300,
    floating: true,
    pinned: true,
    flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 1,
        titlePadding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 5.h),
        centerTitle: true,
        background: Padding(
          padding: EdgeInsets.only(bottom: 30.h),
          child: Image.asset(
            'assets/img/1.png',
            fit: BoxFit.fitHeight,
          ),
        ),
        collapseMode: CollapseMode.parallax,
        title: SearchInput(
            textController: textEditingController, hintText: 'جستجو...')),
  );
}

class FloatActionButton extends StatefulWidget {
  final BuildContext context;
  const FloatActionButton({required this.context});

  @override
  State<FloatActionButton> createState() => _FloatActionButtonState();
}

class _FloatActionButtonState extends State<FloatActionButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            context: context,
            isScrollControlled: true,
            builder: (context) => SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    decoration: const BoxDecoration(
                        color: kbgColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.h, horizontal: 15.w),
                      child: Column(
                        children: [
                          Text(
                            'افزودن رمز ',
                            style: kLargeTextStyle.copyWith(
                                color: Colors.black87, fontSize: 22.sp),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          AddForm(),
                        ],
                      ),
                    ),
                  ),
                ));
      },
      backgroundColor: kbuttonColor,
      child: Icon(
        Icons.add,
        size: 28.h,
      ),
    );
  }
}

class AddForm extends StatefulWidget {
  // final TextEditingController title, username, password, describtion;
  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _describtion = TextEditingController();
  String usernameLabel = '';
  String hint = '';
  TextInputType inputType = TextInputType.text;
  late final PasswordType passwordType;
  bool categorySelected = false;
  List<DropdownMenuItem> items = const [
    DropdownMenuItem(
      value: PasswordType.social,
      child: Text('شبکه اجتماعی'),
    ),
    // DropdownMenuItem(
    //   value: PasswordType.application,
    //   child: Text(
    //     'اپلیکیشن',
    //   ),
    // ),
    DropdownMenuItem(
      value: PasswordType.creditCard,
      child: Text('کارت اعتباری'),
    ),
    DropdownMenuItem(
      value: PasswordType.webSite,
      child: Text('وبسایت'),
    ),
    // DropdownMenuItem(
    //   value: PasswordType.device,
    //   child: Text('دستگاه'),
    // ),
    DropdownMenuItem(
      value: PasswordType.other,
      child: Text('متفرقه'),
    ),
  ];
  //////
  String generateUUID() {
    final uuid = Uuid();
    return uuid.v4();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: RcrossAxisAlignment,
      children: [
        Text(
          'دسته بندی',
          style: kmediumTextStyle.copyWith(color: Colors.black87),
        ),
        Column(
          crossAxisAlignment: RcrossAxisAlignment,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 10.h, top: 10.h),
              child: DropdownButtonFormField(
                items: items,
                onChanged: (value) {
                  setState(() {
                    categorySelected = true;
                  });
                  switch (value) {
                    // case PasswordType.application:
                    //   {}
                    case PasswordType.creditCard:
                      {
                        passwordType = value;
                        usernameLabel = 'شماره کارت';
                        hint = 'شماره کارت خود را وارد کنید';
                        inputType = TextInputType.number;
                      }
                    case PasswordType.social:
                      {
                        passwordType = value;
                        usernameLabel = 'نام کاربری';
                        hint = 'نام کاربری خود را وارد کنید';
                        inputType = TextInputType.emailAddress;
                      }
                    case PasswordType.other:
                      {
                        passwordType = value;
                        usernameLabel = 'نام کاربری';
                        hint = 'نام کاربری خود را وارد کنید';
                        inputType = TextInputType.text;
                      }
                    // case PasswordType.device:
                    //   {}
                    case PasswordType.webSite:
                      {
                        passwordType = value;
                        usernameLabel = 'آدرس وب سایت';
                        hint = 'آدرس سایت  را وارد کنید';
                        inputType = TextInputType.url;
                      }
                  }
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 2.h, horizontal: 7.w),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: ksecondColor)),
                  hintTextDirection: TextDirection.rtl,
                ),
                borderRadius: BorderRadius.circular(15),
                hint: Text(
                  'انتخاب دسته بندی',
                  style: kmediumTextStyle.copyWith(color: Colors.grey),
                ),
                style: kmediumTextStyle.copyWith(
                  color: Colors.black87,
                ),
                dropdownColor: Colors.white,
              ),
            )
          ],
        ),
        categorySelected
            ? Form(
                child: Column(
                children: [
                  BuildTextField(
                      title: 'عنوان',
                      hint: 'عنوان رمز',
                      textEditingController: _title),
                  BuildTextField(
                      title: usernameLabel,
                      hint: hint,
                      textEditingController: _username,
                      inputType: inputType),
                  BuildTextField(
                      title: 'رمز عبور',
                      hint: 'رمز عبور خود را وارد کنید',
                      secureText: true,
                      textEditingController: _password,
                      inputType: TextInputType.visiblePassword),
                  BuildTextField(
                      title: 'توضیحات',
                      hint: 'توضیح مختصر مربوط به رمز',
                      textEditingController: _describtion),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          backgroundColor: kbuttonColor,
                          fixedSize: const Size(200, 50)),
                      onPressed: () {
                        var passParams = PasswordParams(
                            id: generateUUID(),
                            title: _title.text,
                            username: _username.text,
                            password: _password.text,
                            describtion: _describtion.text,
                            type: passwordType);
                        BlocProvider.of<PasswordBloc>(context)
                            .add(AddPasswordEvent(passParams));
                        // print(generateUUID());
                        Navigator.pop(context);
                      },
                      child: Text(
                        'افزودن',
                        style: kmediumTextStyle.copyWith(fontSize: 20.sp),
                      ))
                ],
              ))
            : Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Center(
                  child: Text(
                    'دسته بندی رمز را مشخص کنید',
                    style: kmediumTextStyle.copyWith(color: Colors.black87),
                  ),
                ),
              ),
      ],
    );
  }
}

class PasswordsList extends StatefulWidget {
  const PasswordsList({
    super.key,
    required ScrollController scrollController,
    required this.context,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;
  final BuildContext context;

  @override
  State<PasswordsList> createState() => _PasswordsListState();
}

class _PasswordsListState extends State<PasswordsList> {
  @override
  Widget build(BuildContext context) {
    var bloc = context.read<PasswordBloc>().state;
    return SliverToBoxAdapter(
      child: Column(children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'همه',
                      style: kmediumTextStyle.copyWith(color: Colors.black87),
                    )),
                Text(
                  'شبکه های اجتماعی',
                  style: kLargeTextStyle.copyWith(
                      color: Colors.black87, fontSize: 20.sp),
                ),
              ],
            ),
            ShaderMask(
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
              child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10.h),
                  constraints:
                      BoxConstraints(minHeight: 65.h, maxHeight: 220.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    // border: Border.all(
                    //     color: kbuttonColor.withOpacity(0.5),
                    //     width: 2.h,
                    //     strokeAlign: BorderSide.strokeAlignOutside),
                  ),
                  child: bloc.socialList.isNotEmpty
                      ? ListView.separated(
                          // controller: scrollController,
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 5.h),
                          shrinkWrap: true,
                          itemCount: bloc.socialList.length,
                          itemBuilder: (context, index) => Card(
                            elevation: 2,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                title: Text(
                                  bloc.socialList[index].title!,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp),
                                ),
                                subtitle: Text(
                                  bloc.socialList[index].username!,
                                  textAlign: TextAlign.right,
                                ),
                                leading: const Icon(Icons.more_vert),
                                // trailing: tileImage,
                              ),
                            ),
                          ),
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider(
                              thickness: 2,
                            );
                          },
                        )
                      : Padding(
                          padding: EdgeInsets.only(top: 25.h),
                          child: Text(
                            '!چیزی برای نمایش وجود ندارد',
                            style:
                                kmediumTextStyle.copyWith(color: Colors.grey),
                          ),
                        )),
            ),
          ],
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'همه',
                      style: kmediumTextStyle.copyWith(color: Colors.black87),
                    )),
                Text(
                  'کارت های اعتباری',
                  style: kLargeTextStyle.copyWith(
                      color: Colors.black87, fontSize: 20.sp),
                ),
              ],
            ),
            ShaderMask(
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
              child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10.h),
                  constraints:
                      BoxConstraints(minHeight: 65.h, maxHeight: 220.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    // border: Border.all(
                    //     color: kbuttonColor.withOpacity(0.5),
                    //     width: 2.h,
                    //     strokeAlign: BorderSide.strokeAlignOutside),
                  ),
                  child: bloc.creditCardList.isNotEmpty
                      ? ListView.separated(
                          // controller: scrollController,
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 5.h),
                          shrinkWrap: true,
                          itemCount: bloc.creditCardList.length,
                          itemBuilder: (context, index) => Card(
                            elevation: 2,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                title: Text(
                                  bloc.creditCardList[index].title!,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp),
                                ),
                                subtitle: Text(
                                  bloc.creditCardList[index].username!,
                                  textAlign: TextAlign.right,
                                ),
                                leading: DropDownMenuFb1(
                                ),
                                // trailing: tileImage,
                              ),
                            ),
                          ),
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider(
                              thickness: 2,
                            );
                          },
                        )
                      : Padding(
                          padding: EdgeInsets.only(top: 25.h),
                          child: Text(
                            '!چیزی برای نمایش وجود ندارد',
                            style:
                                kmediumTextStyle.copyWith(color: Colors.grey),
                          ),
                        )),
            ),
          ],
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'همه',
                      style: kmediumTextStyle.copyWith(color: Colors.black87),
                    )),
                Text(
                  'وبسایت ها',
                  style: kLargeTextStyle.copyWith(
                      color: Colors.black87, fontSize: 20.sp),
                ),
              ],
            ),
            ShaderMask(
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
              child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10.h),
                  constraints:
                      BoxConstraints(minHeight: 65.h, maxHeight: 220.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    // border: Border.all(
                    //     color: kbuttonColor.withOpacity(0.5),
                    //     width: 2.h,
                    //     strokeAlign: BorderSide.strokeAlignOutside),
                  ),
                  child: bloc.webSiteList.isNotEmpty
                      ? ListView.separated(
                          // controller: scrollController,
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 5.h),
                          shrinkWrap: true,
                          itemCount: bloc.webSiteList.length,
                          itemBuilder: (context, index) => Card(
                            elevation: 2,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                title: Text(
                                  bloc.webSiteList[index].title!,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp),
                                ),
                                subtitle: Text(
                                  bloc.webSiteList[index].username!,
                                  textAlign: TextAlign.right,
                                ),
                                leading: const Icon(Icons.more_vert),
                                // trailing: tileImage,
                              ),
                            ),
                          ),
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider(
                              thickness: 2,
                            );
                          },
                        )
                      : Padding(
                          padding: EdgeInsets.only(top: 25.h),
                          child: Text(
                            '!چیزی برای نمایش وجود ندارد',
                            style:
                                kmediumTextStyle.copyWith(color: Colors.grey),
                          ),
                        )),
            ),
          ],
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'همه',
                      style: kmediumTextStyle.copyWith(color: Colors.black87),
                    )),
                Text(
                  'متفرقه ها',
                  style: kLargeTextStyle.copyWith(
                      color: Colors.black87, fontSize: 20.sp),
                ),
              ],
            ),
            ShaderMask(
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
              child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10.h),
                  constraints:
                      BoxConstraints(minHeight: 65.h, maxHeight: 220.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    // border: Border.all(
                    //     color: kbuttonColor.withOpacity(0.5),
                    //     width: 2.h,
                    //     strokeAlign: BorderSide.strokeAlignOutside),
                  ),
                  child: bloc.otherList.isNotEmpty
                      ? ListView.separated(
                          // controller: scrollController,
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 5.h),
                          shrinkWrap: true,
                          itemCount: bloc.otherList.length,
                          itemBuilder: (context, index) => Card(
                            elevation: 2,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                title: Text(
                                  bloc.otherList[index].title!,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp),
                                ),
                                subtitle: Text(
                                  bloc.otherList[index].username!,
                                  textAlign: TextAlign.right,
                                ),
                                leading: const Icon(Icons.more_vert),
                                // trailing: tileImage,
                              ),
                            ),
                          ),
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider(
                              thickness: 2,
                            );
                          },
                        )
                      : Padding(
                          padding: EdgeInsets.only(top: 25.h),
                          child: Text(
                            '!چیزی برای نمایش وجود ندارد',
                            style:
                                kmediumTextStyle.copyWith(color: Colors.grey),
                          ),
                        )),
            ),
          ],
        )
      ]),
    );
  }

  Column newMethod(
      {String listTitle = 'ss',
      String title = 'kit',
      String subTitle = 'kdfm',
      int itemLen = 2}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: () {},
                child: Text(
                  'همه',
                  style: kmediumTextStyle.copyWith(color: Colors.black87),
                )),
            Text(
              listTitle,
              style: kLargeTextStyle.copyWith(
                  color: Colors.black87, fontSize: 20.sp),
            ),
          ],
        ),
        ShaderMask(
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
          child: Container(
            margin: EdgeInsets.only(top: 15.h),
            constraints: BoxConstraints(minHeight: 105.h, maxHeight: 220.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              // border: Border.all(
              //     color: kbuttonColor.withOpacity(0.5),
              //     width: 2.h,
              //     strokeAlign: BorderSide.strokeAlignOutside),
            ),
            child: ListView.separated(
              // controller: scrollController,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
              shrinkWrap: true,
              itemCount: itemLen,
              itemBuilder: (context, index) => Card(
                elevation: 2,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    title: Text(
                      title,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.sp),
                    ),
                    subtitle: Text(
                      subTitle,
                      textAlign: TextAlign.right,
                    ),
                    leading: const Icon(Icons.more_vert),
                    // trailing: tileImage,
                  ),
                ),
              ),
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  thickness: 2,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
/*
return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Column(
            children: [
              ListBuilder(
                title: bloc.socialList[index].title!,
                itemLen: bloc.socialList.length,
                listTitle: 'شبکه های اجتماعی ',
                subTitle:bloc.socialList[index].username!,
                // tileImage:
                // AnyLogo.media.instagram.image(height: 40, width: 40),
                scrollController: widget._scrollController,
              ),
              ListBuilder(
                title: bloc.creditCardList[index].title!,
                itemLen: bloc.creditCardList.length,
                listTitle: 'کارت های اعتباری',
                subTitle: bloc.creditCardList[index].username!,
                // tileImage:
                // AnyLogo.media.instagram.image(height: 40, width: 40),
                scrollController: widget._scrollController,
              ),
              ListBuilder(
                title: bloc.webSiteList[index].title!,
                itemLen: bloc.webSiteList.length,
                listTitle: 'وبسایت ها',
                subTitle: bloc.webSiteList[index].username!,
                // tileImage:
                // AnyLogo.media.instagram.image(height: 40, width: 40),
                scrollController: widget._scrollController,
              ),
              ListBuilder(
                title: bloc.otherList[index].title!,
                itemLen: bloc.otherList.length,
                listTitle: 'متفرقه ها',
                subTitle: bloc.otherList[index].username!,
                // tileImage:
                // AnyLogo.media.instagram.image(height: 40, width: 40),
                scrollController: widget._scrollController,
              )
            ],
          );
        },
        childCount: 1
      ),
    );
          */
