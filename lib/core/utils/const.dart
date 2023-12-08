import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ramzino/core/services/shared_prefrences_service.dart';
import 'package:ramzino/core/utils/enums.dart';
import 'package:ramzino/features/pasword_feature/data/models/password_model.dart';
import 'package:ramzino/locator.dart';

/////// ui constant

const kmainColor = Color(0xff471069);
const ksecondColor = Color(0xff30c5d2);
const kbuttonColor = Color(0xd500ff87);
const ktextColor = Color(0xffF7EFE5);
// const kbgColor = Color(0xf9FEFEFE);
const kbgColor = Color.fromARGB(255, 249, 249, 249);
const kWhiteColor = Color.fromARGB(255, 255, 255, 255);

TextStyle kLargeTextStyle = TextStyle(
  color: ktextColor,
  fontSize: 30.sp,
  fontWeight: FontWeight.bold,
  fontFamily: 'yekan',
);
TextStyle kmediumTextStyle = TextStyle(
  color: ktextColor,
  fontSize: 16.sp,
  fontWeight: FontWeight.w500,
  fontFamily: 'yekan',
);

const CrossAxisAlignment RcrossAxisAlignment = CrossAxisAlignment.end;
const CrossAxisAlignment LcrossAxisAlignment = CrossAxisAlignment.start;
const MainAxisAlignment RmainAxisAlignment = MainAxisAlignment.end;
const MainAxisAlignment LmainAxisAlignment = MainAxisAlignment.start;

/////////////
const USER_KEY = 'USER_KEY_';
const storageDeviceOpenFirstTime = 'APP_FIRST_OPEN';
late final SharedPreferencesService sharedPreferencesService;
// const _keyApplicationId = '9AJHEJVLMQRGuWBT24C1meVCYLmK2ghQG2RyUFdI';
// const _keyClientKey = '3RiiFBRDjmdcHPzMfd9ORxQSorW0Ak7YcFOB56rv';
// const _keyParseServerUrl = 'https://parseapi.back4app.com';
final secureStorage = FlutterSecureStorage(aOptions: _getAndroidOptions());
const passwordBox = 'PasswordsBox';
late final Box passwordsbox;

//////////////
AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );

Future init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await depInjSetup();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  sharedPreferencesService = await SharedPreferencesService().init();
  final encryptionKeyString = await secureStorage.read(key: 'key');
  if (encryptionKeyString == null) {
    final key = Hive.generateSecureKey();
    await secureStorage.write(
      key: 'key',
      value: base64UrlEncode(key),
    );
  }
  final key = await secureStorage.read(key: 'key');
  final encryptionKeyUint8List = base64Url.decode(key!);
  await Hive.initFlutter();
  Hive.registerAdapter<PasswordModel>(PasswordModelAdapter());
  Hive.registerAdapter<PasswordType>(PasswordTypeAdapter());
  passwordsbox = await Hive.openBox<PasswordModel>(passwordBox,
      encryptionCipher: HiveAesCipher(encryptionKeyUint8List));
  // Hive.registerAdapter(PasswordModelAdapter());
}
