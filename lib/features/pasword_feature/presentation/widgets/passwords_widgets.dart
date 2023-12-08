import 'package:flutter/services.dart';
import 'package:ramzino/core/params/password_params.dart';
import 'package:ramzino/features/auth_feature/presentation/widgets/widgets_resource.dart';
import 'package:ramzino/features/pasword_feature/business/entities/password_entity.dart';
import 'package:ramzino/features/pasword_feature/skeleton/page_resources.dart';
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
                          const AddForm(),
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
  const AddForm({super.key});

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
  late PasswordType passwordType;
  bool categorySelected = false;
  List<DropdownMenuItem> items = const [
    DropdownMenuItem(
      value: PasswordType.social,
      child: Text('شبکه اجتماعی'),
    ),
    DropdownMenuItem(
      value: PasswordType.creditCard,
      child: Text('کارت اعتباری'),
    ),
    DropdownMenuItem(
      value: PasswordType.webSite,
      child: Text('وبسایت'),
    ),
    DropdownMenuItem(
      value: PasswordType.other,
      child: Text(
        'متفرقه',
      ),
    ),
  ];
  //////
  String generateUUID() {
    final uuid = const Uuid();
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
                        hint = '0000-0000-0000-0000';
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
                      borderSide: const BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: ksecondColor)),
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
  });

  final BuildContext context;

  @override
  State<PasswordsList> createState() => _PasswordsListState();
}

class _PasswordsListState extends State<PasswordsList> {
  bool _socialListExpanded = false;
  bool _creditCardListExpanded = false;
  bool _webSiteListExpanded = false;
  bool _otherListExpanded = false;
  bool _passwordVisibility = false;

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

  // ExpansionTileController expansionKey = ExpansionTileController();

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<PasswordBloc>().state;
    return SliverToBoxAdapter(
      child: Column(children: [
        /// SOCIAL LIST
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        _socialListExpanded = !_socialListExpanded;
                      });
                    },
                    child: Text(
                      _socialListExpanded ? 'بستن' : 'مشاهده همه',
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
                  stops: [0.0, 0.10, 0.90, 1.0],
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstOut,
              child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5.h),
                  constraints: BoxConstraints(
                      minHeight: 50.h,
                      maxHeight:
                          _socialListExpanded ? double.maxFinite : 220.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: bloc.socialList.isNotEmpty
                      ? ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                              horizontal: 1.w, vertical: 2.h),
                          shrinkWrap: true,
                          itemCount: bloc.socialList.length,
                          itemBuilder: (context, index) => Card(
                            elevation: 2,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            ///// EXPANSION TILE
                            child: ExpansionTile(
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
                              leading: DropDownMenuFb1(
                                  passwordEntity: bloc.socialList[index],
                                  mostUseTitle:
                                      bloc.socialList[index].isMostUse!
                                          ? 'حذف از پرکاربردها'
                                          : 'افزودن به پرکاربردها',
                                  // onUpdate: ()=>UpdatePasswordForm(password:bloc.socialList[index]),
                                  onDelete: () {
                                    BlocProvider.of<PasswordBloc>(context).add(
                                        DeletePasswordEvent(
                                            passID:
                                                bloc.socialList[index].id!));
                                    Navigator.pop(context);
                                  },
                                  onAddtoMostUse: () {
                                    BlocProvider.of<PasswordBloc>(context).add(
                                        AddToMostUseEvent(
                                            passId:
                                                bloc.socialList[index].id!));
                                    Navigator.pop(context);
                                  }

                                  /// Add to Mose Use list

                                  ),
                              trailing: logoGenerator(bloc.socialList[index]),
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
                                          color: kbuttonColor.withOpacity(0.5),
                                        ),
                                        onPressed: () async {
                                          await Clipboard.setData(ClipboardData(
                                                  text: bloc.socialList[index]
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
                                          color: kbuttonColor.withOpacity(0.6),
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
                                            ? bloc.socialList[index].password!
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
                                      bloc.socialList[index].describtion!,
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                      style: kmediumTextStyle.copyWith(
                                          color: Colors.black87),
                                    ),
                                  ),
                                )
                              ],
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

