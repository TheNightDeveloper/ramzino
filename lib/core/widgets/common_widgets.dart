import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/const.dart';

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
   BuildTextField({required this.title, required this.hint, required this.textEditingController, this.inputType=TextInputType.text, this.secureText});
  final String title, hint;
  final TextEditingController textEditingController;
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
            obscureText: widget.secureText??false,
            controller: widget.textEditingController,
            onChanged: (value) {},
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
                      child: Icon(
                          widget.secureText! ? Icons.visibility_off : Icons.visibility),
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
  const DropDownMenuFb1(
      {this.color = Colors.white,
      this.icon = const Icon(
        Icons.more_vert,
        color: Colors.black87,
      ),
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: color,
      icon: icon,
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        const PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.add, color:Colors.black87),
            title: Text('Add video'),
          ),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem(child: Text('حذف')),
        const PopupMenuItem(child: Text('ویرایش')),
      ],
    );
  }
}