import 'package:hive_flutter/hive_flutter.dart';

part 'enums.g.dart';

@HiveType(typeId: 2)
enum PasswordType {
  @HiveField(0)
  social,
  @HiveField(1)
  // application,
  // @HiveField(2)
  creditCard,
  @HiveField(2)
  webSite,
  @HiveField(3)
  // device,
  // @HiveField(5)
  other
}