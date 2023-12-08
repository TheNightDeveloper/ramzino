import 'package:ramzino/features/auth_feature/presentation/widgets/widgets_resource.dart';

import '../../features/pasword_feature/business/entities/password_entity.dart';
import '../../features/pasword_feature/presentation/bloc/password_bloc.dart';
import '../params/password_params.dart';
import '../utils/enums.dart';

ElevatedButton mediumSizeButton(
    {BuildContext? context, String? title, void Function()? callback}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: kbuttonColor,
          minimumSize: Size(MediaQuery.sizeOf(context!).width * 0.75, 40.h)),
      onPressed: callback,
      child: Text(
        title!,
        style: kmediumTextStyle.copyWith(fontSize: 18.sp),
      ));
}

class BuildTextField extends StatefulWidget {
  BuildTextField(
      {required this.title,
      required this.hint,
      this.textEditingController,
      this.inputType = TextInputType.text,
      this.secureText,
      this.onChanged,
      this.initialText});
  final String title, hint;
  final String? initialText;
  final void Function(String)? onChanged;
  final TextEditingController? textEditingController;
  final TextInputType inputType;
  bool? secureText;

  @override
  State<BuildTextField> createState() => _BuildTextFieldState();
}

class _BuildTextFieldState extends State<BuildTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: RcrossAxisAlignment,
        children: [
          Text(
            widget.title,
            style: kmediumTextStyle.copyWith(color: Colors.black87),
          ),
          SizedBox(
            height: 10.h,
          ),

          /// title form
          TextFormField(
            initialValue: widget.initialText,
            obscureText: widget.secureText ?? false,
            controller: widget.initialText == null
                ? widget.textEditingController
                : null,
            onChanged: widget.onChanged,
            keyboardType: widget.inputType,
            textDirection: TextDirection.rtl,
            cursorColor: ksecondColor,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(right: 11.w),
              hintText: widget.hint,
              hintStyle: kmediumTextStyle.copyWith(color: Colors.grey),
              hintTextDirection: TextDirection.rtl,
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: ksecondColor)),
              suffixIcon: widget.secureText != null
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          // print(secureText);
                          widget.secureText = !widget.secureText!;
                        });
                      },
                      child: Icon(widget.secureText!
                          ? Icons.visibility_off
                          : Icons.visibility),
                    )
                  : null,
              suffixIconColor: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class DropDownMenuFb1 extends StatelessWidget {
  final Color color;
  final Widget icon;
  final void Function()? onDelete, onAddtoMostUse;
  final String mostUseTitle;
  final PasswordEntity? passwordEntity;
  const DropDownMenuFb1(
      {this.passwordEntity,
      this.color = Colors.white,
      this.icon = const Icon(
        Icons.more_vert,
        color: Colors.black87,
      ),
      Key? key,
      this.onAddtoMostUse,
      this.onDelete,
      required this.mostUseTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: color,
      icon: icon,
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        PopupMenuItem(
          child: ListTile(
            onTap: onAddtoMostUse,
            trailing: const Icon(Icons.add, color: kbuttonColor),
            title: Text(
              mostUseTitle,
              style: kmediumTextStyle.copyWith(
                  color: Colors.black87, fontSize: 13.sp),
            ),
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
            child: ListTile(
                onTap: onDelete,
                trailing: const Icon(Icons.remove, color: kbuttonColor),
                title: Text('حذف',
                    style: kmediumTextStyle.copyWith(
                        color: Colors.black87, fontSize: 13.sp)))),
        const PopupMenuDivider(),
        PopupMenuItem(
            child: ListTile(
                onTap: () {
                  Navigator.pop(context);

                  /// UPDATE / EDIT PASSWORD SCREEN
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
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
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
                                      'ویرایش رمز ',
                                      style: kLargeTextStyle.copyWith(
                                          color: Colors.black87,
                                          fontSize: 22.sp),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    _EditForm(password: passwordEntity!),
                                  ],
                                ),
                              ),
                            ),
                          ));
                },
                trailing: const Icon(Icons.edit, color: kbuttonColor),
                title: Text('ویرایش',
                    style: kmediumTextStyle.copyWith(
                        color: Colors.black87, fontSize: 13.sp)))),
      ],
    );
  }
}

class _EditForm extends StatefulWidget {
  const _EditForm({required this.password});
  final PasswordEntity password;
  @override
  State<_EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<_EditForm> {
  String _editedTitle = '';
  String _editedUsername = '';
  String _editedPassword = '';
  String _editedDescribtion = '';
  String usernameLabel = '';
  String hint = '';
  PasswordType? passwordType;
  TextInputType inputType = TextInputType.text;
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
  @override
  Widget build(BuildContext context) {
    // PasswordType passwordType = widget.password.type!;

    // _title.text = widget.password.title!;
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
                value: widget.password.type,
                onChanged: (value) {
                  switch (value) {
                    // case PasswordType.application:
                    //   {}
                    case PasswordType.creditCard:
                      {
                        setState(() {
                          passwordType = value;
                          usernameLabel = 'شماره کارت';
                          hint = '0000-0000-0000-0000';
                          inputType = TextInputType.number;
                        });
                      }
                    case PasswordType.social:
                      {
                        setState(() {
                          passwordType = value;
                          usernameLabel = 'نام کاربری';
                          hint = 'نام کاربری خود را وارد کنید';
                          inputType = TextInputType.emailAddress;
                        });
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
        Form(
            child: Column(
          children: [
            BuildTextField(
              title: 'عنوان',
              hint: 'عنوان رمز',
              initialText: widget.password.title,
              onChanged: (value) {
                setState(() {
                  _editedTitle = value.trim();
                });
              },
            ),
            BuildTextField(
                title: usernameLabel,
                hint: hint,
                initialText: widget.password.username,
                onChanged: (value) {
                  setState(() {
                    _editedUsername = value.trim();
                  });
                },
                inputType: inputType),
            BuildTextField(
                title: 'رمز عبور',
                hint: 'رمز عبور خود را وارد کنید',
                secureText: true,
                initialText: widget.password.password,
                onChanged: (value) {
                  setState(() {
                    _editedPassword = value.trim();
                  });
                },
                inputType: TextInputType.visiblePassword),
            BuildTextField(
              title: 'توضیحات',
              hint: 'توضیح مختصر مربوط به رمز',
              onChanged: (value) {
                setState(() {
                  _editedDescribtion = value.trim();
                });
              },
              initialText: widget.password.describtion,
            ),
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
                  /// if user doesn't change any field , the old value will be set.///
                  var passParams = PasswordParams(
                      id: widget.password.id,
                      title: _editedTitle == ''
                          ? widget.password.title
                          : _editedTitle,
                      username: _editedUsername == ''
                          ? widget.password.username
                          : _editedUsername,
                      password: _editedPassword == ''
                          ? widget.password.password
                          : _editedPassword,
                      describtion: _editedDescribtion == ''
                          ? widget.password.describtion
                          : _editedDescribtion,
                      type: passwordType??widget.password.type);
                  BlocProvider.of<PasswordBloc>(context)
                      .add(UpdatePasswordEvent(passParams));
                  // print(generateUUID());
                  Navigator.pop(context);
                },
                child: Text(
                  'ویرایش',
                  style: kmediumTextStyle.copyWith(fontSize: 20.sp),
                ))
          ],
        ))
      ],
    );
  }
}
