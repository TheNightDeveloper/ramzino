import 'package:ramzino/features/pasword_feature/skeleton/page_resources.dart';

class PasswordParams {
  final String? title;
  final PasswordType? type;
  final String? id;
  final String? username;
  final String? describtion;
  final String? password;
  const PasswordParams(
      {this.username,
      this.describtion,
      this.title,
      this.password,
      this.id,
      this.type});
}
