import 'widgets_resource.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({required this.context});
  final BuildContext context;

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool visibilityOff = true;
  bool validate = false;

  final TextEditingController _emailTextControll = TextEditingController();
  final TextEditingController _passwordTextControll = TextEditingController();
  final TextEditingController _confirmPasswordTextControll =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: RcrossAxisAlignment,
            children: [
              Text(
                'نام کاربری',
                style: kmediumTextStyle,
              ),
              SizedBox(
                height: 10.h,
              ),

              /// email form
              TextFormField(
                controller: _emailTextControll,
                onChanged: (value) {},
                keyboardType: TextInputType.text,
                textDirection: TextDirection.rtl,
                cursorColor: ksecondColor,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(right: 11.w),
                    hintText: 'نام کاربری خود را وارد کنید',
                    hintStyle: kmediumTextStyle.copyWith(color: Colors.grey),
                    hintTextDirection: TextDirection.rtl,
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: ksecondColor))),
              ),
            ],
          ),
        ),

        /// password form
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 5.h),
          child: Column(
            crossAxisAlignment: RcrossAxisAlignment,
            children: [
              Text(
                'رمز عبور',
                style: kmediumTextStyle,
              ),
              SizedBox(
                height: 10.h,
              ),
              TextFormField(
                onChanged: (value) {},
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                   
                      validate = false;
                    
                    return 'رمز خود را وارد نمایید';
                  } else if (value.length < 5) {
                    
                      validate = false;
                    
                    return 'رمز عبور باید حداقل 5 حرف باشد.';
                  }
                  
                    validate = true;
                 
                  return null;
                },
                controller: _passwordTextControll,
                obscureText: visibilityOff,
                keyboardType: TextInputType.text,
                textDirection: TextDirection.rtl,
                cursorColor: ksecondColor,
                decoration: InputDecoration(
                    errorStyle: kmediumTextStyle.copyWith(
                        color: Colors.redAccent, fontSize: 13.sp),
                    contentPadding: EdgeInsets.zero,
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          visibilityOff = !visibilityOff;
                        });
                      },
                      child: Icon(visibilityOff
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                    suffixIconColor: Colors.grey,
                    hintText: 'رمز عبور خود را وارد کنید',
                    hintStyle: kmediumTextStyle.copyWith(color: Colors.grey),
                    hintTextDirection: TextDirection.rtl,
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: ksecondColor)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.redAccent)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.red))),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 5.h),
          child: Column(
            crossAxisAlignment: RcrossAxisAlignment,
            children: [
              Text(
                'تایید رمز عبور',
                style: kmediumTextStyle,
              ),
              SizedBox(
                height: 10.h,
              ),
              TextFormField(
                onChanged: (value) {},
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value != _passwordTextControll.text) {
                    return 'رمز وارد شده با یکدیگر مطابقت ندارند';
                  }
                  return null;
                },
                controller: _confirmPasswordTextControll,
                obscureText: visibilityOff,
                keyboardType: TextInputType.text,
                textDirection: TextDirection.rtl,
                cursorColor: ksecondColor,
                decoration: InputDecoration(
                    errorStyle: kmediumTextStyle.copyWith(
                        color: Colors.redAccent, fontSize: 13.sp),
                    contentPadding: EdgeInsets.zero,
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          visibilityOff = !visibilityOff;
                        });
                      },
                      child: Icon(visibilityOff
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                    suffixIconColor: Colors.grey,
                    hintText: 'رمز عبور خود را مجدد وارد کنید',
                    hintStyle: kmediumTextStyle.copyWith(color: Colors.grey),
                    hintTextDirection: TextDirection.rtl,
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: ksecondColor)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.redAccent)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.red))),
              ),
            ],
          ),
        ),
        TextButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.loginPage);
            },
            child: Text(
              'قبلا ثبت نام کردید؟وارد شوید',
              style: kmediumTextStyle.copyWith(
                decoration: TextDecoration.underline,
                fontSize: 13.sp,
              ),
            )),
        SizedBox(
          height: 50.h,
        ),

        /// button
        BlocConsumer<AuthBloc, AuthState>(
          listener: (_, state) {
            if (state is SignedUpState) {
              Fluttertoast.showToast(msg: "ثبت نام با موفقیت انجام شد");
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutes.loginPage, (route) => false);
            }else if (state is ErrorAuthState) {
              Fluttertoast.showToast(msg: state.message);
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutes.loginPage, (route) => false);
            }
          },
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(
                child: CircularProgressIndicator(color: kbuttonColor),
              );
            }
            return mediumSizeButton(
                context: context,
                title: 'ثبت نام',
                callback: () {
                  if (validate) {
                    BlocProvider.of<AuthBloc>(context).add(RegisterEvent(
                        userParams: UserParams(
                            username: _emailTextControll.text,
                            password: _passwordTextControll.text,
                         )));
                  } else {
                    Fluttertoast.showToast(
                        msg: 'نام کاربری و رمز عبور را وارد کنید');
                  }
                });
          },
        )
      ],
    ));
  }
}