        /// CREDIT CARD LIST
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        _creditCardListExpanded = !_creditCardListExpanded;
                      });
                    },
                    child: Text(
                      _creditCardListExpanded ? 'بستن' : 'مشاهده همه',
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
                  stops: [0.0, 0.13, 0.92, 1.0],
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstOut,
              child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10.h),
                  constraints: BoxConstraints(
                      minHeight: 65.h,
                      maxHeight:
                          _creditCardListExpanded ? double.maxFinite : 250.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: bloc.creditCardList.isNotEmpty
                      ? ListView.separated(
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
                            child: ExpansionTile(
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
                                  passwordEntity: bloc.creditCardList[index],
                                  mostUseTitle:
                                      bloc.creditCardList[index].isMostUse!
                                          ? 'حذف از پرکاربردها'
                                          : 'افزودن به پرکاربردها',
                                  onDelete: () {
                                    BlocProvider.of<PasswordBloc>(context).add(
                                        DeletePasswordEvent(
                                            passID: bloc
                                                .creditCardList[index].id!));
                                    Navigator.pop(context);
                                  },
                                  onAddtoMostUse: () {
                                    BlocProvider.of<PasswordBloc>(context).add(
                                        AddToMostUseEvent(
                                            passId: bloc
                                                .creditCardList[index].id!));
                                    Navigator.pop(context);
                                  }),
                              trailing:
                                  logoGenerator(bloc.creditCardList[index]),
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
                                          color: kbuttonColor.withOpacity(0.5),
                                        ),
                                        onPressed: () async {
                                          await Clipboard.setData(ClipboardData(
                                                  text: bloc
                                                      .creditCardList[index]
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
                                          color: kbuttonColor.withOpacity(0.6),
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
                                            ? bloc
                                                .creditCardList[index].password!
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
                                      bloc.creditCardList[index].describtion!,
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                      style: kmediumTextStyle.copyWith(
                                          color: Colors.black87),
                                    ),
                                  ),
                                )
                              ],
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

        /// WEBSITE LIST
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        _webSiteListExpanded = !_webSiteListExpanded;
                      });
                    },
                    child: Text(
                      _webSiteListExpanded ? 'بستن' : 'مشاهده همه',
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
                  constraints: BoxConstraints(
                      minHeight: 65.h,
                      maxHeight:
                          _webSiteListExpanded ? double.maxFinite : 220.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: bloc.webSiteList.isNotEmpty
                      ? ListView.separated(
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
                            child: ExpansionTile(
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
                              leading: DropDownMenuFb1(
                                  passwordEntity: bloc.webSiteList[index],
                                  mostUseTitle:
                                      bloc.webSiteList[index].isMostUse!
                                          ? 'حذف از پرکاربردها'
                                          : 'افزودن به پرکاربردها',
                                  onDelete: () {
                                    BlocProvider.of<PasswordBloc>(context).add(
                                        DeletePasswordEvent(
                                            passID:
                                                bloc.webSiteList[index].id!));
                                    Navigator.pop(context);
                                  },
                                  onAddtoMostUse: () {
                                    BlocProvider.of<PasswordBloc>(context).add(
                                        AddToMostUseEvent(
                                            passId:
                                                bloc.webSiteList[index].id!));
                                    Navigator.pop(context);
                                  }),
                              trailing: logoGenerator(bloc.webSiteList[index]),
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
                                          color: kbuttonColor.withOpacity(0.5),
                                        ),
                                        onPressed: () async {
                                          await Clipboard.setData(ClipboardData(
                                                  text: bloc.webSiteList[index]
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
                                          color: kbuttonColor.withOpacity(0.6),
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
                                            ? bloc.webSiteList[index].password!
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
                                      bloc.webSiteList[index].describtion!,
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                      style: kmediumTextStyle.copyWith(
                                          color: Colors.black87),
                                    ),
                                  ),
                                )
                              ],
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

        /// OTHER LIST
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        _otherListExpanded = !_otherListExpanded;
                      });
                    },
                    child: Text(
                      _otherListExpanded ? 'بستن' : 'مشاهده همه',
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
                  constraints: BoxConstraints(
                      minHeight: 65.h,
                      maxHeight: _otherListExpanded ? double.maxFinite : 220.h),
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
                            child: ExpansionTile(
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
                              leading: DropDownMenuFb1(
                                passwordEntity: bloc.otherList[index],
                                onAddtoMostUse: () {
                                  BlocProvider.of<PasswordBloc>(context).add(
                                      AddToMostUseEvent(
                                          passId: bloc.otherList[index].id!));
                                  Navigator.pop(context);
                                },
                                mostUseTitle: bloc.otherList[index].isMostUse!
                                    ? 'حذف از پرکاربردها'
                                    : 'افزودن به پرکاربردها',
                                onDelete: () {
                                  BlocProvider.of<PasswordBloc>(context).add(
                                      DeletePasswordEvent(
                                          passID: bloc.otherList[index].id!));
                                  Navigator.pop(context);
                                },
                              ),
                              trailing: logoGenerator(bloc.otherList[index]),
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
                                          color: kbuttonColor.withOpacity(0.5),
                                        ),
                                        onPressed: () async {
                                          await Clipboard.setData(ClipboardData(
                                                  text: bloc.otherList[index]
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
                                          color: kbuttonColor.withOpacity(0.6),
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
                                            ? bloc.otherList[index].password!
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
                                      bloc.otherList[index].describtion!,
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                      style: kmediumTextStyle.copyWith(
                                          color: Colors.black87),
                                    ),
                                  ),
                                )
                              ],
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
}
