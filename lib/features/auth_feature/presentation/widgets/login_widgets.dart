import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

import 'widgets_resource.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool visibilityOff = true;
  bool validate = false;
  final TextEditingController _emailTextControll = TextEditingController();
  final TextEditingController _passwordTextControll = TextEditingController();

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
        TextButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.registerPage);
            },
            child: Text(
              'حساب کاربری ندارید؟ ثبت نام کنید',
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
            if (state is SignedInState) {
              Fluttertoast.showToast(msg: "ورود با موفقیت انجام شد");
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutes.mainPage, (route) => false);
            } else if (state is ErrorAuthState) {
              Fluttertoast.showToast(msg: state.message);
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutes.loginPage, (route) => false);
            } else if (state is FingerPrintAuthState) {
              Fluttertoast.showToast(msg: "ورود با موفقیت انجام شد");
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutes.mainPage, (route) => false);
            }
          },
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: kbuttonColor,
                ),
              );
            }
            return Column(
              children: [
                mediumSizeButton(
                    context: context,
                    title: 'ورود به حساب',
                    callback: () {
                      if (validate) {
                        BlocProvider.of<AuthBloc>(context).add(LoginEvent(
                            userParams: UserParams(
                          username: _emailTextControll.text,
                          password: _passwordTextControll.text,
                        )));
                      } else {
                        Fluttertoast.showToast(
                            msg: 'نام کاربری و رمز عبور را وارد کنید');
                      }
                    }),
                SizedBox(
                  height: 15.h,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      side: const BorderSide(color: kbuttonColor, width: 2),
                      minimumSize:
                          Size(MediaQuery.sizeOf(context).width * 0.75, 40.h)),
                  onPressed: () {
                    LocalAuthentication authentication = LocalAuthentication();
                    BlocProvider.of<AuthBloc>(context)
                        .add(FingerPrintAuthEvent(auth: authentication));
                  },
                  icon: const Icon(
                    Icons.fingerprint,
                    color: ktextColor,
                  ),
                  label: Text(
                    'ورود با شناسایی اثر انگشت',
                    style: kmediumTextStyle.copyWith(fontSize: 18.sp),
                  ),
                )
              ],
            );
          },
        ),
      ],
    ));
  }
}
/*
Widget buildTextField(
    {String? title, String? hintTxt, void Function(String)? onChanged}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
    child: Column(
      crossAxisAlignment: RcrossAxisAlignment,
      children: [
        Text(
          title!,
          style: kmediumTextStyle,
        ),
        SizedBox(
          height: 10.h,
        ),
        TextFormField(
          onChanged: onChanged,
          keyboardType: TextInputType.text,
          textDirection: TextDirection.rtl,
          cursorColor: ksecondColor,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(right: 11.w),
              hintText: hintTxt,
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
  );
}

class BuildPasswordTextField extends StatefulWidget {
  final String? title, hintTxt;
  final void Function(String)? onChanged;

  BuildPasswordTextField({this.title, this.hintTxt, this.onChanged});

  @override
  State<BuildPasswordTextField> createState() => _BuildPasswordTextField();
}

class _BuildPasswordTextField extends State<BuildPasswordTextField> {
  bool visibilityOff = true;
  final TextEditingController _passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 5.h),
      child: Column(
        crossAxisAlignment: RcrossAxisAlignment,
        children: [
          Text(
            widget.title!,
            style: kmediumTextStyle,
          ),
          SizedBox(
            height: 10.h,
          ),
          TextFormField(
            onChanged: widget.onChanged,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value!.isEmpty) {
                return 'رمز خود را وارد نمایید';
              } else if (value.length < 5) {
                return 'رمز عبور باید حداقل 5 حرف باشد.';
              }
              return null;
            },
            controller: _passwordcontroller,
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
                  child: Icon(
                      visibilityOff ? Icons.visibility_off : Icons.visibility),
                ),
                suffixIconColor: Colors.grey,
                hintText: widget.hintTxt,
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
    );
  }
}
*/
/*

First, you need to add the local_auth package to your pubspec.yaml file.
yaml
Copy code
dependencies:
 flutter:
    sdk: flutter
 local_auth: ^1.1.6
Next, you need to import the package in your dart file.
dart
Copy code
import 'package:local_auth/local_auth.dart';
Initialize the LocalAuthentication object.
dart
Copy code
final LocalAuthentication auth = LocalAuthentication();
Before calling the authenticateWithBiometrics method, check if the device supports biometrics and if the user has any biometrics enrolled.
dart
Copy code
bool isBiometricAvailable = false;

try {
 isBiometricAvailable = await auth.canCheckBiometrics;
} catch (e) {
 print(e);
}

if (!isBiometricAvailable) {
 print("Device doesn't support biometrics or no biometrics are enrolled.");
 return;
}
Call the authenticateWithBiometrics method with the localizedReason parameter, which will be displayed to the user.
dart
Copy code
final List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();

final String reason = 'Please authenticate yourself to proceed';

try {
 bool authenticated = await auth.authenticateWithBiometrics(
      localizedReason: reason,
      useErrorDialogs: true,
      stickyAuth: false);

 if (authenticated) {
    print('User authenticated successfully');
 } else {
    print('User did not authenticate');
 }
} catch (e) {
 print(e);
}
Please note that the code provided is a simplified example. In a real-world scenario, you should consider error handling and the user experience when implementing biometric authentication.
 */
